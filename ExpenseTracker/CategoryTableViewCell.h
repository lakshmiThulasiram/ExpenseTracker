//
//  CategoryTableViewCell.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *checkMarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end
