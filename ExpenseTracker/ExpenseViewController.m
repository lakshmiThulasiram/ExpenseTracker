//
//  ExpenseViewController.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "ExpenseViewController.h"
#import "SelectCategoryViewController.h"

@interface ExpenseViewController ()<SelectCategoryDelegate>

@end

@implementation ExpenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"selectCategory"])
    {
        SelectCategoryViewController *categoryVC    = segue.destinationViewController;
        categoryVC.delegate                  = self;
    }
}
#pragma mark- 
#pragma mark SelectCategoryDelegate
-(void)selectedCategories:(NSArray *)categories
{
    self.categoryTextbox.text   =   [categories componentsJoinedByString:@","];
}
- (IBAction)addExpenseAction:(id)sender {
    
    if([self areInputsValid])
    {
        [self insertExpenseToDB];
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate fetchExpenseData];
        }];
    }
    
        
   
}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate fetchExpenseData];
    }];

}
#pragma Helper
-(void)insertExpenseToDB
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    Expense *newExpense = [NSEntityDescription insertNewObjectForEntityForName:@"Expense" inManagedObjectContext:context];
    newExpense.amount    = [self.amountTextbox.text doubleValue];
    newExpense.expenseDescription = self.expenseDescriptionTextbox.text;
      
    
    newExpense.date              = [self getDateIgnorinbgTime:self.datePicker.date];
    
    Category *category = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:context];
    category.category   = self.categoryTextbox.text;
    [newExpense addCategoryObject:category];
    newExpense.user     = [[CacheManager sharedInstance] currentUser];
    category.expense = newExpense;
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

}
-(BOOL)areInputsValid
{
    if([self.expenseDescriptionTextbox.text length] > 0)
    {
        if([self.categoryTextbox.text length] > 0)
        {
            if([self.amountTextbox.text length] > 0 && [self.amountTextbox.text floatValue]>0)
            {
                return YES;
            }
            else
            {
                [self showAlert:@"Enter a valid amount"];
            }
        }
        else
        {
            [self showAlert:@"Enter the category"];
        }
    }
    else
    {
        [self showAlert:@"Enter the description"];
    }
    
    
    return NO;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.categoryTextbox)
    {
        [self performSegueWithIdentifier:@"selectCategory" sender:self];
    }
}
@end
