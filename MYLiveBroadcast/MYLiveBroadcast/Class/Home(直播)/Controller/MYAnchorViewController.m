//
//  MYAnchorViewController.m
//  MYLiveBroadcast
//
//  Created by mayan on 2017/10/9.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYAnchorViewController.h"
#import "MYWaterFallLayout.h"


@interface MYAnchorViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation MYAnchorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MYWaterFallLayout *layout = [[MYWaterFallLayout alloc] init];
    
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, MYStatusBarH + MYNavigationBarH + MYTabBarH + 44, 0);  // nav + tabBar + titleViewHeight
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:collectionView];
}

#pragma mark - collectionView delegate and dataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = MYRandomColor;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}


@end
