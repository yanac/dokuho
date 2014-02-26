//
//  BooksViewController.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/02/26.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "BooksViewController.h"
#import "BooksViewCell.h"

@interface BooksViewController ()
@property (nonatomic, strong) NSArray *bookTitles;
@property (nonatomic, strong) NSArray *bookImages;

@end

@implementation BooksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self loadTestPhotos];
    
    [self.collectionView registerClass:[BooksViewCell class] forCellWithReuseIdentifier:@"MY_CELL"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTestPhotos {
    
    NSMutableArray *Images = [NSMutableArray array];
    for (int i = 1; i <= 8; i++) {
        NSString *filename = [NSString stringWithFormat:@"bookImage%d.jpg", i];
        [Images addObject:[UIImage imageNamed:filename]];
    }
    
    self.bookImages = @[Images];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.bookImages objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    BooksViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    
    cell.imageView.image = [[self.bookImages objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.bookImages count];
}


@end
