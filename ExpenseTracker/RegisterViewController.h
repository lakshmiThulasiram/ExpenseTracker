//
//  RegisterViewController.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpenseBaseViewController.h"

@interface RegisterViewController : ExpenseBaseViewController
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *nameTextbox;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *emailTextbox;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *pwdTextbox;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *pwdConfirmTextbox;

@end
