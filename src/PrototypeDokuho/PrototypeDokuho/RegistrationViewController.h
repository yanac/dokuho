//
//  RegistrationViewController.h
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/03.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicturedScheduledTask.h"
#import "UIPlaceHolderTextView.h"

@interface RegistrationViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate, UITextViewDelegate> {
    UIActionSheet *actionSheet;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;

@property (weak, nonatomic) IBOutlet UIButton *startDateButton;

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *memoTextField;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) PicturedScheduledTask *picturedScheduledTask;

@end

