//
//  ReportsViewController.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 06/03/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"
#import "Expense+CoreDataProperties.h"
#import "Category+CoreDataProperties.h"
#import "ExpenseBaseViewController.h"

@interface ReportsViewController : ExpenseBaseViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *frequencySegment;

@property (weak, nonatomic) IBOutlet UILabel *legendLbl;

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;
@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *reportLineGraph;

@end
