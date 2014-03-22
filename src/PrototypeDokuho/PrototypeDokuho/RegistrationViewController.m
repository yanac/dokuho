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

@end

@implementation RegistrationViewController
{
    UIDatePicker *datePicker;
}

#pragma mark - Life Cycle

- (id)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initializeDisplayImage:(UIImage *)image {
    [self initializeDisplayImageView];
    self.displayImageView.image = image;
}

- (void)initializeDisplayImageView {
    self.displayImageView = [UIImageView.alloc initWithFrame:CGRectMake(30, 75, 260, 280)];
    self.displayImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.displayImageView setClipsToBounds:YES];
}

- (void)loadView {    
    self.view = [UIView.alloc init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    { // add ImageView
        if (self.displayImageView.image == nil) {
            [self initializeDisplayImage:[UIImage imageNamed:@"NOImage.jpg"]];
        }
        [self.view addSubview:self.displayImageView];
    }
    
    { // Init Button (Date)
        self.startDateButton = [UIButton.alloc initWithFrame:CGRectMake(50, 405, 220, 30)];
        [self.startDateButton  setTitle:[self getNowDateString] forState:UIControlStateNormal];
        self.startDateButton.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:self.startDateButton];
    }
    
    { // Init TextField (Memo)
        self.memoTextField = [UITextField.alloc initWithFrame:CGRectMake(50, 450, 220, 100)];
        self.memoTextField.backgroundColor = [UIColor grayColor];
        self.memoTextField.returnKeyType = UIReturnKeyDone;
        [self.view addSubview:self.memoTextField];
        self.memoTextField.delegate = self;
    }
    
    { // Init TextField(Title)
        self.titleTextField = [UITextField.alloc initWithFrame:CGRectMake(50, 365, 220, 30)];
        self.titleTextField.backgroundColor = [UIColor grayColor];
        self.titleTextField.returnKeyType = UIReturnKeyDone;
        [self.view addSubview:self.titleTextField];
        self.titleTextField.delegate = self;
    }
    
    UIBarButtonItem *save = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                        target:self
                                                                        action:@selector(save:)];
    [self.navigationItem setRightBarButtonItem:save animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.startDateButton addTarget:self
                        action:@selector(pushDateButton:)
              forControlEvents:UIControlEventTouchUpInside];
    
    // self.picturedScheduledTaskが存在する場合
    if (self.picturedScheduledTask) {
        self.titleTextField.text = self.picturedScheduledTask.title;
        self.memoTextField.text = self.picturedScheduledTask.memo;
        self.startDateButton.titleLabel.text = [self getStringWithDate:self.picturedScheduledTask.date];
        if ([self.picturedScheduledTask isMemberOfClass:[PicturedScheduledTask class]]) {
            self.displayImageView.image = self.picturedScheduledTask.picture;
        }
    }
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Event

- (void)pushDoneButton:(id)sender {
    //dateを表示
    self.startDateButton.titleLabel.text = [self getStringWithDate:datePicker.date];
    
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
    task.title = self.titleTextField.text;
    task.date = [self getDateWithString:self.startDateButton.titleLabel.text];
    
    // fileNameが存在してるなら上書き保存 無いならfilenNameを日時分で保存
    if (self.picturedScheduledTask.fileName) {
        [ScheduledTaskManager.alloc saveScheduledTask:task fileName:self.picturedScheduledTask.fileName];
    } else {
        task.fileName = [self getNowDateAndTime];
        [ScheduledTaskManager.alloc saveScheduledTask:task fileName:task.fileName];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    
    { // Init DatePicker
        datePicker = [UIDatePicker.alloc initWithFrame:CGRectMake(0, 44, 320, 420)];
        datePicker.backgroundColor = [UIColor whiteColor];
        datePicker.date = [self getDateWithString:self.startDateButton.titleLabel.text];
        [self.view addSubview:datePicker];
    }
    
    [actionSheet addSubview:toolBar];
    [actionSheet addSubview:datePicker];
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
