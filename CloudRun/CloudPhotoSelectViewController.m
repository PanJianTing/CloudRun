//
//  CloudPhotoSelectViewController.m
//  CloudRun
//
//  Created by PAN on 2014/10/15.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudPhotoSelectViewController.h"

@interface CloudPhotoSelectViewController ()

@property (strong, nonatomic) NSMutableArray *photoArray;
@property (strong, nonatomic) NSMutableArray *selectArray;

@end

@implementation CloudPhotoSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.photoArray = [[NSMutableArray alloc] init];
	self.selectArray = [[NSMutableArray alloc] init];
	
	[self photoNameArray];
	
    // Do any additional setup after loading the view.
}

- (void) showAlertView
{
	UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Save"
												 message:@"Save Complete！"
												delegate:nil
									   cancelButtonTitle:@"OK"
									   otherButtonTitles:nil];
	[av show];
}

#pragma mark - Handle Press Button Event

- (IBAction)pressSaveButton:(UIBarButtonItem *)sender {
	for (int i = 0; i < [self.selectArray count]; i++) {
		UIImage *image = [UIImage imageNamed:[self.selectArray objectAtIndex:i]];
		UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
	}
	[self.selectArray removeAllObjects];
	[self showAlertView];
}


#pragma mark - Handle Collection View Delegate

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"PhotoCell";
	
	PhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	
	if (cell == nil)
	{
		cell = [[PhotoCollectionCell alloc] init];
	}
	[cell.imageView setImage:[UIImage imageNamed:[self.photoArray objectAtIndex:indexPath.row]]];
	return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.photoArray count];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}



- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	PhotoCollectionCell *cell;
	cell = (PhotoCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
	[cell.imageView setAlpha:0.5];
	[self.selectArray addObject:[self.photoArray objectAtIndex:indexPath.row]];
}


- (void) photoNameArray
{
	for (int i = 4; i <= 60; i++) {
		NSString *iStr = [NSString stringWithFormat:@"%d", i];
		[self.photoArray addObject:[NSString stringWithFormat:@"nikegirlsrun %@.jpg",iStr]];
	}
}


@end
