//
//  MYAnchorViewController.m
//  MYLiveBroadcast
//
//  Created by mayan on 2017/10/9.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYAnchorViewController.h"
#import "MYWaterFallLayout.h"
#import "MYAnchorCell.h"


@interface MYAnchorViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MYAnchorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    MYWaterFallLayout *layout = [[MYWaterFallLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, MYStatusBarH + MYNavigationBarH + MYTabBarH + 44, 0);  // nav + tabBar + titleViewHeight
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MYAnchorCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collectionView];
}

#pragma mark - collectionView delegate and dataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MYAnchorCell *cell = (MYAnchorCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemClickBlock) {
        self.itemClickBlock(self.dataArray[indexPath.item]);
    }
}

#pragma mark - set
- (void)setDataArray:(NSArray<MYAnchorModel *> *)dataArray
{
    _dataArray = dataArray;

    [self.collectionView reloadData];
}


@end
