//
//  PlayerTableViewCell.h
//  CloudRun
//
//  Created by PAN on 2014/8/15.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *UserPhotoButton;
@property (weak, nonatomic) IBOutlet UILabel *PlayerNumerLabel;
@property (weak, nonatomic) IBOutlet UILabel *PlayerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PlayerRankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *PlayerRankImageView;

@end
