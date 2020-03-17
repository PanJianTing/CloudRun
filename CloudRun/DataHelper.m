//
//  DataHelper.m
//  CloudRun
//
//  Created by PAN on 2014/7/25.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "DataHelper.h"

@implementation DataHelper

#pragma mark - Handle init

- (id) init
{
	if (self = [super init]) {
		[self ConnectDB];
	}
	return self;
}

- (id) initWithDBName : (NSString *)dbName
{
	if (self = [super init]) {
		[self ConnentDBWithName:dbName];
	}
	return self;
}

#pragma mark - Handle Database Connection

- (void) ConnectDB
{
	[self ConnentDBWithName:@"Runner_tw"];
}

- (void) ConnentDBWithName : (NSString *)dbName
{
	NSFileManager *fm = [[NSFileManager alloc] init];
	NSString *src = [[NSBundle mainBundle] pathForResource:dbName ofType:@"sqlite"];
	NSString *dst = [NSString stringWithFormat:@"%@/Documents/%@.sqlite", NSHomeDirectory(), dbName];
	
	if (![fm fileExistsAtPath:dst] ) {
		[fm copyItemAtPath:src toPath:dst error:nil];
	}
	
	// 與資料庫連線，並將連線結果存入db變數中
	if (sqlite3_open([dst UTF8String], &db) != SQLITE_OK) {
		db = nil;
		NSLog(@"Database Connect Error");
	}
}

#pragma mark - Handle Sql Insert Command

- (void) sqlInsertCommandWithTalbe:(NSString *)tableStr Values:(NSString *)valuesStr
{
	NSString *sqlStr = [NSString stringWithFormat:@"Insert into %@ %@", tableStr,valuesStr];
	const char *sql = [sqlStr UTF8String];
	char *insertErrorMsg;
	
	
	if (sqlite3_exec(db, sql, NULL, NULL, &insertErrorMsg) == SQLITE_OK) {
		NSLog(@"OK");
	}
	
}


#pragma mark - Handle Sql Conmmand

- (NSMutableArray *) sqlSelectModelCommand:(NSString *)selectStr fromTable:(NSString *)table
{
	return [self sqlSelectModelCommand:selectStr fromTable:table where:@"" group:@"" order:@""];
}

- (NSMutableArray *) sqlSelectModelCommand:(NSString *)selectStr fromTable:(NSString *)table where:(NSString *)whereStr
{
	return [self sqlSelectModelCommand:selectStr fromTable:table where:whereStr group:@"" order:@""];
}

- (NSMutableArray *) sqlSelectModelCommand:(NSString *)selectStr fromTable:(NSString *)table where:(NSString *)whereStr group:(NSString *)groupStr
{
	return [self sqlSelectModelCommand:selectStr fromTable:table where:whereStr group:groupStr order:@""];
}

- (NSMutableArray *) sqlSelectModelCommand:(NSString *)selectStr fromTable:(NSString *)table where:(NSString *)whereStr order:(NSString *)orderStr
{
	return [self sqlSelectModelCommand:selectStr fromTable:table where:whereStr group:@"" order:orderStr];
}

- (NSMutableArray *) sqlSelectModelCommand: (NSString *)selectStr fromTable:(NSString *)table where:(NSString *)whereStr group:(NSString *)groupStr order:(NSString *)orderStr
{
	NSMutableArray *resultArray = [[NSMutableArray alloc] init];
	NSString *sqlStr = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", selectStr, @"from ", table, whereStr, groupStr, orderStr];
	const char *sql = [sqlStr UTF8String];
	sqlite3_stmt *statement = nil;
	
	if ( sqlite3_prepare(db, sql, -1, &statement, NULL) == SQLITE_OK ) {
		while ( sqlite3_step(statement) == SQLITE_ROW ) {
			id model;
			model = [self selectModelWithTalbe:table sqlStmt:statement];
			[resultArray addObject:model];
		}
	}
	sqlite3_finalize(statement);
	return resultArray;
}

