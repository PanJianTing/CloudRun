//
//  CloudHotViewController.m
//  CloudRun
//
//  Created by PAN on 2014/10/6.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudHotViewController.h"

@interface CloudHotViewController ()

@end

@implementation CloudHotViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Handle Collectionview Delegate

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"VideoCollectCell";
	
	VideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	
	if (cell == nil)
	{
		cell = [[VideoCollectionViewCell alloc] init];
	}
	
	return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 6;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
