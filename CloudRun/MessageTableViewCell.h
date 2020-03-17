//
//  MessageTableViewCell.h
//  CloudRun
//
//  Created by PAN on 2014/9/4.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *MessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;


@end
