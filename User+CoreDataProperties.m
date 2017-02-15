//
//  User+CoreDataProperties.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 16/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic emailID;
@dynamic name;
@dynamic password;
@dynamic expense;

@end
