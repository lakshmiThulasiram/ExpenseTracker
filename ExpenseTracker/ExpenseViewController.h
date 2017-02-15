//
//  ExpenseViewController.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "ExpenseBaseViewController.h"
#import "Expense+CoreDataClass.h"
#import "Expense+CoreDataProperties.h"

#import "Category+CoreDataClass.h"
#import "Category+CoreDataProperties.h"

@protocol AddExpenseDelegate <NSObject>

-(void)fetchExpenseData;

@end

@interface ExpenseViewController : ExpenseBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *categoryTextbox;
@property (weak, nonatomic) IBOutlet UITextField *amountTextbox;
@property (weak, nonatomic) id<AddExpenseDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *expenseDescriptionTextbox;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
