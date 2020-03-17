//
//  PlayerTableViewCell.m
//  CloudRun
//
//  Created by PAN on 2014/8/15.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "PlayerTableViewCell.h"

@implementation PlayerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pressPlayerButton:(UIButton *)sender {
	NSLog(@"press");
	[sender setShowsTouchWhenHighlighted:YES];
}

@end
