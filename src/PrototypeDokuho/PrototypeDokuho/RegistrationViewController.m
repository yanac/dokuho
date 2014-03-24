//
//  RegistrationViewController.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/03.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "RegistrationViewController.h"
#import "ScheduledTaskManager.h"

@interface RegistrationViewController ()

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.startDateButton setTitle:[self getNowDateString] forState:UIControlStateNormal];

    UIBarButtonItem *save = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                        target:self
                                                                        action:@selector(save:)];
    
    UIBarButtonItem *cancel = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                        target:self
                                                                        action:@selector(cancel:)];
    

    [_navigationBar.topItem setRightBarButtonItem:save animated:YES];
    [_navigationBar.topItem setLeftBarButtonItem:cancel animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // self.picturedScheduledTaskが存在する場合
    if (self.picturedScheduledTask.fileName) {
        self.titleTextField.text = self.picturedScheduledTask.taskTitle;
        self.memoTextField.text = self.picturedScheduledTask.memo;
        [self.startDateButton setTitle:[self getStringWithDate:self.picturedScheduledTask.date] forState:UIControlStateNormal];
        
        if ([self.picturedScheduledTask isMemberOfClass:[PicturedScheduledTask class]]) {
            self.displayImageView.image = self.picturedScheduledTask.picture;
        }
    } else if (self.picturedScheduledTask.picture) {
        self.displayImageView.image = self.picturedScheduledTask.picture;
    }
}

#pragma mark - Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // キーボードを隠す
    [self.view endEditing:YES];
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - Event

- (void)pushDoneButton:(id)sender {
    //dateを表示
    // self.startDateButton.titleLabel.text = [self getStringWithDate:_datePicker.date]; -> modelに変えてから動かなかった
    [self.startDateButton setTitle:[self getStringWithDate:_datePicker.date] forState:UIControlStateNormal];
    
	//ピッカーをしまう
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)pushCancelButton:(id)sender {
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)save:(id)sender {
    ScheduledTask *task;

    // displayImageView.imageがnilなら ScheduledTaskで初期化 それ以外ならPicturedScheduledTaskで初期化
    if (self.displayImageView.image == [UIImage imageNamed:@"NOImage.jpg"]) {
        task = [ScheduledTask.alloc init];
    } else {
        task = [PicturedScheduledTask.alloc initWithPicture:self.displayImageView.image];
        [self createThumbnail:task];
    }
    
    task.memo = self.memoTextField.text;
    task.taskTitle = self.titleTextField.text;
    task.date = [self getDateWithString:self.startDateButton.titleLabel.text];
    
    // fileNameが存在してるなら上書き保存 無いならfilenNameを日時分で保存
    if (self.picturedScheduledTask.fileName) {
        task.fileName = self.picturedScheduledTask.fileName;
        [ScheduledTaskManager.alloc saveScheduledTask:task fileName:self.picturedScheduledTask.fileName];
    } else {
        task.fileName = [self getNowDateAndTime];
        [ScheduledTaskManager.alloc saveScheduledTask:task fileName:task.fileName];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pushDateButton:(id)sender {
    [self showDatePicker];
}

#pragma mark - Method

- (void)showDatePicker {
    // Init ActionSheet
    actionSheet = [UIActionSheet.alloc initWithTitle:@"" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"" otherButtonTitles:nil];
    
    // Init Toolbar
    UIToolbar *toolBar = [UIToolbar.alloc initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    [toolBar sizeToFit];
    
    UIBarButtonItem *cancelButton = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                          target:self
                                                                                action:@selector(pushCancelButton:)];
    
    UIBarButtonItem *spacer = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                          target:self
                                                                          action:nil];

    UIBarButtonItem *doneButton = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(pushDoneButton:)];
    
    NSArray *items = [NSArray arrayWithObjects:cancelButton, spacer, doneButton, nil];
    
    [toolBar setItems:items animated:YES];
    
    if (!_datePicker) { // Init DatePicker
        _datePicker = [UIDatePicker.alloc initWithFrame:CGRectMake(0, 44, 320, 420)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.date = [self getDateWithString:self.startDateButton.titleLabel.text];
    }
    
    [actionSheet addSubview:toolBar];
    [actionSheet addSubview:_datePicker];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 480)];
}

- (void)createThumbnail:(ScheduledTask *)task {
    PicturedScheduledTask *picturedTask = (PicturedScheduledTask *)task;
    [picturedTask createThumbnail];
}

- (NSString *)getNowDateAndTime {
    NSDate *nowDate = [NSDate.alloc init];
    NSDateFormatter *Formatter = [NSDateFormatter.alloc init];
    [Formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    return [Formatter stringFromDate:nowDate];
}

- (NSString *)getNowDateString {
    NSDate *nowDate = [NSDate.alloc init];
    
    return [self getStringWithDate:nowDate];
}

- (NSString *)getStringWithDate:(NSDate *)date {
    NSDateFormatter *Formatter = [NSDateFormatter.alloc init];
    [Formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    return [Formatter stringFromDate:date];
}

- (NSDate *)getDateWithString:(NSString *)string {
    NSDateFormatter *Formatter = [NSDateFormatter.alloc init];
    [Formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    return [Formatter dateFromString:string];
}

@end
