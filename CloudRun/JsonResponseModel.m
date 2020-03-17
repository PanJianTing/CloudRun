//
//  JsonResponseModel.m
//  CloudRun
//
//  Created by PAN on 2014/8/14.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "JsonResponseModel.h"


@implementation JsonResponseModel

- (NSDictionary *) getJsonAllPlayer
{
	NSString *lookUpString = [NSString stringWithFormat:@"http://tlca.leadtek.com.tw/sportAPI/userInfo"];
	lookUpString = [lookUpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSData *jsonResponse = [NSData dataWithContentsOfURL:[NSURL URLWithString:lookUpString]];
	
	if (jsonResponse) {
		NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonResponse options:kNilOptions error:nil];
		return jsonDict;
	}
	return nil;
}


- (NSDictionary *) getJsonOnePlayerWithID : (NSString *) playerID
{
	NSString *lookUpString = [NSString stringWithFormat:@"http://tlca.leadtek.com.tw/sportAPI/trackInfo?userId=%@", playerID];
	lookUpString = [lookUpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSData *jsonResponse = [NSData dataWithContentsOfURL:[NSURL URLWithString:lookUpString]];
	
	if (jsonResponse) {
		NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonResponse options:kNilOptions error:nil];
		return jsonDict;
	}
	return nil;
}

@end