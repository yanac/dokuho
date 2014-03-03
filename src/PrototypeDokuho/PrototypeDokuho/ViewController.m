//
//  ViewController.m
//  PrototypeDokuho
//
//  Created by yanac on 2013/12/11.
//  Copyright (c) 2013年 梁島 啓多. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.buttonCamera addTarget:self
               action:@selector(clickButtonCamera:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonRegistration addTarget:self
                          action:@selector(clickButtonRegistration:)
                forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            // １番目のボタンが押されたときの処理を記述する
            NSLog(@"buttton0");
            break;
        case 1:
            // ２番目のボタンが押されたときの処理を記述する
            NSLog(@"buttton1");
            break;
        case 2:
            // ３番目のボタンが押されたときの処理を記述する
            NSLog(@"buttton2");
            break;
    }
}

- (IBAction)clickButtonRegistration:(UIButton *)sender {
    UIActionSheet *selectLoadImageActionSheet = [UIActionSheet.alloc initWithTitle:@"画像の読み込み方法を選択してください"
                                                                          delegate:self
                                                                 cancelButtonTitle:@"キャンセル"
                                                            destructiveButtonTitle:nil
                                                                 otherButtonTitles:@"カメラロール", @"撮影", nil];
    [selectLoadImageActionSheet showInView:self.view];
}


// camera起動
// アラートの表示
- (void)showAlert:(NSString *)title text:(NSString *)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:text
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


// イメージピッカーのオープン
- (void)openPicker:(UIImagePickerControllerSourceType)sourceType {
    // カメラとフォトアルバムの利用可能チェック
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        [self showAlert:@"" text:@"利用できません"];
        return;
    }
    
    // イメージピッカー
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    // ビューコントローラのビューを開く
    [self presentViewController:picker animated:YES completion:nil];
}


// イメージピッカーのイメージ取得時に呼ばれる
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // イメージの指定
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_imageView setImage:image];
    
    // ビューコントローラのビューを閉じる
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}


// イメージピッカーのキャンセル時に呼ばれる
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)pickerCtl {
    // ビューコントローラのビューを閉じる
    [[pickerCtl presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}


// ボタンクリック時のイベント処理
- (IBAction)clickButtonCamera:(UIButton *)sender {
    [self openPicker:UIImagePickerControllerSourceTypeCamera];
}

@end
