//
//  MemoryEventTableViewCell.h
//  CloudRun
//
//  Created by PAN on 2014/8/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoryEventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ClickRateLabel;

@end
