//
//  WebViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self checkNetwork];
}

- (void) connectWebview
{
	NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
	
	NSOperationQueue *queue = [NSOperationQueue new];
	
	[NSURLConnection sendAsynchronousRequest:request queue:queue
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
							   if ([data length] > 0 && error == nil) {
								   NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
								   [self.webView loadHTMLString:html baseURL:self.url];
								   [self.activity stopAnimating];
								   self.activity.hidden = YES;
							   } else {
								   NSLog(@"Download url error %@", error);
							   }
						   }];
}

- (void) showInternetErrorAlert
{
	UIAlertView *networkErrorAlert = [[UIAlertView alloc] initWithTitle:@"Network Error"
																message:@"Sorry, Please check Your Network!"
															   delegate:self
													  cancelButtonTitle:@"Cancel"
													  otherButtonTitles:@"Setting", nil];
	[networkErrorAlert show];
}

 - (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
			[self.navigationController popViewControllerAnimated:YES];
			break;
			
		case 1:
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
			break;
			
		default:
			break;
	}
}



- (void) checkNetwork
{
	Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
	NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
	
	if (networkStatus == NotReachable) {
		[self showInternetErrorAlert];
	} else {
		[self connectWebview];
	}

}


@end
