//
//  PicturedPlan.h
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/09.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "ScheduledTask.h"

@interface PicturedScheduledTask : ScheduledTask <NSCoding>

@property (nonatomic) UIImage *picture;

- (instancetype)initWithPicture:(UIImage *)picture;
@end
