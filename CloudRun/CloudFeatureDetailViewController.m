//
//  CloudFeatureDetailViewController.m
//  CloudRun
//
//  Created by PAN on 2014/10/15.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudFeatureDetailViewController.h"

@interface CloudFeatureDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *VideoOrPhotoView;
@property (weak, nonatomic) IBOutlet UIImageView *PhotoImageview;


@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end

@implementation CloudFeatureDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	if ( [self.kind isEqualToString:@"相片"] ) {
		[self photo];
	}
	else if ( [self.kind isEqualToString:@"影片"] ) {
		[self video];
	}
    // Do any additional setup after loading the view.
}

- (void) video
{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"nikegirlsrun" ofType:@"mp4"];
	NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
	
	self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:sourceMovieURL];
	self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
	self.moviePlayer.repeatMode = MPMovieRepeatModeNone;
	self.moviePlayer.controlStyle = MPMovieControlStyleDefault;
	self.moviePlayer.repeatMode = MPMovieRepeatModeOne;
	
	self.moviePlayer.view.frame = self.VideoOrPhotoView.bounds;
	[self.VideoOrPhotoView addSubview:self.moviePlayer.view];
	[self.moviePlayer play];
	self.PhotoImageview.hidden = YES;
}

- (void) photo
{
	self.VideoOrPhotoView.hidden = YES;
}

@end
