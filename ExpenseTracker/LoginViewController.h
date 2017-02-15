//
//  LoginViewController.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User+CoreDataClass.h"
#import "User+CoreDataProperties.h"

#import "ExpenseBaseViewController.h"

@interface LoginViewController : ExpenseBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *pwdTextbox;
@property (weak, nonatomic) IBOutlet UITextField *emailTextbox;
@end
