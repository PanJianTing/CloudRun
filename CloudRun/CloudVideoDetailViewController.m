//
//  CloudVideoDetailViewController.m
//  CloudRun
//
//  Created by PAN on 2014/10/8.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudVideoDetailViewController.h"

@interface CloudVideoDetailViewController ()

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end

@implementation CloudVideoDetailViewController

- (void) viewDidDisappear:(BOOL)animated
{
	[self.moviePlayer stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"nikegirlsrun" ofType:@"mp4"];
	NSURL *sourceURL = [NSURL fileURLWithPath:filePath];
	self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:sourceURL];
	self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
	self.moviePlayer.controlStyle = MPMovieControlStyleDefault;
	self.moviePlayer.repeatMode = MPMovieRepeatModeOne;
	
	self.moviePlayer.view.frame = self.view.bounds;
	[self.view addSubview:self.moviePlayer.view];
	//[self.moviePlayer prepareToPlay];
	[self.moviePlayer play];
	
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
