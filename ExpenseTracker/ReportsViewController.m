//
//  ReportsViewController.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 06/03/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "ReportsViewController.h"

@interface ReportsViewController ()<BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource>
@property (strong, nonatomic) NSMutableArray *arrayOfValues;
@property (strong, nonatomic) NSMutableArray *arrayOfDates;
@property (nonatomic, strong) NSArray       *expenseData;

@end

@implementation ReportsViewController
  
- (void)viewDidLoad {
    [super viewDidLoad];
    self.legendLbl.text =@"";
    self.arrayOfDates = [NSMutableArray array];
    self.arrayOfValues = [NSMutableArray array];
    [self fetchExpenseData:0];
    [self setDefaultPropertiesForGraph];
}
    
-(void)setDefaultPropertiesForGraph
{
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    
    // Apply the gradient to the bottom portion of the graph
    self.reportLineGraph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    // Enable and disable various graph properties and axis displays
    self.reportLineGraph.enableTouchReport = YES;
    self.reportLineGraph.enablePopUpReport = YES;
    self.reportLineGraph.enableYAxisLabel = YES;
    self.reportLineGraph.autoScaleYAxis = YES;
    self.reportLineGraph.alwaysDisplayDots = NO;
    self.reportLineGraph.enableReferenceXAxisLines = YES;
    self.reportLineGraph.enableReferenceYAxisLines = YES;
    self.reportLineGraph.enableReferenceAxisFrame = YES;
    self.reportLineGraph.delegate=self;
    self.reportLineGraph.dataSource=self;
    // Draw an average line
    self.reportLineGraph.averageLine.enableAverageLine = YES;
    self.reportLineGraph.averageLine.alpha = 0.6;
    self.reportLineGraph.averageLine.color = [UIColor darkGrayColor];
    self.reportLineGraph.averageLine.width = 2.5;
    self.reportLineGraph.averageLine.dashPattern = @[@(2),@(2)];
    
    // Set the graph's animation style to draw, fade, or none
    self.reportLineGraph.animationGraphStyle = BEMLineAnimationDraw;
    
    // Dash the y reference lines
    self.reportLineGraph.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
    
    // Show the y axis values with this format string
    self.reportLineGraph.formatStringForValues = @"%.1f";
    
    [self.reportLineGraph reloadGraph];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmentChanged:(id)sender {
    [self fetchExpenseData:self.frequencySegment.selectedSegmentIndex];
}
- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
   return (int)[self.arrayOfValues count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
   
    return [[self.arrayOfValues objectAtIndex:index] doubleValue];
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 2;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    NSString *label;
    if(self.frequencySegment.selectedSegmentIndex == 0)
    {
        label = [self labelForDateAtIndex:index];

    }
    else if(self.frequencySegment.selectedSegmentIndex == 1)
    {
        label = [self labelForDateMonthAtIndex:index];
        
    }
    else
    {
        label = [self labelForMonthYearDateAtIndex:index];

    }
    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    
//     self.legendLbl.text = [NSString stringWithFormat:@"Rs. %@ on %@",[self.valuesDict objectForKey:[[self.valuesDict allKeys] objectAtIndex:index]],[self labelForDateAtIndex:index]];

    NSString *label;
    if(self.frequencySegment.selectedSegmentIndex == 0)
    {
        label = [self labelForDateAtIndex:index];
        
    }
    else if(self.frequencySegment.selectedSegmentIndex == 1)
    {
        label = [self labelForDateMonthAtIndex:index];
        
    }
    else
    {
        label = [self labelForMonthYearDateAtIndex:index];
        
    }
    self.legendLbl.text = [NSString stringWithFormat:@"Rs. %.2f on %@", [[self.arrayOfValues objectAtIndex:index] floatValue],label];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    self.legendLbl.text =@"";
    }

- (NSString *)popUpPrefixForlineGraph:(BEMSimpleLineGraphView *)graph
{
    return @"Rs. ";
}

#pragma mark-
#pragma Helper
- (NSString *)labelForDateMonthAtIndex:(NSInteger)index {
    NSDate *date = self.arrayOfDates[index];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd/MMM";
    NSString *label = [df stringFromDate:date];
    return label;
}
- (NSString *)labelForMonthYearDateAtIndex:(NSInteger)index {
    NSDate *date = self.arrayOfDates[index];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MMM YY";
    NSString *label = [df stringFromDate:date];
    return label;
}
- (NSString *)labelForDateAtIndex:(NSInteger)index {
    NSDate *date = self.arrayOfDates[index];
    return [self striongFromDate:date];
}
-(NSArray *)sortAndFetchAllExpenses
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kExpense inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"date" 
                                        ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
    [request setSortDescriptors:sortDescriptors];                   
    
    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"user == %@",[[CacheManager sharedInstance] currentUser]];
    
    
    
    
    [request setPredicate:userPredicate];
    
    
    NSError *errorFetch = nil;
    return [[self managedObjectContext] executeFetchRequest:request error:&errorFetch];
    
    
}
-(NSArray *)getExpenses:(NSArray *)expenses betweenDates:(NSDate *)firstDate :(NSDate *)secondDate
{
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"(date >= %@) AND (date <= %@)",firstDate,secondDate];
    return  [expenses filteredArrayUsingPredicate:datePredicate];
    
}

