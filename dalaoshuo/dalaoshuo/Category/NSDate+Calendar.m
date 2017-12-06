//
//  NSDate+Calendar.m
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

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

/**********************************************************
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 ***********************************************************/
- (NSDateComponents *)componentsOfDay
{
    NSDateComponents *dateComponents = nil;
    //static NSDateComponents *dateComponents = nil;
    //static NSDate *previousDate = nil;
    
   // if (!previousDate || ![previousDate isEqualToDate:self]) {
    //    previousDate = self;
        dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfYear| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
   // }
    
    return dateComponents;
}


//  --------------------------NSDate---------------------------
- (NSInteger)weekdayOrdinal
{
    return self.weekdayOrdinal;
}


/****************************************************
 *@Description:获得NSDate对应的年份
 *@Params:nil
 *@Return:NSDate对应的年份
 ****************************************************/
- (NSUInteger)year
{
    return [self componentsOfDay].year;
}

/****************************************************
 *@Description:获得NSDate对应的月份
 *@Params:nil
 *@Return:NSDate对应的月份
 ****************************************************/
- (NSUInteger)month
{
    return [self componentsOfDay].month;
}


/****************************************************
 *@Description:获得NSDate对应的日期
 *@Params:nil
 *@Return:NSDate对应的日期
 ****************************************************/
- (NSUInteger)day
{
    //NSLog(@"[self componentsOfDay].day:%d",[self componentsOfDay].day);
    return [self componentsOfDay].day;
}


/****************************************************
 *@Description:获得NSDate对应的小时数
 *@Params:nil
 *@Return:NSDate对应的小时数
 ****************************************************/
- (NSUInteger)hour
{
    return [self componentsOfDay].hour;
}


/****************************************************
 *@Description:获得NSDate对应的分钟数
 *@Params:nil
 *@Return:NSDate对应的分钟数
 ****************************************************/
- (NSUInteger)minute
{
    return [self componentsOfDay].minute;
}


/****************************************************
 *@Description:获得NSDate对应的秒数
 *@Params:nil
 *@Return:NSDate对应的秒数
 ****************************************************/
- (NSUInteger)second
{
    return [self componentsOfDay].second;
}

/****************************************************
 *@Description:获得NSDate对应的星期
 *@Params:nil
 *@Return:NSDate对应的星期
 ****************************************************/
- (NSUInteger)weekday
{
    return [self componentsOfDay].weekday-1;
}

/****************************************************
 *@Description:获得NSDate对应的周数
 *@Params:nil
 *@Return:NSDate对应的周数
 ****************************************************/
- (NSUInteger)week
{
    return [self componentsOfDay].weekOfYear;
}

/******************************************
 *@Description:获取当天的起始时间（00:00:00）
 *@Params:nil
 *@Return:当天的起始时间
 ******************************************/
- (NSDate *)beginingOfDay
{
    [[self componentsOfDay] setHour:0];
    [[self componentsOfDay] setMinute:0];
    [[self componentsOfDay] setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:[self componentsOfDay]];
}

/******************************************
 *@Description:获取当天的结束时间（23:59:59）
 *@Params:nil
 *@Return:当天的结束时间
 ******************************************/
- (NSDate *)endOfDay
{
    [[self componentsOfDay] setHour:23];
    [[self componentsOfDay] setMinute:59];
    [[self componentsOfDay] setSecond:59];
    
    return [[NSCalendar currentCalendar] dateFromComponents:[self componentsOfDay]];
}

/******************************************
 *@Description:获取当月的第一天
 *@Params:nil
 *@Return:当月的第一天
 ******************************************/
- (NSDate *)firstDayOfTheMonth
{
    [[self componentsOfDay] setDay:1];
    return [[NSCalendar currentCalendar] dateFromComponents:[self componentsOfDay]];
}

/******************************************
 *@Description:获取当月的最后一天
 *@Params:nil
 *@Return:当月的最后一天
 ******************************************/
- (NSDate *)lastDayOfTheMonth
{
    [[self componentsOfDay] setDay:[self numberOfDaysInMonth]];
    return [[NSCalendar currentCalendar] dateFromComponents:[self componentsOfDay]];
}

