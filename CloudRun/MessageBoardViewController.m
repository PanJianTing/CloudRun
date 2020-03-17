//
//  MessageBoardViewController.m
//  CloudRun
//
//  Created by PAN on 2014/9/4.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "MessageBoardViewController.h"

@interface MessageBoardViewController ()

@property (strong, nonatomic) NSMutableArray *allMessageArray;
@property (strong, nonatomic) DataHelper *dh;

@end

@implementation MessageBoardViewController

- (void) viewWillAppear:(BOOL)animated
{
	[self getMessageData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.dh = [[DataHelper alloc] init];
}

#pragma mark - Handle reload Data

- (void)getMessageData
{
	self.allMessageArray = [self.dh sqlSelectModelCommand:@"Select *"
												fromTable:@"cloud_message"
													where:[NSString stringWithFormat:@"Where userId = '%ld'",(long)self.playerId]
													order:@"order by autoId DESC"];
}


#pragma mark - Handle Tableview Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.allMessageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"MessageCell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
	if (cell == nil) {
		cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	
	PlayerMessageModel *messageModel = [self.allMessageArray objectAtIndex:indexPath.row];
	
	cell.NameLabel.text = messageModel.senderName;
	cell.MessageLabel.text = messageModel.message;
	
	return cell;
}
@end
