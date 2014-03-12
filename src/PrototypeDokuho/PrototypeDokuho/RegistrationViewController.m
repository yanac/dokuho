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
        [self.view addSubview:self.displayImageView];
    }
    
    { // Init Button (Date)
        self.startDateAtScheduledTaskButton = [UIButton.alloc initWithFrame:CGRectMake(50, 405, 220, 30)];
        [self.startDateAtScheduledTaskButton  setTitle:[self getNowDateString] forState:UIControlStateNormal];
        self.startDateAtScheduledTaskButton.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:self.startDateAtScheduledTaskButton];
    }
    
    { // Init TextField (Memo)
        self.memoAtScheduledTaskTextField = [UITextField.alloc initWithFrame:CGRectMake(50, 450, 220, 100)];
        self.memoAtScheduledTaskTextField.backgroundColor = [UIColor grayColor];
        self.memoAtScheduledTaskTextField.returnKeyType = UIReturnKeyDone;
        [self.view addSubview:self.memoAtScheduledTaskTextField];
        self.memoAtScheduledTaskTextField.delegate = self;
    }
    
    { // Init TextField(Title)
        self.titleAtScheduledTaskTextField = [UITextField.alloc initWithFrame:CGRectMake(50, 365, 220, 30)];
        self.titleAtScheduledTaskTextField.backgroundColor = [UIColor grayColor];
        self.titleAtScheduledTaskTextField.returnKeyType = UIReturnKeyDone;
        [self.view addSubview:self.titleAtScheduledTaskTextField];
        self.titleAtScheduledTaskTextField.delegate = self;
    }
    
    UIBarButtonItem *save = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                        target:self
                                                                        action:@selector(save:)];
    [self.navigationItem setRightBarButtonItem:save animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.startDateAtScheduledTaskButton addTarget:self
                        action:@selector(pushDateButton:)
              forControlEvents:UIControlEventTouchUpInside];
    
    if (self.picturedScheduledTask) {
        self.titleAtScheduledTaskTextField.text = self.picturedScheduledTask.title;
        self.memoAtScheduledTaskTextField.text = self.picturedScheduledTask.memo;
        self.startDateAtScheduledTaskButton.titleLabel.text = [self getStringWithDate:self.picturedScheduledTask.date];
        self.displayImageView.image = self.picturedScheduledTask.picture;
    }
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
    self.startDateAtScheduledTaskButton.titleLabel.text = [self getStringWithDate:datePicker.date];
    
	//ピッカーをしまう
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)pushCancelButton:(id)sender {
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)save:(id)sender {
    PicturedScheduledTask *picturedScheduledTask = [PicturedScheduledTask.alloc initWithPicture:self.displayImageView.image];
    picturedScheduledTask.memo = self.memoAtScheduledTaskTextField.text;
    picturedScheduledTask.title = self.titleAtScheduledTaskTextField.text;
    picturedScheduledTask.date = [self getDateWithString:self.startDateAtScheduledTaskButton.titleLabel.text];
    
    if (picturedScheduledTask.fileNmae) {
        [ScheduledTaskManager.alloc saveScheduledTask:picturedScheduledTask fileName:picturedScheduledTask.fileNmae];
    } else {
        picturedScheduledTask.fileNmae = [self getScheduledTaskTitle];
        [ScheduledTaskManager.alloc saveScheduledTask:picturedScheduledTask fileName:[self getScheduledTaskTitle]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pushDateButton:(id)sender {
    [self showDatePicker];
}

#pragma mark - Method

- (void)showDatePicker {
    // Init ActionSheet
    actionSheet = [UIActionSheet.alloc initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
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
        datePicker.date = [self getDateWithString:self.startDateAtScheduledTaskButton.titleLabel.text];
        [self.view addSubview:datePicker];
    }
    
    [actionSheet addSubview:toolBar];
    [actionSheet addSubview:datePicker];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 480)];

}

- (NSString *)getScheduledTaskTitle {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
