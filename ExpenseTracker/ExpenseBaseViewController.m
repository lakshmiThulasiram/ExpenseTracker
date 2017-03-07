//
//  ExpenseBaseViewController.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "ExpenseBaseViewController.h"

@interface ExpenseBaseViewController ()

@end

@implementation ExpenseBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showAlert:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ExpenseTracker" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             [self alertDismissed];
                                             // do something here
                                         }];
    [alert addAction:otherAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
-(NSDate *)getFirstDateOfMonth:(NSDate*)currentDate
{
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[self calendar] components:unitFlags fromDate:currentDate];
    [dateComponents setDay:1];
    return [[self calendar] dateFromComponents:dateComponents];
}
-(NSDate *)getFirstDateOfMonth:(int)month andYear:(int)year
{
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[self calendar] components:unitFlags fromDate:[NSDate date]];
    [dateComponents setDay:1];
    [dateComponents setMonth:month];
    [dateComponents setYear:year];
    return [[self calendar] dateFromComponents:dateComponents];

}

-(NSDate*)lastDayOfMonth:(int)month andYear:(int)year
{
    NSCalendar *calendar = [self calendar];
    NSDate *firstDateOfMonth = [self getFirstDateOfMonth:month andYear:year];
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay
                                             inUnit:NSCalendarUnitMonth
                                            forDate:firstDateOfMonth];
    
    NSInteger days = dayRange.length;

    NSDateComponents *comp = [calendar components:
                              NSCalendarUnitYear |
                              NSCalendarUnitMonth |
                              NSCalendarUnitDay fromDate:firstDateOfMonth];
    
    [comp setDay:days];
    
    return [[self calendar] dateFromComponents:comp];
}
-(NSDate *)getLastDateOfTheWeek:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.firstWeekday = 1;
    NSDateComponents *dateCmp = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth fromDate:date];
   
    NSDateComponents *dt = [[NSDateComponents alloc]init];
//    [dt setWeek:[dateCmp week]];
    [dt setWeekday:7];
    [dt setMonth:[dateCmp month]];
    [dt setYear:[dateCmp year]];
    dt.weekOfMonth = [dateCmp weekOfMonth];
    return [[self calendar] dateFromComponents:dt];
    
}
-(NSDate*)getDateIgnorinbgTime:(NSDate *)date{
    NSCalendar *calendar = [self calendar];
    NSDateComponents *comp = [calendar components:
                              NSCalendarUnitYear |
                              NSCalendarUnitMonth |
                              NSCalendarUnitDay fromDate:date];
    
    return [[self calendar] dateFromComponents:comp];
}
-(NSDate *)getDate:(NSDate *)date byAddingDays:(int)days
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = days;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    return [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];

}
-(BOOL)isFromDateLessThanToDate:(NSDate *)fromDate toDate:(NSDate*)toDate
{
    
    if ([fromDate compare:toDate] == NSOrderedAscending || [self isDatesEqualIgnoringTime:fromDate secondDate:toDate])
        return YES;
    else
        return NO;
}
-(BOOL) isDatesEqualIgnoringTime:(NSDate *) firstDate secondDate:(NSDate*)secondDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components1 = [calendar components:unitFlags fromDate:firstDate];
    NSDateComponents *components2 = [calendar components:unitFlags fromDate:secondDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

-(NSCalendar*)calendar
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];    
    return calendar;
}

-(void)alertDismissed
{
    
}
-(NSString *)striongFromDate:(NSDate *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init]; 
    [df setDateFormat:@"dd-MM-yyyy"];
    return [df stringFromDate:date];
}
@end
