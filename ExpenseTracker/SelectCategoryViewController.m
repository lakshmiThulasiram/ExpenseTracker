//
//  SelectCategoryViewController.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "SelectCategoryViewController.h"
#import "CategoryTableViewCell.h"
#import "Category+CoreDataProperties.h"
#define kCategoryItems @[@"Food",@"Lifestyle",@"Grocery",@"Dining",@"Shopping",@"Medical",@"Clothing",@"HomeNeeds",@"Others"]
@interface SelectCategoryViewController ()
@property (nonatomic, strong) NSArray   *categoryData;
@property (nonatomic, strong) NSMutableArray   *selectedCategory;

@end

@implementation SelectCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedCategory = [NSMutableArray array];
//    [self fetchCategoryData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate selectedCategories:[self.selectedCategory mutableCopy]];
    }];
}
#pragma mark-
#pragma TableView delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [kCategoryItems count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryTableViewCell *cell      = [tableView dequeueReusableCellWithIdentifier:@"category"];
    if (cell == nil) {
        cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"category"];
    }
    cell.categoryLabel.text          = [kCategoryItems objectAtIndex:indexPath.row];
    cell.checkMarkLabel.hidden       = YES;
    if([self.selectedCategory containsObject:[kCategoryItems objectAtIndex:indexPath.row]])
    {
        cell.checkMarkLabel.hidden = NO;
    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([self.selectedCategory containsObject:[kCategoryItems objectAtIndex:indexPath.row]])
    {
        cell.checkMarkLabel.hidden = YES;
        [self.selectedCategory removeObject:[kCategoryItems objectAtIndex:indexPath.row]];
    }
    else{
        cell.checkMarkLabel.hidden = NO;
        [self.selectedCategory addObject:[kCategoryItems objectAtIndex:indexPath.row]];
    }
}
#pragma mark-

//-(void)fetchCategoryData
//{
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:kCategory inManagedObjectContext:[self managedObjectContext]];
//    [request setEntity:entity];
//    
//    
//    NSError *errorFetch = nil;
//    self.categoryData = [[self managedObjectContext] executeFetchRequest:request error:&errorFetch];
//    if([self.categoryData count] > 0)
//    {
//        [self.categoryTable reloadData];
//    }
//    else{
//        [self addCategoryIntoDB];
//        [self fetchCategoryData];
//    }
//    
//}

//-(void)addCategoryIntoDB
//{
//    NSManagedObjectContext *context = [self managedObjectContext];
//    
//    // Create a new managed object
//    for(NSString *category in kCategoryItems)
//    {
//        Category *newCategory = [NSEntityDescription insertNewObjectForEntityForName:kCategory inManagedObjectContext:context];
//        newCategory.category    = category;
//
//    }
//    NSError *error = nil;
//    // Save the object to persistent store
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
//
//}
@end
