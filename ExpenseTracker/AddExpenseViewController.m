//
//  ViewController.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 12/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "AddExpenseViewController.h"
#import <CoreData/CoreData.h>
#import "Expense+CoreDataClass.h"
#import "Expense+CoreDataProperties.h"

#import "Category+CoreDataClass.h"
#import "Category+CoreDataProperties.h"


@interface AddExpenseViewController ()

@end

@implementation AddExpenseViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.amountTxtbox.text = @"1234";
//    
//    // Do any additional setup after loading the view, typically from a nib.
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//- (IBAction)submitAction:(id)sender {
//    NSManagedObjectContext *context = [self managedObjectContext];
//    
//    // Create a new managed object
//    Expense *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Expense" inManagedObjectContext:context];
//    newDevice.amount    = [self.amountTxtbox.text doubleValue];
//    newDevice.expenseDescription = self.descriptionTxtbox.text;
//    newDevice.date              = [NSDate date];
//    Category *category = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:context];
//    category.category   = @"Food";
//    newDevice.category          = category;
//    category.expense = newDevice;
////
////    [newDevice setValue:[NSNumber numberWithFloat:[self.amountTxtbox.text floatValue]]forKey:@"amount"];
////    [newDevice setValue:self.descriptionTxtbox.text forKey:@"expenseDescription"];
////    [newDevice setValue:@"Food" forKey:@"expense"];
////    [newDevice setValue:[NSDate date] forKey:@"date"];
//
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expense" inManagedObjectContext:context];
//    [request setEntity:entity];
//    
//    NSError *errorFetch = nil;
//    NSArray *array = [context executeFetchRequest:request error:&errorFetch];
//    
//    for (Expense *obj in array) {
//        
//        
//        
//        NSLog(@"%f",obj.amount);
//        NSLog(@"%@",obj.expenseDescription);
//        NSLog(@"%@",obj.category.category);
//
//    }
//    NSError *error = nil;
//    // Save the object to persistent store
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
//}
//
//- (NSManagedObjectContext *)managedObjectContext {
//    NSManagedObjectContext *context = nil;
//    id delegate = [[UIApplication sharedApplication] delegate];
//    if ([delegate performSelector:@selector(managedObjectContext)]) {
//        context = [delegate managedObjectContext];
//    }
//    return context;
//}
@end
