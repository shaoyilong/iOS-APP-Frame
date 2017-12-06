//
//  DataBaseUtil.m
//  WipaceApp
//
//  Created by 邵义珑 on 16/5/25.
//  Copyright © 2016年 邵义珑. All rights reserved.
//

#import "DataBaseUtil.h"
#import <objc/runtime.h>
#import <objc/objc.h>
//类中有objId，取的是主健。xx_则不加字段
@implementation DataBaseUtil
@synthesize mDb;

- (void)dealloc
{
    [mDb release];
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        //创建数据库
        NSString *documentDirectory = [CommonUtil getDocumentsDirectory];
        //dbPath： 数据库路径，在Document中。
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"wipace.db"];
        //创建数据库实例 db
        self.mDb = [FMDatabase databaseWithPath:dbPath] ;
    }
    return self;
}

+ (DataBaseUtil *)instance
{
    static DataBaseUtil *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        });
    if (sharedInstance.mDb != nil)
    {
        if (![sharedInstance.mDb open])
        {
            MYLog(@"not open database");
        }
    }

    return sharedInstance;
    
}

- (BOOL)createTableWithClassArray:(NSMutableArray *)tempClassArray
{
    @synchronized (self)
    {
        NSMutableArray *sqlArray = [NSMutableArray arrayWithCapacity:[tempClassArray count]];
        NSMutableArray *arrayObject = [NSMutableArray arrayWithCapacity:5];
        for (Class tempClass in tempClassArray)
        {
            id obj = class_createInstance(tempClass, 0);
            NSString *tableName = [self getTableName:tempClass];
            //    id obj = objc_getClass([tableName UTF8String]);
            NSMutableDictionary *dic = [self getDicFromModelClass:obj];
            
            NSArray *keys = [dic allKeys];
            NSString *keyName = @"";
            int num = 0;
            for (NSString *key in keys)
            {
                num ++;
                if (num == [keys count])
                {
                    if ([key isEqualToString:@"startlongtime"])
                    {
                        keyName = [keyName stringByAppendingFormat:@"%@ datetime",key];
                    }
                    else
                    {
                        keyName = [keyName stringByAppendingFormat:@"%@ varchar",key];
                    }
                }
                else
                {
                    if ([key isEqualToString:@"startlongtime"])
                    {
                        keyName = [keyName stringByAppendingFormat:@"%@ datetime, ",key];

                    }
                    else
                    {
                        keyName = [keyName stringByAppendingFormat:@"%@ varchar, ",key];

                    }
                }
                
                
            }
            
            NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ ( _id integer primary key autoincrement, %@)", tableName,keyName];
            [sqlArray addObject:sql];
            [arrayObject addObject:tempClass];
        }
        
        BOOL isok = YES;
        for (int i = 0; i< [sqlArray count]; i++)
        {
            NSString *tempSql = [sqlArray objectAtIndex:i];
            isok = [mDb executeUpdate:tempSql];
            if (!isok)
            {
                MYLog(@"error");
                continue;
            }
            else
            {
                [self addColumn:[arrayObject objectAtIndex:i]];
            }
            
        }
        
        return YES;
    }
    
}
- (BOOL)createTableWithClass:(Class)tempClass
{
    @synchronized (self)
    {
        id obj = class_createInstance(tempClass, 0);
        NSString *tableName = [self getTableName:tempClass];
        //    id obj = objc_getClass([tableName UTF8String]);
        NSMutableDictionary *dic = [self getDicFromModelClass:obj];
        
        NSArray *keys = [dic allKeys];
        NSString *keyName = @"";
        int num = 0;
        for (NSString *key in keys)
        {
            num ++;
            if (num == [keys count])
            {
                keyName = [keyName stringByAppendingFormat:@"%@ varchar",key];
            
            }
            else
            {
                keyName = [keyName stringByAppendingFormat:@"%@ varchar, ",key];
            }
            
            
        }
        
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ ( _id integer primary key autoincrement, %@)", tableName,keyName];
        MYLog(@"%@",sql);
        //    return [db executeUpdate:sql];
        
        
        BOOL isok = [mDb executeUpdate:sql];
        //增加列
        //         NSString *add = [NSString stringWithFormat:@"alter table %@ add aaaaa varchar",tableName];
        //        [mDb executeUpdate:add];
        
        if (!isok)
        {
            MYLog(@"error");
            return NO;
        }
        else
        {
            MYLog(@"ok");
            //            select columns from table_name where expression
            //            MYLog(@"======%d",[s columnCount]);
            [self addColumn:tempClass];
        }
        //[mDb close];
        
        return YES;
    }
    
}
//数据库已经打开
- (void)addColumn:(Class)tempClass
{
    @synchronized (self)
    {
        id obj = class_createInstance(tempClass, 0);
        NSString *tableName = [self getTableName:tempClass];
        FMResultSet *s = [mDb executeQuery:[NSString stringWithFormat:@"select * from %@ limit 1",tableName]];
        if (s!= nil)
        {
            NSMutableDictionary *dic = [self getDicFromModelClass:obj];
            NSArray *keys = [dic allKeys];
            if (keys != nil)
            {
                for (NSString *keyName in keys)
                {
                    
                    if ([s columnIndexForName:keyName] == -1)
                    {
                        NSString *add = [NSString stringWithFormat:@"alter table %@ add column %@ varchar",tableName,keyName];
                        MYLog(@"++%@",add);
                        [mDb executeUpdate:add];
                    }
                }
            }
            
        }
    }
    
}

