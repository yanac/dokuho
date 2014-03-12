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
@property (nonatomic, strong) NSArray *scheduledTasks;

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
    return self.scheduledTasks.count;
}

// セクションに応じたセルの数を返す
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.scheduledTasks objectAtIndex:section] count];
}

// セルオブジェクトを返す
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ScheduledTaskViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    UIImage *scheduledTaskImage = [[self.scheduledTasks[indexPath.section] objectAtIndex:indexPath.item] picture];
    UIImage *cellImage;

    if (scheduledTaskImage) {
        cellImage = [scheduledTaskImage resizeIfOverSize:cell.imageView.frame.size];
    } else {
        cellImage = [[UIImage imageNamed:@"NOImage.jpg"] resizeIfOverSize:cell.imageView.frame.size];
    }
    cell.imageView.image = cellImage;
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // コレクションビューの選択を可能にする
    // ScheduledTaskViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    RegistrationViewController *registrationViewController = [RegistrationViewController.alloc init];
    registrationViewController.picturedScheduledTask = [self.scheduledTasks[indexPath.section] objectAtIndex:indexPath.item];
    
    [self.navigationController pushViewController:registrationViewController animated:YES];
    [registrationViewController initializeDisplayImage:[[self.scheduledTasks[indexPath.section] objectAtIndex:indexPath.item] picture]];
    
    return YES;
}

#pragma mark - Method

- (void)loadScheduledTasks {
    NSArray *scheduledTask = [ScheduledTaskManager.alloc loadScheduledTasks];
    NSMutableArray *scheduledTasks = [NSMutableArray array];
    NSMutableArray *tasks = [NSMutableArray array];
    
    int i = 0;
    
    for (scheduledTasks in scheduledTask) {
        PicturedScheduledTask *task = [ScheduledTaskManager.alloc decodePictureScheduledTask:[NSString stringWithFormat:@"%@", scheduledTask[i]]];
        [tasks addObject:task];
        i++;
    }
    self.scheduledTasks = @[tasks];
}

@end
