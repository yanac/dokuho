//
//  ViewController.h
//  PrototypeDokuho
//
//  Created by yanac on 2013/12/11.
//  Copyright (c) 2013年 梁島 啓多. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate> {
    UIImageView *_imageView;
}

@property (weak, nonatomic) IBOutlet UIButton *buttonCamera;
@property (weak, nonatomic) IBOutlet UIButton *buttonRegistration;

@end