- (id) selectModelWithTalbe:(NSString *) table sqlStmt:(sqlite3_stmt *)statement
{
	if ([table isEqualToString:@"sportsnote_tw"]) {
		return [self setEventModelWithStatement:statement];
	}
	else if ([table isEqualToString:@"running_albumlist"]) {
		return [self setEventAlbumsModelWithStatement:statement];
	}
	else if ([table isEqualToString:@"running_albums"]) {
		return [self setAlbumsModelWithStatement:statement];
	}
	else if ([table isEqualToString:@"runner_tracker"]){
		return [self setLocationModelWithStatement:statement];
	}
	else if ([table isEqualToString:@"cloud_member"]){
		return [self setPlayerModelWithStatement:statement];
	}
	else if ([table isEqualToString:@"cloud_message"]){
		return [self setPlayerMessageModelWithStatement:statement];
	}
	else if ([table isEqualToString:@"food_jp"]){
		return [self setAroundModelWithStatement:statement];
	}
	else if ([table isEqualToString:@"shopping_jp"]){
		return [self setAroundModelWithStatement:statement];
	}
	else if ([table isEqualToString:@"hotel_jp"]){
		return [self setAroundModelWithStatement:statement];
	}
	else if ([table isEqualToString:@"hotspot_jp"]){
		return [self setAroundModelWithStatement:statement];
	} else {
		return nil;
	}
}

#pragma mark - Handle Single sqlite

- (NSMutableArray *) FetchDate:(NSString *)month  searchYear:(NSString *)year
{
	NSString *sqlStr = [NSString stringWithFormat:@"Select EVENT_DT_F from sportsnote_tw Where EVENT_DT_F Like '%@%@/%@' and YEAR_F Like '%@%@%@' Group By EVENT_DT_F",@"%", month, @"%", @"%", year, @"%"];
	const char *sql = [sqlStr UTF8String];
	sqlite3_stmt *statement = nil;
	
	NSMutableArray *dataArray = [[NSMutableArray alloc] init];
	
	if (sqlite3_prepare(db, sql, -1, &statement, NULL) == SQLITE_OK) {
		while (sqlite3_step(statement) == SQLITE_ROW ) {
			[dataArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
		}
	}
	sqlite3_finalize(statement);
	return dataArray;
}

- (NSMutableArray *) FetchAllKind
{
	NSMutableArray *kindArray = [[NSMutableArray alloc] init];
	NSString *sqlStr = [NSString stringWithFormat:@"select CATELOG_F from sportsnote_tw group by CATELOG_F"];
	
	const char *sql = [sqlStr UTF8String];
	sqlite3_stmt *statement = nil;
	
	if (sqlite3_prepare(db, sql, -1, &statement, NULL) == SQLITE_OK) {
		while (sqlite3_step(statement) == SQLITE_ROW ) {
			[kindArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
		}
	}
	
	sqlite3_finalize(statement);
	return kindArray;
}


- (NSMutableArray *) FetchAllYear
{
	NSMutableArray *yearArray = [[NSMutableArray alloc] init];
	NSString *sqlStr = [NSString stringWithFormat:@"select YEAR_F from sportsnote_tw group by YEAR_F"];
	const char *sql = [sqlStr UTF8String];
	sqlite3_stmt *statement = nil;
	
	if (sqlite3_prepare(db, sql, -1, &statement, NULL) == SQLITE_OK) {
		while (sqlite3_step(statement) == SQLITE_ROW ) {
			[yearArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
		}
	}
	sqlite3_finalize(statement);
	return yearArray;
}

- (NSInteger) getPlayerFollowCountWithUserId:(NSString *) userId
{
	NSInteger count;
	NSString *sqlStr = [NSString stringWithFormat:@"select COUNT(userId) from cloud_follow where userId = '%@'", userId];
	const char *sql = [sqlStr UTF8String];
	sqlite3_stmt *statement = nil;
	
	if (sqlite3_prepare(db, sql, -1, &statement, NULL) == SQLITE_OK) {
		while (sqlite3_step(statement) == SQLITE_ROW ) {
			count = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)].intValue;
		}
	}
	sqlite3_finalize(statement);
	return count;
}

#pragma mark - Handle Data Null Event

- (NSString *) checkNullWithIndex:(int)index sqliteStmt:(sqlite3_stmt *)statement
{
	NSString *dataStr = nil;
	if ((char *)sqlite3_column_text(statement, index) != NULL) {
		dataStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, index)];
	}
	return dataStr;
}

#pragma mark - Handle Model 

