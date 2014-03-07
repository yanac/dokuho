//
//  RegistrationViewController.h
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/03.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) UIImageView *displayImageView;

@property (strong, nonatomic) UIButton *dateButton;

@property (strong, nonatomic) UITextField *memoTextField;

@property UIDatePicker *datePicker;

- (void)initWithDisplayImage:(UIImage *)image;

@end

