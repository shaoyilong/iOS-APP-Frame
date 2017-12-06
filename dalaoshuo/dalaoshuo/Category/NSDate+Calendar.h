//
//  NSDate+Calendar.h
//  FreeDaily
//
//  Created by YongbinZhang on 3/7/13.
//  Copyright (c) 2013 YongbinZhang
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

//当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
- (NSDateComponents * )componentsOfDay;

- (NSInteger)weekdayOrdinal;
//NSDate对应的年份
- (NSUInteger)year;
//NSDate对应的月份
- (NSUInteger)month;
//NSDate对应的日期
- (NSUInteger)day;
//NSDate对应的小时数
- (NSUInteger)hour;
//NSDate对应的分钟数
- (NSUInteger)minute;
//NSDate对应的秒数
- (NSUInteger)second;
//NSDate对应的星期
- (NSUInteger)weekday;
//NSDate对应的周数
- (NSUInteger)week;
//当天的起始时间
- (NSDate*)beginingOfDay;
//当天的结束时间
- (NSDate*)endOfDay;
//当月的第一天
- (NSDate*)firstDayOfTheMonth;
//当月的最后一天
- (NSDate*)lastDayOfTheMonth;
//前一个月的第一天
- (NSDate*)firstDayOfThePreviousMonth;
//后一个月的第一天
- (NSDate*)firstDayOfTheFollowingMonth;
//前一个月的最后一个星期的天数
- (NSUInteger)numberOfDaysInPreviousPartialWeek;
//后一个月的第一个星期的天数
- (NSUInteger)numberOfDaysInFollowingPartialWeek;
//前一个月中与当天对应的日期
- (NSDate*)associateDayOfThePreviousMonth;
//后一个月中与当天对应的日期
- (NSDate*)associateDayOfTheFollowingMonth;
//当月的天数
- (NSUInteger)numberOfDaysInMonth;
//当月的周数
- (NSUInteger)numberOfWeeksInMonth;
//这一周的第一天
- (NSDate*)firstDayOfTheWeek;
//前一周的第一天
- (NSDate*)firstDayOfThePreviousWeekInTheMonth;
//前一个月中，最后一周的第一天
- (NSDate*)firstDayOfTheLastWeekInPreviousMonth;
// 后一周的第一天
- (NSDate*)firstDayOfTheFollowingWeekInTheMonth;

//下一个月中，最前一周的第一天
- (NSDate*)firstDayOfTheFirstWeekInFollowingMonth;
//当月中，这一周的第一天
- (NSDate*)firstDayOfTheWeekInTheMonth;
//当月中，这一周的天数
- (NSUInteger)numberOfDaysInTheWeekInMonth;
//当天是当月的第几周
- (NSUInteger)weekOfDayInMonth;
//当天是当年的第几周
- (NSUInteger)weekOfDayInYear;
//前一个周中与当天对应的日期
- (NSDate*)associateDayOfThePreviousWeek;
//后一周中与当天对应的日期
- (NSDate*)associateDayOfTheFollowingWeek;
//前一天
- (NSDate*)previousDay;
//后一天
- (NSDate*)followingDay;
//YES-同一天；NO-不同一天
- (BOOL)sameDayWithDate:(NSDate*)otherDate;
//YES-同一周；NO-不同一周
- (BOOL)sameWeekWithDate:(NSDate*)otherDate;
//YES-同一月；NO-不同一月
- (BOOL)sameMonthWithDate:(NSDate*)otherDate;

//计算某天是星期几
- (NSString *)featureWeekdayWithDate:(NSDate *)featureDate;
//两个日期相差天数
-(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;

@end
