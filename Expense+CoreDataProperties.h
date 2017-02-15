//
//  Expense+CoreDataProperties.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 16/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Expense+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Expense (CoreDataProperties)

+ (NSFetchRequest<Expense *> *)fetchRequest;

@property (nonatomic) double amount;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *expenseDescription;
@property (nullable, nonatomic, retain) NSSet<Category *> *category;
@property (nullable, nonatomic, retain) User *user;

@end

@interface Expense (CoreDataGeneratedAccessors)

- (void)addCategoryObject:(Category *)value;
- (void)removeCategoryObject:(Category *)value;
- (void)addCategory:(NSSet<Category *> *)values;
- (void)removeCategory:(NSSet<Category *> *)values;

@end

NS_ASSUME_NONNULL_END
