//
//  RegistrationViewController.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/03.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

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

- (void)initWithDisplayImage:(UIImage *)image {
    [self initDisplayImageView];
    self.displayImageView.image = image;
}

- (void)initDisplayImageView {
    self.displayImageView = [UIImageView.alloc initWithFrame:CGRectMake(70, 80, 180, 280)];
}

- (void)loadView {
    self.view = [UIView.alloc init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    { // Init ImageView
        [self.view addSubview:self.displayImageView];
    }
    
    { // Init Button (Date)
        self.dateButton = [UIButton.alloc initWithFrame:CGRectMake(50, 380, 220, 50)];
        [self.dateButton  setTitle:[self getNowDateString] forState:UIControlStateNormal];
        self.dateButton.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:self.dateButton];
    }
    
    { // Init TextField (MEMO)
        self.memoTextField = [UITextField.alloc initWithFrame:CGRectMake(50, 450, 220, 100)];
        self.memoTextField.backgroundColor = [UIColor grayColor];
        self.memoTextField.returnKeyType = UIReturnKeyDone;
        [self.view addSubview:self.memoTextField];
    }
    
    self.memoTextField.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dateButton addTarget:self
                        action:@selector(pushDateButton:)
              forControlEvents:UIControlEventTouchUpInside];
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

- (void)done:(id)sender {
    //dateTextFieldにdatePickerのdateを表示
    self.dateButton.titleLabel.text = [self getDateStringWithDate:self.datePicker.date];
    
	//ピッカーをしまう
    [self.datePicker removeFromSuperview];
	
	//doneボタンを消す
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

- (IBAction)pushDateButton:(id)sender {
    [self showDatePicker];
}

#pragma mark - Method

- (void)showDatePicker {
    { // Init DatePicker
        self.datePicker = [UIDatePicker.alloc initWithFrame:CGRectMake(0, 300, 200, 300)];
        self.datePicker.backgroundColor = [UIColor whiteColor];
        self.datePicker.date = [self getDateWithString:self.dateButton.titleLabel.text];
        [self.view addSubview:self.datePicker];
    }
	
	//ナビゲーションバーの右上にdoneボタンを設置する
	if (!self.navigationItem.rightBarButtonItem) {
        UIBarButtonItem *done = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                            target:self
                                                                            action:@selector(done:)];
        [self.navigationItem setRightBarButtonItem:done animated:YES];
    }
}

- (NSString *)getNowDateString {
    NSDate *nowDate = [NSDate.alloc init];
    return [self getDateStringWithDate:nowDate];
}

- (NSString *)getDateStringWithDate:(NSDate *)date {
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
