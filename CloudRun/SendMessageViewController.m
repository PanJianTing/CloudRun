//
//  SendMessageViewController.m
//  CloudRun
//
//  Created by PAN on 2014/9/5.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "SendMessageViewController.h"

#define NameText self.NameTextField.text
#define MessageText self.MessageTextField.text

@interface SendMessageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *NameTextField;
@property (weak, nonatomic) IBOutlet UITextField *MessageTextField;


@property (strong, nonatomic) DataHelper *dh;

@end

@implementation SendMessageViewController

- (void) viewWillAppear:(BOOL)animated
{
	self.view.layer.cornerRadius = 15;
	self.view.layer.masksToBounds = YES;
	self.view.layer.borderWidth = 2;
	self.view.layer.borderColor = [[UIColor grayColor] CGColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.dh = [[DataHelper alloc] init];
    // Do any additional setup after loading the view.
}

- (void) reloadMessage
{
	if ([self.parentViewController isKindOfClass:[MessageViewController class]]) {
		MessageViewController *mvc = (MessageViewController *)self.parentViewController;
		[mvc reloadMessageTableview];
	}
}

#pragma mark - Handle Button Press

- (IBAction)pressSendButton:(UIButton *)sender {
	
	if ( ![self.NameTextField.text isEqualToString:@""] && ![self.MessageTextField.text isEqualToString:@""] ) {
		[self.dh sqlInsertCommandWithTalbe:@"cloud_message(userId, senderName, Message)"
									Values:[NSString stringWithFormat:@"Values (%ld, '%@', '%@')", self.playerId, NameText, MessageText]];
		[self reloadMessage];
		[self.NameTextField resignFirstResponder];
		[self.MessageTextField resignFirstResponder];
		self.NameTextField.text = @"";
		self.MessageTextField.text = @"";
	} else {
		UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Warning"
													 message:@"Name or Message NOT blank"
													delegate:nil
										   cancelButtonTitle:@"OK"
										   otherButtonTitles:nil];
		[av show];
	}
}
@end
