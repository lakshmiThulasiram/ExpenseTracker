//
//  LoginViewController.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "LoginViewController.h"
#import "CacheManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {
    
    if([self areInputsValid])
    {
        if([self isUserRegistered:self.emailTextbox.text andPassword:self.pwdTextbox.text])
        {
            [self performSegueWithIdentifier:@"ListExpense" sender:self];
        }
    }

}
- (IBAction)registerAction:(id)sender {
    [self performSegueWithIdentifier:@"register" sender:self];
}

#pragma mark -
#pragma mark Validation
-(BOOL)areInputsValid
{
    if([self.emailTextbox.text length] > 0 && [self isValidEmail:self.emailTextbox.text])
    {
        if([self.pwdTextbox.text length] > 0)
        {
            return YES;
            
        }
        else
        {
            [self showAlert:@"Enter password"];
        }
    }
    else
    {
        [self showAlert:@"Enter valid emailID"];
    }
    return NO;
    
}
-(BOOL)isUserRegistered:(NSString *)email andPassword:(NSString *)password
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kUser inManagedObjectContext:[self managedObjectContext]];
    
    request.predicate = [NSPredicate predicateWithFormat:@"emailID == %@", self.emailTextbox.text];
    [request setEntity:entity];
    
    NSArray *userDetail = [[self managedObjectContext] executeFetchRequest:request error:nil];
    
    for (User *user in userDetail) {
        if([user.password isEqualToString:self.pwdTextbox.text])
        {
            [[CacheManager sharedInstance] setCurrentUser:user];
            return YES;
        }
    }
    [self showAlert:@"Either emailID or password is incorrect"];
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
