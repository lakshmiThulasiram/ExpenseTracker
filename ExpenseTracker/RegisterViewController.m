//
//  RegisterViewController.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "RegisterViewController.h"
#import <CoreData/CoreData.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Actions
- (IBAction)registerAction:(id)sender {
    
    if([self areInputsValid])
    {
        [self saveUser];
        [self showAlert:@"User registered"];
    }
}
-(void)alertDismissed
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark -
#pragma mark CoreData
-(void)saveUser
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    [user setValue:self.nameTextbox.text   forKey:@"name"];
    [user setValue:self.emailTextbox.text forKey:@"emailID"];
    [user setValue:self.pwdTextbox.text forKey:@"password"];  
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }    

}
#pragma mark -
#pragma mark Validation
-(BOOL)areInputsValid
{
    if([self.nameTextbox.text length] > 0)
    {
        if([self.emailTextbox.text length] > 0 && [self isValidEmail:self.emailTextbox.text])
        {
            if([self.pwdTextbox.text length] > 0)
            {
                if([self.pwdConfirmTextbox.text length] > 0)
                {
                    if([self.pwdTextbox.text isEqualToString:self.pwdConfirmTextbox.text])
                    {
                        return YES;
                    }
                    else
                    {
                        [self showAlert:@"Password and Confirm password should be same"];
                    }
                }  
                else
                {
                    [self showAlert:@"Enter Confirm password"];
                }

            }
            else
            {
                [self showAlert:@"Enter Password"];
            }
        }
        else
        {
            [self showAlert:@"Enter a valid emailID"];
        }
    }
    else
    {
        [self showAlert:@"Enter your name"];
    }

    
    return NO;
    
}



@end
