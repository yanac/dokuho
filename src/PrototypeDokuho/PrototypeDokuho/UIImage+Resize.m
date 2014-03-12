//
//  UIImage+Resize.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/12.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "UIImage+Resize.h"

#import <GTMUIImage+Resize.h>

@implementation UIImage (Resize)

- (UIImage *)resizeIfOverSize:(CGSize)size {
    
    if (self.size.width > size.width || self.size.height > size.height) {
        
        return [self gtm_imageByResizingToSize:size
                           preserveAspectRatio:YES
                                     trimToFit:NO];
    }
    return self;
}

@end
