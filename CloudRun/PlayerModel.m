//
//  PlayerModel.m
//  CloudRun
//
//  Created by PAN on 2014/9/3.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "PlayerModel.h"

@implementation PlayerModel

- (id) init
{
	if (self = [super init]) {
		self.number = [[NSString alloc] init];
		self.name = [[NSString alloc] init];
		self.photo = [[NSString alloc] init];
		self.sex = [[NSString alloc] init];
		self.city = [[NSString alloc] init];
		self.followCount = 0;
		self.tracker = [[NSMutableArray alloc] init];
	}
	return self;
}

@end
