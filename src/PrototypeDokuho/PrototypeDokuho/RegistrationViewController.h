//
//  RegistrationViewController.h
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/03.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicturedScheduledTask.h"

@interface RegistrationViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate> {
    UIActionSheet *actionSheet;
}

@property (strong, nonatomic) UIImageView *displayImageView;

@property (strong, nonatomic) UIButton *startDateButton;

@property (strong, nonatomic) UITextField *memoTextField;

@property (strong, nonatomic) UITextField *titleTextField;

@property (strong, nonatomic) PicturedScheduledTask *picturedScheduledTask;

- (void)initializeDisplayImage:(UIImage *)image;

- (NSString *)getNowDateString;

- (NSString *)getStringWithDate:(NSDate *)date;

- (NSDate *)getDateWithString:(NSString *)string;

@end

