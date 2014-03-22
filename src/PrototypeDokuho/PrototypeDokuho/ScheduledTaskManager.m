//
//  ScheduledTaskManager.m
//  PrototypeDokuho
//
//  Created by yanac on 2014/03/10.
//  Copyright (c) 2014年 梁島 啓多. All rights reserved.
//

#import "ScheduledTaskManager.h"

@implementation ScheduledTaskManager

- (void)saveScheduledTask:(NSObject *)ScheduledTask fileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *addDirectoryNameAtPaths = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/ScheduledTasks"];
    
    if ([NSFileManager.defaultManager fileExistsAtPath:addDirectoryNameAtPaths] == NO) {
        [self createDirectory:addDirectoryNameAtPaths];
    }
    
    NSString *path = [addDirectoryNameAtPaths stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    BOOL successful = [NSKeyedArchiver archiveRootObject:ScheduledTask toFile:path];
    
    if (successful) {
        NSLog(@"データの保存に成功しました");
    }
}

- (NSArray *)loadScheduledTasksArray {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSError *error;
    NSArray *scheduledTasks = [NSFileManager.defaultManager contentsOfDirectoryAtPath:[paths[0] stringByAppendingPathComponent:@"/ScheduledTasks"]
                                                     error:&error];
    
    return scheduledTasks;
}

// 指定されたファイル名 fileName のアーカイブをデコード
- (NSObject *)decodeScheduledTask:(NSString *)fileName {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths[0] stringByAppendingString:[NSString stringWithFormat:@"/ScheduledTasks/%@",fileName]];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

// path のディレクトリを作成
- (void)createDirectory:(NSString *)path {
    NSError *error;
    [NSFileManager.defaultManager createDirectoryAtPath:path
                            withIntermediateDirectories:YES
                                             attributes:Nil
                                                  error:&error];
}

// ScheduledTask保存ディレクトリ内のアーカイブを全てデコードし、配列を返す
- (NSMutableArray *)getDecodedScheduledTasks {
    NSArray *scheduledTasks = [self loadScheduledTasksArray];
    NSMutableArray *decodedTasks = [NSMutableArray array];
    
    for (ScheduledTask *task in scheduledTasks) {
        [decodedTasks addObject:[self decodeScheduledTask:[NSString stringWithFormat:@"%@", task]]];
    }
    return decodedTasks;
}

// PicturedScheduledTask の picture の配列を返す。 thumbnailが無かったらnilが入る。
- (NSMutableArray *)getScheduledTasksPicture {
    NSMutableArray *decodedScheduledTasks = [self getDecodedScheduledTasks];
    NSMutableArray *pictures = [NSMutableArray array];
    
    for (PicturedScheduledTask *task in decodedScheduledTasks) {
        if (task.picture) {
            [pictures addObject:task.picture];
        } else {
            [pictures addObject:[UIImage.alloc init]];
        }
    }
    return pictures;
}

// PicturedScheduledTask の thumbnail の配列を返す。 thumbnailが無かったら@""が入る。
- (NSMutableArray *)getScheduledTasksThumbnail {
    NSMutableArray *decodedScheduledTasks = [self getDecodedScheduledTasks];
    NSMutableArray *thumbnails = [NSMutableArray array];
    
    for (PicturedScheduledTask *task in decodedScheduledTasks) {
        if ([task isMemberOfClass:[PicturedScheduledTask class]]) {
            [thumbnails addObject:task.thumbnail];
        } else {
            [thumbnails addObject:@""];
        }
    }
    return thumbnails;
}

@end