/******************************************
 *@Description:获取前一个月的第一天
 *@Params:nil
 *@Return:前一个月的第一天
 ******************************************/
- (NSDate *)firstDayOfThePreviousMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
    return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] firstDayOfTheMonth];
}

/******************************************
 *@Description:获取后一个月的第一天
 *@Params:nil
 *@Return:后一个月的第一天
 ******************************************/
- (NSDate *)firstDayOfTheFollowingMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    
    return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] firstDayOfTheMonth];
}


/******************************************
 *@Description:获取前一个月中与当天对应的日期
 *@Params:nil
 *@Return:前一个月中与当天对应的日期
 ******************************************/
- (NSDate *)associateDayOfThePreviousMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:获取后一个月中与当天对应的日期
 *@Params:nil
 *@Return:后一个月中与当天对应的日期
 ******************************************/
- (NSDate *)associateDayOfTheFollowingMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}


/******************************************
 *@Description:获取当月的天数
 *@Params:nil
 *@Return:当月的天数
 ******************************************/
- (NSUInteger)numberOfDaysInMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}


/******************************************
 *@Description:获取当月的周数
 *@Params:nil
 *@Return:当月的周数
 ******************************************/
- (NSUInteger)numberOfWeeksInMonth
{
    NSUInteger weekOfFirstDay = [[self firstDayOfTheMonth] componentsOfDay].weekday;
    NSUInteger numberDaysInMonth = [self numberOfDaysInMonth];
    
    return ((weekOfFirstDay - 1 + numberDaysInMonth) % 7) ? ((weekOfFirstDay - 1 + numberDaysInMonth) / 7 + 1): ((weekOfFirstDay - 1 + numberDaysInMonth) / 7);
}


/******************************************
 *@Description:获取这一周的第一天
 *@Params:nil
 *@Return:这一周的第一天
 ******************************************/
