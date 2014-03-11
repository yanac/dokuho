//
//  ScheduledTaskManager.h
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/10.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PicturedScheduledTask.h"

@interface ScheduledTaskManager : NSUserDefaults

- (void)saveScheduledTask:(PicturedScheduledTask *)picturedScheduledTask fileName:(NSString *)fileName;

- (NSArray *)loadScheduledTasks;

- (PicturedScheduledTask *)decodePictureScheduledTask:(NSString *)fileName;


@end
