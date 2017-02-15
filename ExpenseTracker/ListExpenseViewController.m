//
//  ListExpenseViewController.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "ListExpenseViewController.h"
#import "ExpenseListTableViewCell.h"
#import "ExpenseViewController.h"

@interface ListExpenseViewController ()<AddExpenseDelegate>
@property (nonatomic, strong) NSArray       *expenseData;
@end

@implementation ListExpenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchExpenseData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender
{
    NSLog(@"preparing");
    ExpenseViewController *expenseVC    = segue.destinationViewController;
    expenseVC.delegate                  = self;
}
#pragma mark-
#pragma Actions

- (IBAction)addExpenseAction:(id)sender {
    [self performSegueWithIdentifier:@"AddExpense" sender:self];
}
- (IBAction)editAction:(id)sender {
    self.expenseTableView.editing = !self.expenseTableView.editing;
    if(self.expenseTableView.editing)
    {
        [self.editButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    else{
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];

    }

}
#pragma mark-
#pragma TableView delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.expenseData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpenseListTableViewCell *cell      = [tableView dequeueReusableCellWithIdentifier:@"expense"];
    if (cell == nil) {
        cell = [[ExpenseListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"expense"];
    }
    NSString *categoryStr = @"";
    Expense     *expense                = [self.expenseData objectAtIndex:indexPath.row];
    cell.descriptionLabel.text          = expense.expenseDescription;
    for (Category *category in [expense.category allObjects]) {
        categoryStr = [NSString stringWithFormat:@"%@ %@",categoryStr,category.category];
    
    }
    cell.dateLabel.text                 = [self striongFromDate:expense.date];
    cell.categoryLabel.text             = categoryStr;
    cell.amountLabel.text               = [NSString stringWithFormat:@"%.2f", expense.amount];
    return cell;
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteRecord:[self.expenseData objectAtIndex:indexPath.row]];
        [self fetchExpenseData];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark-

-(void)fetchExpenseData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kExpense inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"user == %@",[[CacheManager sharedInstance] currentUser]]];

    
    NSError *errorFetch = nil;
    self.expenseData = [[self managedObjectContext] executeFetchRequest:request error:&errorFetch];
    if([self.expenseData count] > 0)
    {
        self.errorLabel.hidden= YES;
        self.expenseTableView.hidden = NO;
        [self.expenseTableView reloadData];
    }
    else
    {
        self.errorLabel.hidden = NO;
        self.expenseTableView.hidden = YES;
    }
}
-(void)deleteRecord:(Expense *)expenseToDelete{
    [[self managedObjectContext] deleteObject:expenseToDelete];
    NSError *error = nil;
    // Save the object to persistent store
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}
@end
