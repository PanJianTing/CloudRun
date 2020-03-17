//
//  Location.m
//  CloudRun
//
//  Created by PAN on 2014/8/22.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id) init
{
	if (self = [super init]) {
		self.Id = [[NSString alloc] init];
		self.lat = [[NSString alloc] init];
		self.lng = [[NSString alloc] init];
		self.distance = [[NSString alloc] init];
		self.speed = [[NSString alloc] init];
		self.time = [[NSString alloc] init];
	}
	return self;
}

@end
