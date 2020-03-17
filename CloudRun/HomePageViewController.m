//
//  HomePageViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/29.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "HomePageViewController.h"

#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height


#define BUTTON_X self.currentButton.frame.origin.x
#define BUTTON_Y self.currentButton.frame.origin.y
#define BUTTON_WIDTH self.currentButton.frame.size.width
#define BUTTON_HEIGHT self.currentButton.frame.size.height

@interface HomePageViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *LoginBarButton;
@property (weak, nonatomic) IBOutlet UIPageControl *ButtonPageControll;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *Buttons;

@property (strong, nonatomic) CloudRunAppDelegate *app;
@property (strong, nonatomic) UIButton *currentButton;

@property (nonatomic) UIDynamicAnimator *animator;

@end

@implementation HomePageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.app = [[UIApplication sharedApplication] delegate];
	[self showButton];
}

#pragma mark - Handle Press Button Event

- (IBAction)pressTodayEvent:(UIButton *)sender {
	NSLog(@"%@", self.app.identity);
	if ([self.app.identity isEqualToString:@"Visitor"]) {
		[self showLoginAlertView];
	}
}

#pragma mark - Hanlde Gesture

- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender {
	
	switch (sender.direction) {
		
		case UISwipeGestureRecognizerDirectionLeft:
			if ( self.ButtonPageControll.currentPage < [self.Buttons count] - 1 ) {
				self.ButtonPageControll.currentPage++;
				[self buttonAnmationWithDirection:NO];
			}
			break;
			
		case UISwipeGestureRecognizerDirectionRight:
			if ( self.ButtonPageControll.currentPage > 0) {
				self.ButtonPageControll.currentPage--;
				[self buttonAnmationWithDirection:YES];
			}
			break;
			
		default:
			break;
	}
}

#pragma mark - Use Button Page Controller Show Button
- (void) showButton
{
	for (UIButton *button in self.Buttons) {
		
		if (self.ButtonPageControll.currentPage == 0) {
			if ([button.restorationIdentifier isEqualToString:@"即時賽事"]) {
				NSLog(@"%@", button.restorationIdentifier);
				button.hidden = NO;
				self.currentButton = button;
			} else {
				button.hidden = YES;
			}
		}
		else if (self.ButtonPageControll.currentPage == 1) {
			if ([button.restorationIdentifier isEqualToString:@"賽事回憶"]) {
				button.hidden = NO;
				self.currentButton = button;
			} else {
				button.hidden = YES;
			}
		}
		else if (self.ButtonPageControll.currentPage == 2) {
			if ([button.restorationIdentifier isEqualToString:@"當日賽事"]) {
				button.hidden = NO;
				self.currentButton = button;
			} else {
				button.hidden = YES;
			}
		}
		else if (self.ButtonPageControll.currentPage == 3) {
			if ([button.restorationIdentifier isEqualToString:@"雲端加油聲"]) {
				button.hidden = NO;
				self.currentButton = button;
			} else {
				button.hidden = YES;
			}
		}
	}
}

#pragma mark - Handle Animation

- (void) buttonAnmationWithDirection:(BOOL) isRight
{
	CGRect originButtonPos = self.currentButton.frame;
	if (isRight) {
		// direction right
		[UIView animateWithDuration:0.5
						 animations:^(void){
							 self.currentButton.frame = CGRectMake(VIEW_WIDTH + BUTTON_WIDTH, BUTTON_Y, BUTTON_WIDTH, BUTTON_HEIGHT);
						 }
						 completion:^(BOOL finished) {
							 self.currentButton.frame = originButtonPos;
							 [self showButton];
						 }];
	} else {
		// direction left
		[UIView animateWithDuration:0.5
						 animations:^(void){
							 self.currentButton.frame = CGRectMake(-BUTTON_WIDTH , BUTTON_Y, BUTTON_WIDTH, BUTTON_HEIGHT);
						 }
						 completion:^(BOOL finished) {
							 self.currentButton.frame = originButtonPos;
							 [self showButton];
						 }];
	}
}

#pragma mark - Hanlde Alertview

- (void) showLoginAlertView
{
	UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Warning"
												 message:@"Please Log in Your Identity"
												delegate:self
									   cancelButtonTitle:@"Cancel"
									   otherButtonTitles:@"Login", nil];
	[av show];
}

#pragma mark - Hnadle Alertview Delegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
			NSLog(@"cancel");
			break;
			
		case 1:
			NSLog(@"log");
			LoginViewController *logVC = (LoginViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LogViewStoryIdentity"];
			[self presentViewController:logVC animated:YES completion:nil];
			break;
	}
}

#pragma mark - Navigation

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
	if ([identifier isEqualToString:@"TodayEventSegue"]) {
		if ([self.app.identity isEqualToString:@"Visitor"]) {
			return NO;
		}
	}
	return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end