-(void)fetchExpenseData:(NSInteger)selectedSegment
{
    NSArray *expenseList = [self sortAndFetchAllExpenses];
    if([expenseList count] > 0)
    {
        NSDate *firstDateEntry = ((Expense *) [expenseList objectAtIndex:0]).date;
        NSDateComponents *creationComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:firstDateEntry];
        int firstYear = (int)[creationComponents year];
        int firstMonth = (int)[creationComponents month];    
        
        
        NSDate *lastDateEntry = ((Expense *) [expenseList lastObject]).date;
        NSDateComponents *lastComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:lastDateEntry];
        NSInteger lastyear = [lastComponents year];
        NSInteger lastMonth = [lastComponents month];    
        
        [self.arrayOfValues removeAllObjects];
        [self.arrayOfDates removeAllObjects];
        for(int i = firstYear ; i <= lastyear; i ++)
        {
            NSInteger numberOfMonths = 12;
            if(i == lastyear)
            {
                numberOfMonths = lastMonth;
            }
            for (int j=firstMonth; j <=numberOfMonths; j++) 
            { 
                NSDate *lastDateOfTheMonth = [self lastDayOfMonth:j andYear:i];
                
                NSArray *monthExpense = [self getExpenses:expenseList betweenDates:[self getFirstDateOfMonth:j andYear:i] :lastDateOfTheMonth];
                
                switch (selectedSegment) {
                    case 0://Day
                    {
                        NSArray *dayEntriesForTheMonth = [monthExpense valueForKeyPath:@"@distinctUnionOfObjects.date"];
                        NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" 
                                                                                         ascending:YES];
                        dayEntriesForTheMonth = [dayEntriesForTheMonth sortedArrayUsingDescriptors:@[dateDescriptor]];
                        for(NSDate *expenseDate in dayEntriesForTheMonth)
                        {
                            
                            NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"date == %@",expenseDate];
                            NSArray *dayExpense = [monthExpense filteredArrayUsingPredicate:datePredicate];
                            NSNumber *sum = [dayExpense valueForKeyPath:@"@sum.amount"];
                            NSLog(@"%f",sum.floatValue);
                            
                            [self.arrayOfValues addObject:[NSString stringWithFormat:@"%f",sum.floatValue ]];
                            [self.arrayOfDates addObject:expenseDate];
                            
                        }
                        break;
                        
                    }
                    case 1://Weekly
                    {
                        NSDate *firstDateOfWeek = ((Expense *) [expenseList objectAtIndex:0]).date;
                        NSDate *lastDateOfWeek = [self getLastDateOfTheWeek:firstDateOfWeek];
                        while ([self isFromDateLessThanToDate:lastDateOfWeek toDate:lastDateOfTheMonth]) {
                            NSArray *weekExpense = [self getExpenses:monthExpense betweenDates:firstDateOfWeek :lastDateOfWeek];
                            
                            NSNumber *sum = [weekExpense valueForKeyPath:@"@sum.amount"];
                            if([sum floatValue]>0)
                            {
                                [self.arrayOfValues addObject:[NSString stringWithFormat:@"%f",sum.floatValue ]];
                                [self.arrayOfDates addObject:lastDateOfWeek];
                                
                            }
                            firstDateOfWeek = [self getDate:lastDateOfWeek byAddingDays:1];
                            lastDateOfWeek = [self getLastDateOfTheWeek:firstDateOfWeek];
                            
                        }
                        break;
                    }
                    case 2://Monthly
                    {
                        NSNumber *sum = [monthExpense valueForKeyPath:@"@sum.amount"];
                        [self.arrayOfValues addObject:[NSString stringWithFormat:@"%f",sum.floatValue ]];
                        [self.arrayOfDates addObject:[self getFirstDateOfMonth:j andYear:i]];
                        break;
                    }
                }
                
            }
            firstMonth = 1;
            
        }
        [self.reportLineGraph reloadGraph];
    }
    
}

@end
