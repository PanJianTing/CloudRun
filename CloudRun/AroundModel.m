//
//  AroundModel.m
//  CloudRun
//
//  Created by PAN on 2014/10/17.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "AroundModel.h"

@implementation AroundModel


- (AroundModel *) init
{
	if ( self = [super init] ) {
		self.aroundId = [[NSString alloc] init];
		self.name = [[NSString alloc] init];
		self.lat = [[NSString alloc] init];
		self.lng = [[NSString alloc] init];
	}
	return self;
}


@end