- (BOOL)addClassWithObj:(id)obj
{
    @synchronized (self)
    {
        NSString *tableName = [self getTableName:obj];
        NSMutableDictionary *dic = [self getDicFromModelClass:obj];
        
        NSArray *keys = [dic allKeys];
        //    NSString *value = nil;
        NSString *keyName = @"";
        NSString *keyValue = @"";
        int num = 0;
        
        for (NSString *key in keys)
        {
            //        value = [dic objectForKey:key];
            num ++;
            if (num == [keys count])
            {
                keyName = [keyName stringByAppendingFormat:@"%@) ",key];
                //            keyValue = [keyValue stringByAppendingFormat:@"'%@'); ",value];
                keyValue = [keyValue stringByAppendingFormat:@"?)"];
            }
            else
            {
                keyName = [keyName stringByAppendingFormat:@"%@, ",key];
                //            keyValue = [keyValue stringByAppendingFormat:@"'%@', ",value];
                keyValue = [keyValue stringByAppendingFormat:@"?,"];
            }
            
        }
        //UPDATE SUser SET name = 'Aa', description = 'mmm' WHERE uid = '2'
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@ VALUES (%@",tableName,keyName,keyValue];
        
        MYLog(@"%@", sql);
        
        BOOL isok = [mDb executeUpdate:sql withArgumentsInArray:[dic allValues]];
        //        [mDb executeUpdate:￼ withParameterDictionary:￼]
        //[mDb close];
        if (!isok)
        {
            MYLog(@"error");
            return NO;
        }
        else
        {
            MYLog(@"ok=====");
        }
        
        return YES;
    }
    
}
- (BOOL)addManyClassWithObj:(NSArray *)array
{
    @synchronized (self)
    {
        NSString *tableName = nil;
        NSMutableDictionary *dic = nil;
        NSArray *keys = nil;
        @try
        {
            [mDb beginTransaction];
            for (id obj in array)
            {
                tableName = [self getTableName:obj];
                dic = [self getDicFromModelClass:obj];
                keys = [dic allKeys];
                //    NSString *value = nil;
                NSString *keyName = @"";
                NSString *keyValue = @"";
                int num = 0;
                
                for (NSString *key in keys)
                {
                    //        value = [dic objectForKey:key];
                    num ++;
                    if (num == [keys count])
                    {
                        keyName = [keyName stringByAppendingFormat:@"%@) ",key];
                        //            keyValue = [keyValue stringByAppendingFormat:@"'%@'); ",value];
                        keyValue = [keyValue stringByAppendingFormat:@"?)"];
                    }
                    else
                    {
                        keyName = [keyName stringByAppendingFormat:@"%@, ",key];
                        //            keyValue = [keyValue stringByAppendingFormat:@"'%@', ",value];
                        keyValue = [keyValue stringByAppendingFormat:@"?,"];
                    }
                    
                }
                //UPDATE SUser SET name = 'Aa', description = 'mmm' WHERE uid = '2'
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@ VALUES (%@",tableName,keyName,keyValue];
                
                MYLog(@"%@", sql);
                [mDb executeUpdate:sql withArgumentsInArray:[dic allValues]];
            }

        }
        @catch (NSException *exception) {
            [mDb rollback];
             MYLog(@"error");
            return NO;
        }
        @finally {
            [mDb commit];
            
        }
                //[mDb close];
        return YES;
    }
    
}

//更新某一表的一个对象的某些个字段
- (BOOL)updateTableWithDictionary:(NSMutableDictionary *)dic searchKey:(NSString *)searchKey searchValue:(NSString *)searchValue tableClass:(Class) tempClass
{
    @synchronized (self)
    {
        if (searchValue == nil)
        {
            return NO;
        }
        NSArray *keys = [dic allKeys];
        
        NSString *value = nil;
        NSString *update = @"";
        int num = 0;
        
        for (NSString *key in keys)
        {
            num++;
            value = [dic objectForKey:key];
            if (num == 1)
            {
                update = [update stringByAppendingFormat:@"%@ = '%@'",key,value];
                //update = [NSString stringWithFormat:@"%@ %@ = '%@'",update,keys,value];
            }
            else
            {
                update = [update stringByAppendingFormat:@", %@ = '%@'",key,value];
                //update = [NSString stringWithFormat:@"%@, %@ = '%@'",update,keys,value];
            }
            
        }
        NSString *tableName = [self getTableName:tempClass];
        //UPDATE SUser SET name = 'Aa', description = 'mmm' WHERE uid = '2'
        update = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ = '%@'",tableName,update,searchKey,searchValue];
        
        MYLog(@"%@",update);
        BOOL isok = [mDb executeUpdate:update];
        if (!isok)
        {
            MYLog(@"error");
        }
        //[mDb close];
        return isok;
    }
    
    
}
//NSString *sql = [NSString stringWithFormat:@"UPDATE %@ WHERE %@",tableName,limit];
- (BOOL)updateObjsByClass:(Class)tempClass limit:(NSString *)limit dictionary:(NSMutableDictionary *)dic
{
    @synchronized (self)
    {
        NSArray *keys = [dic allKeys];
        
        NSString *value = nil;
        NSString *update = @"";
        int num = 0;
        
        for (NSString *key in keys)
        {
            num++;
            value = [dic objectForKey:key];
            if (num == 1)
            {
                update = [update stringByAppendingFormat:@"%@ = '%@'",key,value];
            }
            else
            {
                update = [update stringByAppendingFormat:@", %@ = '%@'",key,value];
            }
            
        }
        NSString *tableName = [self getTableName:tempClass];
        update = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",tableName,update,limit];
        
        MYLog(@"%@",update);
        BOOL isok = [mDb executeUpdate:update];
        if (!isok)
        {
            MYLog(@"error");
        }
        //[mDb close];
        return isok;
    }
    
}

- (BOOL)updateClassWithObj:(id)obj searchKey:(NSString *)searchKey searchValue:(NSString *)searchValue
{
    @synchronized (self)
    {
        if (searchKey == nil)
        {
            return NO;
        }
        //如果数据库中有才更新，没有则插入
        if (searchValue != nil && [self findObjBySearchKey:searchKey searchValue:searchValue class:[obj class]]!= nil)
        {
            //表的名字和对象的名字一样
            NSString *tableName = [self getTableName:obj];
            NSMutableDictionary *dic = [self getDicFromModelClass:obj];
            NSArray *keys = [dic allKeys];
            NSString *value = nil;
            NSString *update = @"";
            //        int num = 0;
            for (NSString *key in keys)
            {
                
                value = [dic objectForKey:key];
                if (![CommonUtil isValueableString:value] && ![@"" isEqualToString:value])
                {
                    continue;
                }
                //            num++;
                if ([update isEqualToString:@""])
                {
                    update = [update stringByAppendingFormat:@"%@ = '%@'",key,value];
                    //update = [NSString stringWithFormat:@"%@ %@ = '%@'",update,keys,value];
                }
                else
                {
                    update = [update stringByAppendingFormat:@", %@ = '%@'",key,value];
                    //update = [NSString stringWithFormat:@"%@, %@ = '%@'",update,keys,value];
                }
                
            }
            //UPDATE SUser SET name = 'Aa', description = 'mmm' WHERE uid = '2'
            update = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ = '%@' and userphone = %@",tableName,update,searchKey,searchValue, [SingleData sharedInstance]];
            
            MYLog(@"%@",update);
            
            BOOL isok = [mDb executeUpdate:update];
            if (!isok)
            {
                MYLog(@"error");
            }
            else
            {
                MYLog(@"ok=========");
            }
            //[mDb close];
            return isok;
            
        }
        else
        {
            return [self addClassWithObj:obj];
        }
    }
}

- (BOOL)resetClassWithObj:(id)obj searchKey:(NSString *)searchKey searchValue:(NSString *)searchValue
{
    @synchronized (self)
    {
        if (searchKey == nil)
        {
            return NO;
        }
        //如果数据库中有才更新，没有则插入
        if (searchValue != nil && [self findObjBySearchKey:searchKey searchValue:searchValue class:[obj class]]!= nil)
        {
            //表的名字和对象的名字一样
            NSString *tableName = [self getTableName:obj];
            NSMutableDictionary *dic = [self getDicFromModelClass:obj];
            NSArray *keys = [dic allKeys];
            NSString *value = nil;
            NSString *update = @"";
            for (NSString *key in keys)
            {
                
                value = [dic objectForKey:key];
                //            if (![NomalUtil isValueableString:value] && ![@"" isEqualToString:value])
                //            {
                //                continue;
                //            }
                if ([update isEqualToString:@""])
                {
                    update = [update stringByAppendingFormat:@"%@ = '%@'",key,value];
                    //update = [NSString stringWithFormat:@"%@ %@ = '%@'",update,keys,value];
                }
                else
                {
                    update = [update stringByAppendingFormat:@", %@ = '%@'",key,value];
                    //update = [NSString stringWithFormat:@"%@, %@ = '%@'",update,keys,value];
                }
                
            }
            //UPDATE SUser SET name = 'Aa', description = 'mmm' WHERE uid = '2'
            update = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ = '%@'",tableName,update,searchKey,searchValue];
            
            MYLog(@"%@",update);
            BOOL isok = [mDb executeUpdate:update];
            if (!isok)
            {
                MYLog(@"error");
            }
            else
            {
                MYLog(@"ok=========");
            }
            //[mDb close];
            return isok;
            
        }
        else
        {
            return [self addClassWithObj:obj];
        }
    }
    
}


//一般取第一个
- (id)findObjBySearchKey:(NSString *)searchKey searchValue:(NSString *)searchValue class:(Class)tempClass
{
    @synchronized (self)
    {
        //    [Register class]
        //    id tempClass = objc_getClass([objName UTF8String]);
        id obj = class_createInstance(tempClass, 0);
        NSString *tableName = [self getTableName:obj];
        NSMutableDictionary *dic = [self getDicFromModelClass:obj];
        NSArray *keys = [dic allKeys];

        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = %@ and userphone = %@",tableName,searchKey,searchValue,[SingleData sharedInstance]];
        MYLog(@"%@", sql);
        
        FMResultSet *s = [mDb executeQuery:sql];
        if ([s next])
        {
            for (NSString *propertyName in keys)
            {
                if ([propertyName isEqualToString:@"objId"])
                {
                    int keyId = [s intForColumn:@"_id"];
                    [obj setValue:[NSString stringWithFormat:@"%d",keyId] forKey:propertyName];
                }
                else if ([propertyName isEqualToString:@"startlongtime"])
                {
                    NSDate *date=[s dateForColumn:@"startlongtime"];
                    [obj setValue:date forKey:propertyName];
                }
                else
                {
                    [obj setValue:[s stringForColumn:propertyName] forKey:propertyName];
                }
                //                object_setInstanceVariable(obj, propertyName, [s stringForColumn:propertyName]);
            }
//            return obj;
            //retrieve values for each record
        }
        else
        {
            obj = nil;
        }
        //[mDb close];
        return obj;
//        return nil;
    }
    
}

// 获得表的数据条数
- (int)countItemByClass:(Class)tempClass limit:(NSString *)limit
{
    @synchronized (self)
    {
        id obj = class_createInstance(tempClass, 0);
        NSString *tableName = [self getTableName:obj];
        NSString *sql = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM %@ where %@", tableName,limit];
        if (limit == nil)
        {
            sql = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM %@", tableName];
        }
        MYLog(@"%@", sql);
        
        FMResultSet *s = [mDb executeQuery:sql];
        while ([s next])
        {
            NSInteger count = [s intForColumn:@"count"];
            return (int)count;
            //retrieve values for each record
        }
        //        //[mDb close];
        
        return 0;
    }
    
}


- (NSMutableArray *)findManyObjsByClass:(Class)tempClass limit:(NSString *)limit
{
    @synchronized (self)
    {
        //    [Register class]
        //    id tempClass = objc_getClass([objName UTF8String]);
        id obj = class_createInstance(tempClass, 0);
        NSString *tableName = [self getTableName:obj];
        NSMutableDictionary *dic = [self getDicFromModelClass:obj];
        NSArray *keys = [dic allKeys];
        NSString *sql = nil;
        if (limit == nil)
        {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        }
        else
        {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@",tableName,limit];
        }
        NSMutableArray *lists =[[[NSMutableArray alloc] init] autorelease];
        MYLog(@"%@", sql);
        FMResultSet *s = [mDb executeQuery:sql];
        while ([s next])
        {
            obj = class_createInstance(tempClass, 0);
            for (NSString *propertyName in keys)
            {
                if ([propertyName isEqualToString:@"objId"])
                {
                    int keyId = [s intForColumn:@"_id"];
                    [obj setValue:[NSString stringWithFormat:@"%d",keyId] forKey:propertyName];
                }
                else if ([propertyName isEqualToString:@"startlongtime"])
                {
                    NSDate *date=[s dateForColumn:@"startlongtime"];
                    [obj setValue:date forKey:propertyName];
                }
                else
                {
                    [obj setValue:[s stringForColumn:propertyName] forKey:propertyName];
                }
                //                object_setInstanceVariable(obj, propertyName, [s stringForColumn:propertyName]);
                
            }
            [lists addObject:obj];
            //retrieve values for each record
        }
        //[mDb close];
        
        return lists;
    }
    
}

- (NSMutableArray *)findAllObjsByClass:(Class)tempClass
{
    @synchronized (self)
    {
        id obj = class_createInstance(tempClass, 0);
        NSString *tableName = [self getTableName:obj];
        NSMutableDictionary *dic = [self getDicFromModelClass:obj];
        //    free(obj);
        NSArray *keys = [dic allKeys];
        
        NSMutableArray *lists =[[[NSMutableArray alloc] init] autorelease];
        
        FMResultSet *s = [mDb executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableName]];
        while ([s next])
        {
            obj = class_createInstance(tempClass, 0);
            for (NSString *propertyName in keys)
            {
                
                if ([propertyName isEqualToString:@"objId"])
                {
                    int keyId = [s intForColumn:@"_id"];
                    [obj setValue:[NSString stringWithFormat:@"%d",keyId] forKey:propertyName];
                }
                else if ([propertyName isEqualToString:@"startlongtime"])
                {
                    NSDate *date = [s dateForColumn:@"startlongtime"];
                    [obj setValue:date forKey:propertyName];
                }
                else
                {
                    [obj setValue:[s stringForColumn:propertyName] forKey:propertyName];
                }
                //                object_setInstanceVariable(obj, propertyName, [s stringForColumn:propertyName]);
            }
            [lists addObject:obj];
            //            free(obj);
            //retrieve values for each record
        }
        //[mDb close];
        
        return lists;
    }
    
}
- (BOOL)deleteObjWithClass:(Class)tempClass searchKey:(NSString *)searchKey searchValue:(NSString *)searchValue
{
    @synchronized (self)
    {
        BOOL isOk = YES;
        NSString *tableName = [self getTableNameFrom:tempClass];
        NSString * query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'",tableName,searchKey,searchValue];
        
        isOk = [mDb executeUpdate:query];
        
        if (isOk)
        {
            MYLog(@"ok");
        }
        else
        {
            MYLog(@"error");
        }
        //[mDb close];
        return isOk;
        
    }
}

- (BOOL)deleteObjWithClass:(Class)tempClass
{
    return [self deleteObjWithClass:tempClass limit:nil];
}

- (BOOL)deleteObjWithClass:(Class)tempClass limit:(NSString *)limit
{
    @synchronized (self)
    {
        BOOL isOk = YES;
        NSString *tableName = [self getTableNameFrom:tempClass];
        NSString * query = nil;
        //DELETE FROM XX where type != '1' and type != '2'
        //DELETE FROM XX where type == '1' or type == '2'
        if (limit != nil)
        {
            query = [NSString stringWithFormat:@"DELETE FROM %@ where %@ and userphone = %@",tableName,limit,[SingleData sharedInstance]];
        }
        else
        {
            query = [NSString stringWithFormat:@"DELETE FROM %@",tableName];

        }
        isOk = [mDb executeUpdate:query];
        
        
        if (isOk)
        {
            query = [NSString stringWithFormat:@"UPDATE sqlite_sequence SET seq = 0 WHERE name='%@'",tableName];
        }
        
        
        isOk = [mDb executeUpdate:query];
        
        MYLog(@"%@",query);
        if (isOk)
        {
            MYLog(@"ok");
        }
        else
        {
            MYLog(@"error");
        }
        //[mDb close];
        return isOk;
    }
    
}

- (void)closeDataBase
{
    @synchronized (self)
    {
        if (mDb != nil)
        {
            [mDb close];
        }
    }
    
}

- (void)openDataBase
{
    @synchronized (self)
    {
        if (mDb != nil)
        {
            [mDb open];
        }
    }
    
}

- (NSString *)getTableName:(id)obj
{
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(obj)];
    tableName = [NSString stringWithFormat:@"s_%@",tableName];
    return tableName;
}
- (NSString *)getTableNameFrom:(Class)tempClass
{
    NSString *tableName = [tempClass description];
    tableName = [NSString stringWithFormat:@"s_%@",tableName];
    return tableName;
}

