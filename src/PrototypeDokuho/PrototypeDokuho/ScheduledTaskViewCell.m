//
//  ScheduledTaskViewCell.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/02/26.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "ScheduledTaskViewCell.h"
#import "Constants.h"

@implementation ScheduledTaskViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _taskImageView = [UIImageView.alloc initWithFrame:CGRectMake(10, 15, kThumbnailSize, kThumbnailSize)];
        _taskImageView.contentMode = UIViewContentModeScaleAspectFill;
        _taskImageView.clipsToBounds = YES;
        
        [self.contentView addSubview:_taskImageView];
        
        // TODO: _dateLabel つくる　フォント設定する
        // [self.contentView addSubview:_asdfas]
        _dateLabel = [UILabel.alloc initWithFrame:CGRectMake(120, 65, 180, 27)];
        _dateLabel.font = [UIFont fontWithName:@"Futura-Medium" size:12.0f];
        _dateLabel.textColor = [UIColor colorWithRed:0.58 green:0.60 blue:0.59 alpha:1.0];
        
        [self.contentView addSubview:_dateLabel];
        
        
        
        // TODO: taskTitleLabel　作る　フォント設定する
        // [self.contentView addSubview:_asdfas]
        _taskTitleLabel = [UILabel.alloc initWithFrame:CGRectMake(120, 34, 180, 27)];
        _taskTitleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:17.0f];
        _taskTitleLabel.textColor = [UIColor colorWithRed:0.14 green:0.15 blue:0.15 alpha:1.0];

        [self.contentView addSubview:_taskTitleLabel];
    }
    return self;
}

@end
