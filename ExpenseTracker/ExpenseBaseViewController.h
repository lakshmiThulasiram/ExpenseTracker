//
//  ExpenseBaseViewController.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kUser @"User"
#define kCategory @"Category"
#define kExpense @"Expense"

#import "CacheManager.h"
#import <CoreData/CoreData.h>

@interface ExpenseBaseViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
-(void)saveData;
-(BOOL)isValidEmail:(NSString *)checkString;
-(NSString *)striongFromDate:(NSDate *)date;
- (NSManagedObjectContext *)managedObjectContext;
-(void)showAlert:(NSString *)message;
-(void)alertDismissed;
@end
