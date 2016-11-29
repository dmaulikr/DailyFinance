//
//  NSDate+Additions.h
//  Done
//
//  Created by Tranz on 14-2-23.
//  Copyright (c) 2014年 ByChance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)


// 日期: 2014-03-06 00:00:00 +00:00，没有时分秒
- (NSDate *)midnightUTC;


// 自动选择合适的日期格式
- (NSString *)formattedString;


// NSDate -> 20140218
- (NSString *)dateString;


// 返回 NSDateComponents 结构, 精确到秒
- (NSDateComponents *)dateComponents;


// 判断日期是否同一天
- (BOOL)isTheSameDayToDate:(NSDate *)date;


// 判断过了几天
- (NSInteger)daysPassedSinceDate:(NSDate *)date;


// date of N days before, start by 00:00:00
- (NSDate *)dateByPassingDays:(NSInteger)days;




@end











