//
//  VideoCollectionViewCell.m
//  CloudRun
//
//  Created by PAN on 2014/10/6.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "VideoCollectionViewCell.h"

@implementation VideoCollectionViewCell

/*
- (void) videoSetWithVideoName:(NSString *)name Type:(NSString *)type
{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
	NSURL *sourceURL = [NSURL fileURLWithPath:filePath];
	self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:sourceURL];
	self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
	self.moviePlayer.controlStyle = MPMovieControlStyleDefault;
	self.moviePlayer.repeatMode = MPMovieRepeatModeOne;
	
	self.moviePlayer.view.frame = self.VideoView.bounds;
	[self.VideoView addSubview:self.moviePlayer.view];
	//[self.moviePlayer prepareToPlay];
	[self.moviePlayer play];
}
*/

@end
