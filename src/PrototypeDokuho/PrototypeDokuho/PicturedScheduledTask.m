//
//  PicturedPlan.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/09.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "PicturedScheduledTask.h"

@implementation PicturedScheduledTask

- (instancetype)initWithPicture:(UIImage *)picture {
    self = [super init];
    if (self) {
        _picture = picture;
    }
    return  self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _picture = [aDecoder decodeObjectForKey:@"pictureAtScheduledTask"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_picture forKey:@"pictureAtScheduledTask"];
}

@end
