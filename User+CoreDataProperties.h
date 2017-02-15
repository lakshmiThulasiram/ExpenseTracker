//
//  User+CoreDataProperties.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 16/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *emailID;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, retain) NSSet<Expense *> *expense;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addExpenseObject:(Expense *)value;
- (void)removeExpenseObject:(Expense *)value;
- (void)addExpense:(NSSet<Expense *> *)values;
- (void)removeExpense:(NSSet<Expense *> *)values;

@end

NS_ASSUME_NONNULL_END
