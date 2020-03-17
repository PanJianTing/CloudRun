//
//  VideoCollectionViewCell.h
//  CloudRun
//
//  Created by PAN on 2014/10/6.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *RunnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *ClickLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;

//@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

//- (void) videoSetWithVideoName:(NSString *)name Type:(NSString *)type;


@end
