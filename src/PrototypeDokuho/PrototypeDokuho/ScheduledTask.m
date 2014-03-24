//
//  ScheduledTask.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/09.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "ScheduledTask.h"

@implementation ScheduledTask

- (instancetype)initWithMemo:(NSString *)memo title:(NSString *)title fileName:(NSString *)fileName date:(NSDate *)date{
    self = [super init];
    if (self) {
        _taskTitle = title;
        _date = date;
        _memo = memo;
        _fileName = fileName;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _taskTitle = [aDecoder decodeObjectForKey:@"titleAtScheduledTask"];
        _date = [aDecoder decodeObjectForKey:@"startDateAtScheduledTask"];
        _memo = [aDecoder decodeObjectForKey:@"memo"];
        _fileName = [aDecoder decodeObjectForKey:@"fileName"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_taskTitle forKey:@"titleAtScheduledTask"];
    [aCoder encodeObject:_date forKey:@"startDateAtScheduledTask"];
    [aCoder encodeObject:_memo forKey:@"memo"];
    [aCoder encodeObject:_fileName forKey:@"fileName"];
}

@end
