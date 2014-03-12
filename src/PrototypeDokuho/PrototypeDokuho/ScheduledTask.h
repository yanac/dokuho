//
//  ScheduledTask.h
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/09.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduledTask : NSObject <NSCoding>

@property (nonatomic) NSString *title;

@property (nonatomic) NSString *memo;

@property (nonatomic) NSString *fileName;

@property (nonatomic) NSDate *date;

- (instancetype)initWithMemo:(NSString *)memo title:(NSString *)title fileName:(NSString *)fileName date:(NSDate *)date;

@end
