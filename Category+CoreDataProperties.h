//
//  Category+CoreDataProperties.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 16/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Category+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Category (CoreDataProperties)

+ (NSFetchRequest<Category *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, retain) Expense *expense;

@end

NS_ASSUME_NONNULL_END
