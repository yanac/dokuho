//
//  UIImage+Resize.h
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/12.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

/// size よりも大きかったらリサイズする
- (UIImage *)resizeIfOverSize:(CGSize)size;

@end
