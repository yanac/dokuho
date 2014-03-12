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

@interface ScheduledTasksViewController ()
@property (nonatomic, strong) NSArray *scheduledTasks;
@property (nonatomic, strong) NSArray *scheduledTaskImages;

@end

@implementation ScheduledTasksViewController

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self loadScheduledTasks];
    
    [self.collectionView registerClass:[ScheduledTaskViewCell class] forCellWithReuseIdentifier:@"MY_CELL"];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadScheduledTasks];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
// セクション数の指定
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.scheduledTaskImages.count;
}

// セクションに応じたセルの数を返す
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.scheduledTaskImages objectAtIndex:section] count];
}

// セルオブジェクトを返す
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ScheduledTaskViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    cell.imageView.image = [[self.scheduledTaskImages objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // コレクションビューの選択を可能にする
    // ストーリボードを利用してCollectionViewCellから表示する画面にPush接続しいておく
    ScheduledTaskViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    RegistrationViewController *RVC = [RegistrationViewController.alloc init];
    RVC.picturedScheduledTask = [[self.scheduledTasks objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    
    [self.navigationController pushViewController:RVC animated:YES];
    
    if (cell.imageView.image) {
        [RVC initializeDisplayImage:cell.imageView.image];
    } else {
        [RVC initializeDisplayImage:[UIImage imageNamed:@"NOImage.jpg"]];
    }
    
    return YES;
}

#pragma mark - Method

- (void)loadScheduledTasks {
    NSArray *scheduledTask = [ScheduledTaskManager.alloc loadScheduledTasks];
    NSMutableArray *scheduledTasks = [NSMutableArray array];
    NSMutableArray *images = [NSMutableArray array];
    NSMutableArray *tasks = [NSMutableArray array];
    
    int i = 0;
    
    for (scheduledTasks in scheduledTask) {
        PicturedScheduledTask *task = [ScheduledTaskManager.alloc decodePictureScheduledTask:[NSString stringWithFormat:@"%@", [scheduledTask objectAtIndex:i]]];
        [tasks addObject:task];
        if (task.picture != nil) {
            [images addObject:task.picture];
        } else {
            [images addObject:[UIImage imageNamed:@"NOImage.jpg"]];
        }
        i++;
    }
    self.ScheduledTasks = @[tasks];
    self.ScheduledTaskImages = @[images];
}

@end
