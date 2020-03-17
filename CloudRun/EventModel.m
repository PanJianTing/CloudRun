//
//  EventModel.m
//  CloudRun
//
//  Created by PAN on 2014/7/25.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel

- (id) init
{
	if (self = [super init]) {
		self.area = [[NSString alloc] init];
		self.city = [[NSString alloc] init];
		self.catelog = [[NSString alloc] init];
		self.clickRate = [[NSString alloc] init];
		self.desc = [[NSString alloc] init];
		self.enroll = [[NSString alloc] init];
		self.eventCity = [[NSString alloc] init];
		self.eventId = [[NSString alloc] init];
		self.event = [[NSString alloc] init];
		self.eventDate = [[NSString alloc] init];
		self.hostBy = [[NSString alloc] init];
		self.item = [[NSString alloc] init];
		self.dateLimit = [[NSString alloc] init];
		self.location = [[NSString alloc] init];
		self.url = [[NSString alloc] init];
		self.year = [[NSString alloc] init];
	}
	return self;
}


@end
