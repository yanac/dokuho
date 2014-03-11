//
//  ScheduledTask.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/09.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "ScheduledTask.h"

@implementation ScheduledTask

- (instancetype)initWithMemo:(NSString *)memo title:(NSString *)title date:(NSDate *)date{
    self = [super init];
    if (self) {
        _title = title;
        _date = date;
        _memo = memo;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"titleAtScheduledTask"];
        _date = [aDecoder decodeObjectForKey:@"startDateAtScheduledTask"];
        _memo = [aDecoder decodeObjectForKey:@"memo"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_title forKey:@"titleAtScheduledTask"];
    [aCoder encodeObject:_date forKey:@"startDateAtScheduledTask"];
    [aCoder encodeObject:_memo forKey:@"memo"];
}

@end
