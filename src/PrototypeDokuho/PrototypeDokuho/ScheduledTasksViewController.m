//
//  plansViewController.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/02/26.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "ScheduledTasksViewController.h"
#import "ScheduledTaskViewCell.h"
#import "ScheduledTaskManager.h"
#import "RegistrationViewController.h"
#import "UIImage+Resize.h"


@interface ScheduledTasksViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *scheduledTaskThumbnails;
@property (nonatomic, strong) NSMutableArray *stringItem;
@property (nonatomic, strong) PicturedScheduledTask *selectedTask;


@end

@implementation ScheduledTasksViewController

- (void)viewDidLoad{
    
    UIBarButtonItem *registButton = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                          target:self
                                                                          action:@selector(regist:)];
    
    
    [self.navigationItem setRightBarButtonItem:registButton animated:YES];
}

// cell用画像の再読み込み
- (void)viewWillAppear:(BOOL)animated {
    self.scheduledTaskThumbnails = [NSMutableArray array];
    self.scheduledTaskThumbnails = [ScheduledTaskManager.alloc getScheduledTasksThumbnail];
    self.stringItem = [NSMutableArray array];
    self.stringItem = [ScheduledTaskManager.alloc getScheduledTasksViewStringItem];
    [self.tableView reloadData];
    
    self.navigationItem.title = [NSString.alloc initWithFormat:@"%ld Tasks", (long)self.stringItem.count];
}

#pragma mark - Delegate

// セクション数の指定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// セクションに応じたセルの数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.scheduledTaskThumbnails.count;
}

// セルオブジェクトを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ScheduledTaskViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MY_CELL"];
    
    if (!cell) {
        cell = [ScheduledTaskViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MY_CELL"];
    }
    
    UIImage *cellImage;
    UIImage *thumbnail = self.scheduledTaskThumbnails[indexPath.item];
    if ([thumbnail isMemberOfClass:UIImage.class]) {
        cellImage = thumbnail;
    } else {
        cellImage = [UIImage imageNamed:@"NOImage_thumb.jpg"];
    }
    
    cell.taskImageView.image = cellImage;
    
    cell.taskTitleLabel.text = self.stringItem[indexPath.item][@"taskTitle"];
    
    NSDateFormatter *Formatter = [NSDateFormatter.alloc init];
    [Formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    cell.dateLabel.text = [Formatter stringFromDate:self.stringItem[indexPath.item][@"date"]];
    
    return cell;
}

// コレクションビューの選択を可能にする
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedTask = [ScheduledTaskManager.alloc getDecodedScheduledTasks][indexPath.row];
    [self performSegueWithIdentifier:@"registModal" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"registModal"]) {
        RegistrationViewController *vc = segue.destinationViewController;
        vc.picturedScheduledTask = _selectedTask;
    }
}


- (void)regist:(id)sender {
    UIActionSheet *selectLoadImageActionSheet = [UIActionSheet.alloc initWithTitle:@"画像の読み込み方法を選択してください"
                                                                          delegate:self
                                                                 cancelButtonTitle:@"キャンセル"
                                                            destructiveButtonTitle:nil
                                                                 otherButtonTitles:@"撮影", @"カメラロールから開く", @"画像なしで登録", nil];
    
    [selectLoadImageActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            // 撮影
            [self openPicker:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            // カメラロール
            [self openPicker:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case 2:
        { // 画像無し _selectedTaskを初期化
            _selectedTask = [PicturedScheduledTask.alloc init];
            [self performSegueWithIdentifier:@"registModal" sender:nil];
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [ScheduledTaskManager.alloc deleteScheduledTask:self.stringItem[indexPath.row][@"fileName"]];
        [_stringItem removeObjectAtIndex:indexPath.row];
        [_scheduledTaskThumbnails removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        self.navigationItem.title = [NSString.alloc initWithFormat:@"%ld Tasks", (long)self.stringItem.count];
    }
}

#pragma mark - Delegate(Picker)

// camera起動
// アラートの表示
- (void)showAlert:(NSString *)title text:(NSString *)text {
    UIAlertView *alert = [UIAlertView.alloc initWithTitle:title
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
    UIImagePickerController *picker = [UIImagePickerController.alloc init];
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
    
    // ビューコントローラのビューを閉じる
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
        _selectedTask = [PicturedScheduledTask.alloc init];
        _selectedTask.picture = image;
        
        // 登録画面に撮影した写真を渡して画面遷移する
        [self performSegueWithIdentifier:@"registModal" sender:nil];
    }];
}

// イメージピッカーのキャンセル時に呼ばれる
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)pickerCtl {
    // ビューコントローラのビューを閉じる
    [[pickerCtl presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}


@end
