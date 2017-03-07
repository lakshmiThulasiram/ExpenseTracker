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
-(NSDate *)getFirstDateOfMonth:(NSDate*)currentDate;
-(NSDate *)getFirstDateOfMonth:(int)month andYear:(int)year;
-(NSDate*)lastDayOfMonth:(int)month andYear:(int)year;
-(NSDate*)getDateIgnorinbgTime:(NSDate *)date;
-(NSDate *)getLastDateOfTheWeek:(NSDate *)date;
-(BOOL) isDatesEqualIgnoringTime:(NSDate *) firstDate secondDate:(NSDate*)secondDate;
-(BOOL)isFromDateLessThanToDate:(NSDate *)fromDate toDate:(NSDate*)toDate;
-(NSDate *)getDate:(NSDate *)date byAddingDays:(int)days;
@end