- (EventModel *) setEventModelWithStatement : (sqlite3_stmt *) statement {
	EventModel *eventModel = [[EventModel alloc] init];
	eventModel.eventCity = [self checkNullWithIndex:0 sqliteStmt:statement];
	eventModel.dateLimit = [self checkNullWithIndex:1 sqliteStmt:statement];
	eventModel.eventId = [self checkNullWithIndex:2 sqliteStmt:statement];
	eventModel.area = [self checkNullWithIndex:3 sqliteStmt:statement];
	eventModel.city = [self checkNullWithIndex:4 sqliteStmt:statement];
	eventModel.event = [self checkNullWithIndex:5 sqliteStmt:statement];
	eventModel.url = [self checkNullWithIndex:6 sqliteStmt:statement];
	eventModel.catelog = [self checkNullWithIndex:7 sqliteStmt:statement];
	eventModel.year = [self checkNullWithIndex:8 sqliteStmt:statement];
	eventModel.eventDate = [self checkNullWithIndex:9 sqliteStmt:statement];
	eventModel.location = [self checkNullWithIndex:10 sqliteStmt:statement];
	eventModel.item = [self checkNullWithIndex:11 sqliteStmt:statement];
	eventModel.enroll = [self checkNullWithIndex:12 sqliteStmt:statement];
	eventModel.desc = [self checkNullWithIndex:13 sqliteStmt:statement];
	eventModel.clickRate = [self checkNullWithIndex:14 sqliteStmt:statement];
	eventModel.hostBy = [self checkNullWithIndex:15 sqliteStmt:statement];
	
	return eventModel;
}

- (AlbumsModel *) setAlbumsModelWithStatement : (sqlite3_stmt *) statement {
	AlbumsModel *albumsModel = [[AlbumsModel alloc] init];
	albumsModel.albumsId = [self checkNullWithIndex:1 sqliteStmt:statement];
	albumsModel.name = [self checkNullWithIndex:2 sqliteStmt:statement];
	albumsModel.photoNumbers = [self checkNullWithIndex:3 sqliteStmt:statement];
	albumsModel.url = [self checkNullWithIndex:4 sqliteStmt:statement];
	
	return albumsModel;
}

- (EventAlbumsModel *) setEventAlbumsModelWithStatement : (sqlite3_stmt *) statement {
	EventAlbumsModel *albumsModel = [[EventAlbumsModel alloc] init];
	albumsModel.eventAlbumsId = [self checkNullWithIndex:0 sqliteStmt:statement];
	albumsModel.eventDate = [self checkNullWithIndex:1 sqliteStmt:statement];
	albumsModel.event = [self checkNullWithIndex:2 sqliteStmt:statement];
	albumsModel.photoNumbers = [self checkNullWithIndex:3 sqliteStmt:statement];
	albumsModel.clickRate = [self checkNullWithIndex:4 sqliteStmt:statement];
	albumsModel.alumbs = nil;
	
	return albumsModel;
}

- (PlayerModel *) setPlayerModelWithStatement : (sqlite3_stmt *) statement {
	
	PlayerModel *playerModel = [[PlayerModel alloc] init];
	playerModel.number = [self checkNullWithIndex:1 sqliteStmt:statement];
	playerModel.name = [self checkNullWithIndex:2 sqliteStmt:statement];
	playerModel.photo = [self checkNullWithIndex:3 sqliteStmt:statement];
	playerModel.sex = [self checkNullWithIndex:4 sqliteStmt:statement];
	playerModel.city = [self checkNullWithIndex:5 sqliteStmt:statement];
	playerModel.followCount = [self checkNullWithIndex:6 sqliteStmt:statement].intValue;
	playerModel.tracker = nil;
	
	return playerModel;
}

- (PlayerMessageModel *) setPlayerMessageModelWithStatement : (sqlite3_stmt *) statement {
	
	PlayerMessageModel *messageModel = [[PlayerMessageModel alloc] init];
	messageModel.autoId = [self checkNullWithIndex:0 sqliteStmt:statement].intValue;
	messageModel.senderName = [self checkNullWithIndex:2 sqliteStmt:statement];
	messageModel.message = [self checkNullWithIndex:3 sqliteStmt:statement];
	messageModel.date = nil;
	return messageModel;
}

- (Location *) setLocationModelWithStatement : (sqlite3_stmt *) statement {
	
	Location *loc = [[Location alloc] init];
	loc.Id = [self checkNullWithIndex:1 sqliteStmt:statement];
	loc.lat = [self checkNullWithIndex:2 sqliteStmt:statement];
	loc.lng = [self checkNullWithIndex:4 sqliteStmt:statement];
	loc.distance = [self checkNullWithIndex:3 sqliteStmt:statement];
	loc.speed = [self checkNullWithIndex:5 sqliteStmt:statement];
	loc.time = [self checkNullWithIndex:6 sqliteStmt:statement];
	
	return loc;
}

- (AroundModel *) setAroundModelWithStatement : (sqlite3_stmt *) statement {
	
	AroundModel *around = [[AroundModel alloc] init];
	around.aroundId = [self checkNullWithIndex:0 sqliteStmt:statement];
	around.name = [self checkNullWithIndex:1 sqliteStmt:statement];
	around.lat = [self checkNullWithIndex:2 sqliteStmt:statement];
	around.lng = [self checkNullWithIndex:3 sqliteStmt:statement];
	
	
	return around;
}

@end