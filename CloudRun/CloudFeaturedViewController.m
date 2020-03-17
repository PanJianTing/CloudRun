//
//  CloudFeaturedViewController.m
//  CloudRun
//
//  Created by PAN on 2014/10/2.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudFeaturedViewController.h"

@interface CloudFeaturedViewController ()

@end

@implementation CloudFeaturedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = self.kind;
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
	
	//[cell videoSetWithVideoName:@"nikegirlsrun" Type:@"mp4"];
	
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"FeatureDetailSegue"]) {
		if ([segue.destinationViewController isKindOfClass:[CloudFeatureDetailViewController class]]) {
			CloudFeatureDetailViewController *cfdvc = segue.destinationViewController;
			cfdvc.kind = self.kind;
		}
	}
}


@end
