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
@property (nonatomic, strong) NSMutableArray *scheduledTaskThumbnails;

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

// cell用画像の再読み込み
- (void)viewWillAppear:(BOOL)animated {
    self.scheduledTaskThumbnails = [NSMutableArray array];
    self.scheduledTaskThumbnails = [ScheduledTaskManager.alloc getScheduledTasksThumbnail];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
// セクション数の指定
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// セクションに応じたセルの数を返す
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.scheduledTaskThumbnails.count;
}

// セルオブジェクトを返す
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ScheduledTaskViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    
    UIImage *cellImage;
    if ([self.scheduledTaskThumbnails[indexPath.item] isMemberOfClass:[UIImage class]] ) {
        cellImage = self.scheduledTaskThumbnails[indexPath.item];
    } else if ([self.scheduledTaskThumbnails[indexPath.item]  isEqual:@""]) {
        cellImage = [[UIImage imageNamed:@"NOImage.jpg"] resizeIfOverSize:cell.imageView.frame.size];
    }
    cell.imageView.image = cellImage;
    
    return cell;
}

// コレクションビューの選択を可能にする
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RegistrationViewController *registrationViewController = [RegistrationViewController.alloc init];
    registrationViewController.picturedScheduledTask = [ScheduledTaskManager.alloc getDecodedScheduledTasks][indexPath.item];
    
    [self.navigationController pushViewController:registrationViewController animated:YES];
    
    return YES;
}

@end
