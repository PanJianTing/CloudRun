//
//  CloudHomePageViewController.m
//  CloudRun
//
//  Created by PAN on 2014/9/30.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudHomePageViewController.h"

#define SEARCH_WIDTH self.SearchContainer.frame.size.width
#define SEARCH_HEIGHT self.SearchContainer.frame.size.height


@interface CloudHomePageViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *HomepageLiveSegmentedController;
@property (weak, nonatomic) IBOutlet UIView *HotVideoContainer;
@property (weak, nonatomic) IBOutlet UIView *HistoryVideoContainer;
@property (weak, nonatomic) IBOutlet UIView *LiveVideoContainer;
@property (weak, nonatomic) IBOutlet UIView *SearchContainer;

@property BOOL isShow;

@end

@implementation CloudHomePageViewController

- (void) viewWillAppear:(BOOL)animated
{
	self.isShow = NO;
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - Handle Switch Segmente

- (IBAction)switchSegmented:(UISegmentedControl *)sender {
	
	switch (sender.selectedSegmentIndex) {
		case 0:
			self.HotVideoContainer.hidden = NO;
			self.HistoryVideoContainer.hidden = NO;
			self.LiveVideoContainer.hidden = YES;
			break;
			
		case 1:
			self.HotVideoContainer.hidden = YES;
			self.HistoryVideoContainer.hidden = YES;
			self.LiveVideoContainer.hidden = NO;
			break;
			
		default:
			break;
	}
}

#pragma mark - Handle Press BarButton

- (IBAction)pressSearchButton:(UIBarButtonItem *)sender {
	
	
	if ( self.isShow ) {
		[UIView animateWithDuration:0.3
						 animations:^(void){
							 self.SearchContainer.frame = CGRectMake(0, 20, SEARCH_WIDTH, SEARCH_HEIGHT);
						 }
						 completion:^(BOOL finished) {
							 self.isShow = NO;
						 }];
	} else {
		[UIView animateWithDuration:0.3
						 animations:^(void){
							 self.SearchContainer.frame = CGRectMake(0, 64, SEARCH_WIDTH, SEARCH_HEIGHT);
						 }
						 completion:^(BOOL finished) {
							 self.isShow = YES;
						 }];
	}
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
