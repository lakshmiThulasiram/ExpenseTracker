//
//  ListExpenseViewController.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "ExpenseBaseViewController.h"
#import "Expense+CoreDataProperties.h"
#import "Category+CoreDataProperties.h"

@interface ListExpenseViewController : ExpenseBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *fromDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *toDateBtn;
@property (weak, nonatomic) IBOutlet UITableView *expenseTableView;
@property (weak, nonatomic) IBOutlet UIButton *addExpenseAction;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIButton *reportsBtn;

@end
