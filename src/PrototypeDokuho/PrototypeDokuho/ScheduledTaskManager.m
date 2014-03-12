//
//  ScheduledTaskManager.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/10.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "ScheduledTaskManager.h"

@implementation ScheduledTaskManager

- (void)saveScheduledTask:(PicturedScheduledTask *)picturedScheduledTask fileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *addDirectoryNameAtPaths = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/ScheduledTasks"];
    
    if ([self checkDirectoryExistance:addDirectoryNameAtPaths] == NO) {
        [self createDirectory:addDirectoryNameAtPaths];
    }
    
    NSString *path = [addDirectoryNameAtPaths stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    BOOL successful = [NSKeyedArchiver archiveRootObject:picturedScheduledTask toFile:path];
    
    if (successful) {
        NSLog(@"データの保存に成功しました");
    }
}

- (NSArray *)loadScheduledTasks {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *scheduledTasks = [fileManager contentsOfDirectoryAtPath:[paths[0] stringByAppendingPathComponent:@"/ScheduledTasks"]
                                                     error:&error];
    
    return scheduledTasks;
}

- (PicturedScheduledTask *)decodePictureScheduledTask:(NSString *)fileName {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/ScheduledTasks/%@",fileName]];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (BOOL)checkDirectoryExistance:(NSString *)path {
    NSError *error;
    return [NSFileManager.defaultManager contentsOfDirectoryAtPath:path
                                                             error:&error];
}

- (void)createDirectory:(NSString *)path {
    NSError *error;
    [NSFileManager.defaultManager createDirectoryAtPath:path
                            withIntermediateDirectories:YES
                                             attributes:Nil
                                                  error:&error];
}

@end
