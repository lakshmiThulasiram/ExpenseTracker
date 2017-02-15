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
