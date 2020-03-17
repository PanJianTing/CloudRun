//
//  SearchViewController.h
//  CloudRun
//
//  Created by PAN on 2014/7/30.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionLabelCell.h"
#import "EventViewController.h"
#import "SearchResultTableViewController.h"
#import "ResultsAlbumsTableViewController.h"

@interface SearchViewController : UIViewController <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *DateCollectionView;

@property (strong, nonatomic) NSString *month;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSMutableArray *dateArray;

- (void) updateDate;
- (void) keyboardDown;

@end
