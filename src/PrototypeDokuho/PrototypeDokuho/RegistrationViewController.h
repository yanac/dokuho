//
//  RegistrationViewController.h
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/03.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *displayImage;

- (void)initWithDisplayImage:(UIImage *)image;

@end
