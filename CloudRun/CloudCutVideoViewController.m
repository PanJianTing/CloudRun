//
//  CloudCutVideoViewController.m
//  CloudRun
//
//  Created by PAN on 2014/10/3.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudCutVideoViewController.h"

@interface CloudCutVideoViewController ()
@property (weak, nonatomic) IBOutlet UIView *VideoView;

@property (weak, nonatomic) IBOutlet UILabel *StartLabel;
@property (weak, nonatomic) IBOutlet UILabel *EndLabel;

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end

@implementation CloudCutVideoViewController

- (void) viewDidDisappear:(BOOL)animated
{
	[self.moviePlayer pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self video];
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
	
	self.moviePlayer.view.frame = self.VideoView.bounds;
	[self.VideoView addSubview:self.moviePlayer.view];
	[self.moviePlayer play];
}

#pragma mark - Handle Press Button Event

- (IBAction)pressCutVideoButton:(id)sender {
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"nikegirlsrun" ofType:@"mp4"];
	if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path)) {
		UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
	}
	
	//NSURL *srcURL = [[NSBundle mainBundle] URLForResource:@"nikegirlsrun" withExtension:@"mp4"];
	//[self saveToCameraRoll:srcURL];
	
}

- (void)video:(NSData *)video didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	if (!error) {
		NSLog(@"no error%@", error);
	} else {
		NSLog(@"%@", error);
	}
}


- (IBAction)pressStartUp:(id)sender {
	
}

- (IBAction)pressStartDown:(id)sender {
}

- (IBAction)pressEndUp:(id)sender {
}

- (IBAction)pressEndDown:(id)sender {
}

- (void) saveToCameraRoll:(NSURL *)srcURL
{
	ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
	ALAssetsLibraryWriteVideoCompletionBlock videoWriteCompletionBlock =
	^(NSURL *newURL, NSError *error) {
		if (error) {
			NSLog( @"Error writing image with metadata to Photo Library: %@", error );
		} else {
			NSLog( @"Wrote image with metadata to Photo Library %@", newURL.absoluteString);
		}
	};
	
	if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:srcURL])
	{
		[library writeVideoAtPathToSavedPhotosAlbum:srcURL
									completionBlock:videoWriteCompletionBlock];
	}
}

@end
