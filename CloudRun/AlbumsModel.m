//
//  AlbumsModel.m
//  CloudRun
//
//  Created by PAN on 2014/8/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "AlbumsModel.h"

@implementation AlbumsModel

- (AlbumsModel *) init
{
	if (self = [super init]) {
		self.albumsId = [[NSString alloc] init];
		self.name = [[NSString alloc] init];
		self.photoNumbers = [[NSString alloc] init];
		self.url = [[NSString alloc] init];
	}
	return  self;
}

@end
