//
//  TableviewDelegate.h
//  CloudRun
//
//  Created by PAN on 2014/7/23.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataHelper.h"

@interface KindTableviewDelegate : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) NSMutableArray *kindArray;

- (KindTableviewDelegate *) initWithVariable;
- (NSMutableArray *)selectTalbleViewDataArray : (int)select;


@end
