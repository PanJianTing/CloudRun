//
//  MemoryEventTableViewCell.m
//  CloudRun
//
//  Created by PAN on 2014/8/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "MemoryEventTableViewCell.h"

#define TABLE_PADDING 44


@implementation MemoryEventTableViewCell

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


@end
