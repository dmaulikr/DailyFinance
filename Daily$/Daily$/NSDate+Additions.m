//
//  NSDate+Additions.m
//  Done
//
//  Created by Tranz on 14-2-23.
//  Copyright (c) 2014年 ByChance. All rights reserved.
//

#import "NSDate+Additions.h"

static NSDateFormatter *_dateStringFormatter = nil;
static NSDateFormatter *_shotFormatter = nil;

@implementation NSDate (Additions)


- (NSDate *)midnightUTC {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
  NSDateComponents *components = [calendar components:calendarUnit fromDate:self];
  components.hour = 0;
  components.minute = 0;
  components.second = 0;
  return [calendar dateFromComponents:components];
}


// 自动选择合适的日期格式
- (NSString *)formattedString {
  if (!_shotFormatter) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      _shotFormatter = [[NSDateFormatter alloc] init];
      NSString *formateString = [NSDateFormatter dateFormatFromTemplate:@"MMMdd" options:0 locale:[NSLocale currentLocale]];
      _shotFormatter.dateFormat = formateString;
      
    });
  }
  return [_shotFormatter stringFromDate:self];
}


//// 20140218 -> NSDate
//+ (NSDate *)dateWithString:(NSString *)dateString {
//  if (!dateString) return nil;
//  
//  if (!_dateStringFormatter) {
//    _dateStringFormatter = [NSDateFormatter new];
//    _dateStringFormatter.dateFormat = @"yyyyMMdd";
//  }
//  
//  return [_dateStringFormatter dateFromString:dateString];
//}


// NSDate -> 20140218
- (NSString *)dateString {
  if (!_dateStringFormatter) {
    _dateStringFormatter = [NSDateFormatter new];
    _dateStringFormatter.dateFormat = @"yyyy-MM-dd";
  }
  
  return [_dateStringFormatter stringFromDate:self];
}


- (NSDateComponents *)dateComponents {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth |
                                NSCalendarUnitDay | NSCalendarUnitHour |
                                NSCalendarUnitMinute | NSCalendarUnitSecond;
  return [calendar components:calendarUnit fromDate:self];
}


- (BOOL)isTheSameDayToDate:(NSDate *)date {
    if (!date) {
        return NO;
    }
    
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
  NSDateComponents *dateComponent0 = [calendar components:calendarUnit fromDate:self];
  NSDateComponents *dateComponent1 = [calendar components:calendarUnit fromDate:date];
  if (dateComponent0.year == dateComponent1.year &&
      dateComponent0.month == dateComponent1.month &&
      dateComponent0.day == dateComponent1.day) {
    return YES;
    
  } else {
    return NO;
  }
}


- (NSInteger)daysPassedSinceDate:(NSDate *)date {
  NSDate *fromDate = nil;
  NSDate *toDate = nil;;
  NSCalendar *calendar = [NSCalendar currentCalendar];
  [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
               interval:nil forDate:date];
  [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
               interval:nil forDate:self];
  
  NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:0];
  
  return [difference day];
}


- (NSDate *)dateByPassingDays:(NSInteger)days {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSCalendarUnit calendarUnit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
  NSDateComponents *currentDate = [calendar components:calendarUnit fromDate:self];
  currentDate.day = currentDate.day + days;
  return [calendar dateFromComponents:currentDate];
}



@end














