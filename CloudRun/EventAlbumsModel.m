//
//  EventAlbumsModel.m
//  CloudRun
//
//  Created by PAN on 2014/8/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "EventAlbumsModel.h"

@implementation EventAlbumsModel

- (EventAlbumsModel *) init
{
	if (self = [super init]) {
		self.eventAlbumsId = [[NSString alloc] init];
		self.eventDate = [[NSString alloc] init];
		self.event = [[NSString alloc] init];
		self.alumbs = [[NSMutableArray alloc] init];
	}
	return self;
}

@end
