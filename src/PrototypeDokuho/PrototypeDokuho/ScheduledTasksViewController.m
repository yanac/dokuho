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

@interface ScheduledTasksViewController ()
@property (nonatomic, strong) NSArray *ScheduledTaskTitles;
@property (nonatomic, strong) NSArray *ScheduledTaskImages;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
// セクション数の指定
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.ScheduledTaskImages.count;
}

// セクションに応じたセルの数を返す
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.ScheduledTaskImages objectAtIndex:section] count];
}

// セルオブジェクトを返す
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ScheduledTaskViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    cell.imageView.image = [[self.ScheduledTaskImages objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    
    return cell;
}

#pragma mark - Method

- (void)loadScheduledTasks {
    NSArray *scheduledTasks = [ScheduledTaskManager.alloc loadScheduledTasks];
    NSMutableArray *scheduledTask = [NSMutableArray array];
    NSMutableArray *images = [NSMutableArray array];
    int i = 0;
    
    for (scheduledTask in scheduledTasks) {
        NSLog(@"%@", [scheduledTasks objectAtIndex:i]);
        PicturedScheduledTask *task = [ScheduledTaskManager.alloc decodePictureScheduledTask:[NSString stringWithFormat:@"%@", [scheduledTasks objectAtIndex:i]]];
        if (task.picture != nil) {
            [images addObject:task.picture];
        } else {
            [images addObject:[UIImage imageNamed:@"NOImage.jpg"]];
        }
    }
    self.ScheduledTaskImages = @[images];
}

@end
