//
//  PicturedPlan.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/09.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "PicturedScheduledTask.h"
#import "UIImage+Resize.h"

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
        _thumbnail = [aDecoder decodeObjectForKey:@"thumbnail"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_picture forKey:@"pictureAtScheduledTask"];
    [aCoder encodeObject:_thumbnail forKey:@"thumbnail"];
}

-(void)createThumbnail {
    CGSize size = CGSizeMake(60, 60);
    _thumbnail = [_picture resizeIfOverSize:size];
}

@end
