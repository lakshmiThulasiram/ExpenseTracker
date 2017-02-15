//
//  Expense+CoreDataProperties.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 16/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Expense+CoreDataProperties.h"

@implementation Expense (CoreDataProperties)

+ (NSFetchRequest<Expense *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Expense"];
}

@dynamic amount;
@dynamic date;
@dynamic expenseDescription;
@dynamic category;
@dynamic user;

@end