- (NSDate *)firstDayOfTheWeek
{
    NSDate *firstDay = nil;
    if ([[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&firstDay interval:NULL forDate:self]) {
        return firstDay;
    }
    
    return firstDay;
}

/******************************************
 *@Description:获取当月中，前一周的第一天
 *@Params:nil
 *@Return:前一周的第一天
 ******************************************/
- (NSDate *)firstDayOfThePreviousWeekInTheMonth
{
    NSDate *firstDayOfTheWeekInTheMonth = [self firstDayOfTheWeekInTheMonth];
    if ([firstDayOfTheWeekInTheMonth componentsOfDay].weekday > 1) {
        return nil;
    } else {
        if ([firstDayOfTheWeekInTheMonth componentsOfDay].day > 7) {
            NSDateComponents *components = [[NSDateComponents alloc] init];
            components.day = -7;
            return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
        } else if ([firstDayOfTheWeekInTheMonth componentsOfDay].day > 1) {
            return [self firstDayOfTheMonth];
        } else {
            return nil;
        }
    }
}

/******************************************
 *@Description:获取前一个月中，最后一周的第一天
 *@Params:nil
 *@Return:前一个月中，最后一周的第一天
 ******************************************/
- (NSDate *)firstDayOfTheLastWeekInPreviousMonth
{
    NSDate *firstDayOfThePreviousMonth = [self firstDayOfThePreviousMonth];
    NSUInteger numberOfDaysInPreviousMonth = [firstDayOfThePreviousMonth numberOfDaysInMonth];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = [firstDayOfThePreviousMonth componentsOfDay].year;
    components.month = [firstDayOfThePreviousMonth componentsOfDay].month;
    components.day = numberOfDaysInPreviousMonth;
    NSDate *lastDayOfThePreviousMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return [lastDayOfThePreviousMonth firstDayOfTheWeekInTheMonth];
}


/******************************************
 *@Description:获取当月中，后一周的第一天
 *@Params:nil
 *@Return:后一周的第一天
 ******************************************/
- (NSDate *)firstDayOfTheFollowingWeekInTheMonth
{
    NSDate *firstDayOfTheWeekInTheMonth = [self firstDayOfTheWeekInTheMonth];
    NSUInteger numberOfDaysInMonth = [self numberOfDaysInMonth];
    if (([firstDayOfTheWeekInTheMonth componentsOfDay].day + 6) >= numberOfDaysInMonth) {
        return nil;
    } else {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = 6;
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    }
}

/******************************************
 *@Description:获取下一个月中，最前一周的第一天
 *@Params:nil
 *@Return:下一个月中，最前一周的第一天
 ******************************************/
- (NSDate *)firstDayOfTheFirstWeekInFollowingMonth
{
    NSDate *firstDayOfTheFollowingMonth = [self firstDayOfTheFollowingMonth];
    
    return [firstDayOfTheFollowingMonth firstDayOfTheWeekInTheMonth];
}


/******************************************
 *@Description:获取当月中，这一周的第一天
 *@Params:nil
 *@Return:当月中，这一周的第一天
 ******************************************/
- (NSDate *)firstDayOfTheWeekInTheMonth
{
    NSDate *firstDayOfTheWeek = nil;
    if ([[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&firstDayOfTheWeek interval:NULL forDate:self]) {
        NSDate *firstDayOfTheMonth = [self firstDayOfTheMonth];
        if ([firstDayOfTheWeek componentsOfDay].month == [firstDayOfTheMonth componentsOfDay].month) {
            return firstDayOfTheWeek;
        } else {
            return firstDayOfTheMonth;
        }
    }
    
    return firstDayOfTheWeek;
}


/******************************************
 *@Description:获取当月中，这一周的天数
 *@Params:nil
 *@Return:当月中，这一周的天数
 ******************************************/
- (NSUInteger)numberOfDaysInTheWeekInMonth
{
    NSDate *firstDayOfTheWeek = [self firstDayOfTheWeek];
    NSDate *firstDayOfTheWeekInTheMonth = [self firstDayOfTheWeekInTheMonth];
    
    if ([firstDayOfTheWeek componentsOfDay].month == [firstDayOfTheWeekInTheMonth componentsOfDay].month) {
        return (firstDayOfTheWeek.numberOfDaysInMonth - [firstDayOfTheWeek componentsOfDay].day + 1) >= 7 ? 7 : (firstDayOfTheWeek.numberOfDaysInMonth - [firstDayOfTheWeek componentsOfDay].day + 1);
    } else {
        return (8 - [firstDayOfTheWeekInTheMonth componentsOfDay].weekday);
    }
}
//  本月日历中，上一个月最后一周的天数
- (NSUInteger)numberOfDaysInPreviousPartialWeek
{
    NSDate* firstDateInSelectedMonth = [self firstDayOfTheMonth];
    NSLog(@"week:%zd    day:%@",firstDateInSelectedMonth.weekday,firstDateInSelectedMonth);
    return (firstDateInSelectedMonth.weekday - 1);
}
//  本月日历中，下一个月第一周的天数
- (NSUInteger)numberOfDaysInFollowingPartialWeek
{
    return (7 - [self lastDayOfTheMonth].weekday);
}

/******************************************
 *@Description:获取当天是当月的第几周
 *@Params:nil
 *@Return:当天是当月的第几周
 ******************************************/
- (NSUInteger)weekOfDayInMonth
{
    NSDate *firstDayOfTheMonth = [self firstDayOfTheMonth];
    NSUInteger weekdayOfFirstDayOfTheMonth = [firstDayOfTheMonth componentsOfDay].weekday;
    NSUInteger day = [self componentsOfDay].day;
    
    return ((day + weekdayOfFirstDayOfTheMonth - 1)%7) ? ((day + weekdayOfFirstDayOfTheMonth - 1)/7) + 1: ((day + weekdayOfFirstDayOfTheMonth - 1)/7);
}

/******************************************
 *@Description:获取当天是当年的第几周
 *@Params:nil
 *@Return:当天是当年的第几周
 ******************************************/
- (NSUInteger)weekOfDayInYear
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}

/******************************************
 *@Description:获取前一周中与当天对应的日期
 *@Params:nil
 *@Return:前一个周中与当天对应的日期
 ******************************************/
- (NSDate *)associateDayOfThePreviousWeek
{
    NSUInteger day = [self componentsOfDay].day;
    NSUInteger weekday = [self componentsOfDay].weekday;
    
    if (day > 7) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = -7;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else if (day > weekday) {
        
        return [self firstDayOfTheMonth];
    } else {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = -1;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[self firstDayOfTheWeekInTheMonth] options:0];
    }
}

