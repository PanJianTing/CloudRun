//
//  LoginViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/25.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSString *password;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - Hnadle Lonin Weight

- (void) setIdentity: (NSString *) identity
{
	CloudRunAppDelegate *app = [[UIApplication sharedApplication] delegate];
	app.identity = identity;
}

#pragma mark - Handle Press Button Event

- (IBAction)pressCancelAndFamilyButton:(id)sender {
	if ([sender isKindOfClass:[UIButton class]]) {
		[self setIdentity:@"Family"];
	} else {
		[self setIdentity:@"Visitor"];
	}
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressRefereeButton:(UIButton *)sender {
	[self setIdentity:@"Referee"];
	[self loginAlertView:@"Referee Login"];
}

- (IBAction)pressRunnerButton:(UIButton *)sender {
	[self setIdentity:@"Runner"];
	[self loginAlertView:@"Runner Login"];
}

- (void) loginAlertView : (NSString *)title
{
	UIAlertView *av = [[UIAlertView alloc] initWithTitle:title
												 message:nil
												delegate:self
									   cancelButtonTitle:@"Cancel"
									   otherButtonTitles:@"Login", nil];
	av.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
	[av show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
			
		case 1:
			self.account = [alertView textFieldAtIndex:0].text;
			self.password = [alertView textFieldAtIndex:1].text;
			[self dismissViewControllerAnimated:YES completion:nil];
			break;
			
		default:
			break;
	}
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
