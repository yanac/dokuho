//
//  ScheduledTaskManager.h
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/10.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PicturedScheduledTask.h"

@interface ScheduledTaskManager : NSObject

- (void)saveScheduledTask:(NSObject *)picturedScheduledTask fileName:(NSString *)fileName;

- (NSObject *)decodeScheduledTask:(NSString *)fileName;

- (NSArray *)loadScheduledTasksArray;

- (NSMutableArray *)getDecodedScheduledTasks;

- (NSMutableArray *)getScheduledTasksPicture;

- (NSMutableArray *)getScheduledTasksThumbnail;

- (NSMutableArray *)getScheduledTasksViewStringItem;

- (void)deleteScheduledTask:(NSString *)fileName;

@end
