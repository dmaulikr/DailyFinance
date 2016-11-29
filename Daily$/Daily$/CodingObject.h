//
//  SACodingObject.h
//  SybAssistant
//
//  Created by chance on 14-10-11.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 自动实现NSCoding协议，任何继承此类的子类都会自动实现NSCoding协议。支持多层继承
 */
@interface CodingObject : NSObject <NSCoding>

/**
 从指定文件读取类
 
 @param filePath 文件路径，包括文件名称，如.../Document/[fileName]
 */
+ (instancetype)objectFromFile:(NSString *)filePath;

/** 
 保存到指定文件
 
 @param filePath 文件路径，包括文件名称，如.../Document/[fileName]
 */
- (BOOL)saveToFile:(NSString *)filePath;

@end