/******************************************
 *@Description:获取后一周中与当天对应的日期
 *@Params:nil
 *@Return:后一周中与当天对应的日期
 ******************************************/
- (NSDate *)associateDayOfTheFollowingWeek
{
    NSUInteger numberOfDaysInMonth = [self numberOfDaysInMonth];
    NSUInteger day = [self componentsOfDay].day;
    NSUInteger weekday = [self componentsOfDay].weekday;
    if (day + 7 <= numberOfDaysInMonth) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = 7;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else if ((day + (7 - weekday + 1)) <= numberOfDaysInMonth) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = numberOfDaysInMonth - day;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else {
        return [self firstDayOfTheFollowingMonth];
    }
}


/******************************************
 *@Description:前一天
 *@Params:nil
 *@Return:前一天
 ******************************************/
- (NSDate *)previousDay
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}



/******************************************
 *@Description:后一天
 *@Params:nil
 *@Return:后一天
 ******************************************/
- (NSDate *)followingDay
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}


/******************************************
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 ******************************************/
- (BOOL)sameDayWithDate:(NSDate *)otherDate
{
    if (self.year == otherDate.year && self.month == otherDate.month && self.day == otherDate.day) {
        return YES;
    } else {
        return NO;
    }
}


/******************************************
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 ******************************************/
- (BOOL)sameWeekWithDate:(NSDate *)otherDate
{
    if (self.year == otherDate.year  && self.month == otherDate.month && self.weekOfDayInYear == otherDate.weekOfDayInYear) {
        return YES;
    } else {
        return NO;
    }
}

/******************************************
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 ******************************************/
- (BOOL)sameMonthWithDate:(NSDate *)otherDate
{
    if (self.year == otherDate.year && self.month == otherDate.month) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)featureWeekdayWithDate:(NSDate *)featureDate{
    // 创建 格式 对象
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    // 设置 日期 格式 可以根据自己的需求 随时调整， 否则计算的结果可能为 nil
//    formatter.dateFormat = @"yyyy-MM-dd";
//    // 将字符串日期 转换为 NSDate 类型
//    NSDate *endDate = [formatter dateFromString:featureDate];
    // 判断当前日期 和 未来某个时刻日期 相差的天数
    long days = [self daysFromDate:[NSDate date] toDate:featureDate];
    // 将总天数 换算为 以 周 计算（假如 相差10天，其实就是等于 相差 1周零3天，只需要取3天，更加方便计算）
    long day = days >= 7 ? days % 7 : days;
    long week = [self getNowWeekday] + day;
    switch (week) {
        case 1:
            return @"7";//星期日
            break;
        case 2:
            return @"1";//星期一
            break;
        case 3:
            return @"2";//星期二
            break;
        case 4:
            return @"3";//星期三
            break;
        case 5:
            return @"4";//星期四
            break;
        case 6:
            return @"5";//星期五
            break;
        case 7:
            return @"6";//星期六
            break;
            
        default:
            break;
    }
    return nil;
}

//两个日期相差天数
-(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //得到相差秒数
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/3600/60;
    if (days <= 0 && hours <= 0&&minute<= 0) {
        NSLog(@"0天0小时0分钟");
        return 0;
    }
    else {
        NSLog(@"%@",[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute]);
        // 之所以要 + 1，是因为 此处的days 计算的结果 不包含当天 和 最后一天\
        （如星期一 和 星期四，计算机 算的结果就是2天（星期二和星期三），日常算，星期一——星期四相差3天，所以需要+1）\
        对于时分 没有进行计算 可以忽略不计
        return days + 1;
    }
}

// 获取当前是星期几
- (NSInteger)getNowWeekday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}

@end