- (NSMutableDictionary *)getDicFromModelClass:(id)classInstance
{
    //     id LenderClass =objc_getClass("ClassName");
    //这里是遍历当前类的所有成员变量
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:1];
    
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:1];
    
    Class clazz = [classInstance class];
    //进入父类遍历成员变量，终止时判断
    while(clazz != [NSObject class])
    {
        u_int count;
        
        objc_property_t* properties = class_copyPropertyList(clazz, &count);
        
        for (int i = 0; i < count ; i++)
            
        {
            objc_property_t prop=properties[i];
            
            const char* propertyName = property_getName(prop);
            
            //            const char* attributeName = property_getAttributes(prop);
            
            //        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
            //可以找到变量数据类型
            //            NSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
            //T@"NSString",&,N,Vflag
            //Tf,N,V_height_
            id value =  [classInstance performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
            //过滤不存储数据库的字段
            if (![[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding] hasSuffix:@"_"])
            {
                if(value == nil || (NSNull *)value == [NSNull null])
                {
                    [valueArray addObject:[NSNull null]];
                }
                else
                {
                    [valueArray addObject:value];
                    
                }
                [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
            }
            
            //        NSLog(@"%@",value);
        }
        
        free(properties);
        clazz = class_getSuperclass(clazz);
    }
    
    NSMutableDictionary* returnDic = [NSMutableDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    
    //    MYLog(@"%@", returnDic);
    
    return returnDic;
}




@end
