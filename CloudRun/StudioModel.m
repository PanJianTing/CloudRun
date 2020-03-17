//
//  StudioModel.m
//  CloudRun
//
//  Created by PAN on 2014/10/2.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "StudioModel.h"

@implementation StudioModel

- (StudioModel *) init
{
	if ( self = [super init] ) {
		self.name = [[NSString alloc] init];
		self.location = [[NSString alloc] init];
	}
	return self;
}

@end
