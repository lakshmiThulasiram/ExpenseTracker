//
//  SelectCategoryViewController.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "ExpenseBaseViewController.h"

@protocol SelectCategoryDelegate <NSObject>

-(void)selectedCategories:(NSArray *)categories;

@end

@interface SelectCategoryViewController : ExpenseBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *categoryTable;
@property (weak, nonatomic) id<SelectCategoryDelegate>  delegate;

@end
