//
//  DataHelper.h
//  CloudRun
//
//  Created by PAN on 2014/7/25.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

/**************************************************************************
 This Class major handle "Database".....
 The Function "sqlSelectModelCommand" is a handle model event.
 Ex : AlbumsModel, EventModel, EventAlbumsModel.......
 Call This Function must give Select Condition and table name.
 Give Sql Str must add "Select", "Where", "Group By", "Order By" keyword.
***************************************************************************/

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "EventModel.h"
#import "EventAlbumsModel.h"
#import "PlayerModel.h"
#import "PlayerMessageModel.h"
#import "AroundModel.h"


@interface DataHelper : NSObject
{
	sqlite3 *db;
}

- (id) init;
- (id) initWithDBName : (NSString *)dbName;

- (NSInteger) getPlayerFollowCountWithUserId:(NSString *) userId;

- (NSMutableArray *) FetchDate:(NSString *)month  searchYear:(NSString *)year;
- (NSMutableArray *) FetchAllKind;
- (NSMutableArray *) FetchAllYear;


- (NSMutableArray *)sqlSelectModelCommand:(NSString *)selectStr fromTable:(NSString *)table;
- (NSMutableArray *)sqlSelectModelCommand:(NSString *)selectStr fromTable:(NSString *)table where:(NSString *)whereStr;
- (NSMutableArray *)sqlSelectModelCommand:(NSString *)selectStr fromTable:(NSString *)table where:(NSString *)whereStr group:(NSString *)groupStr;
- (NSMutableArray *)sqlSelectModelCommand:(NSString *)selectStr fromTable:(NSString *)table where:(NSString *)whereStr order:(NSString *)orderStr;
- (NSMutableArray *)sqlSelectModelCommand:(NSString *)selectStr fromTable:(NSString *)table where:(NSString *)whereStr group:(NSString *)groupStr order:(NSString *)orderStr;

- (void) sqlInsertCommandWithTalbe:(NSString *)tableStr Values:(NSString *)valuesStr;

@end