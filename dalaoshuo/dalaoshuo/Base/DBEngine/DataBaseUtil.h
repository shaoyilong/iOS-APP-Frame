//
//  DataBaseUtil.h
//  WipaceApp
//
//  Created by 邵义珑 on 16/5/25.
//  Copyright © 2016年 邵义珑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface DataBaseUtil : NSObject
{
    FMDatabase *mDb;
}
@property (nonatomic,retain) FMDatabase *mDb;
+ (DataBaseUtil *)instance;

- (BOOL)createTableWithClass:(Class)tempClass;
- (BOOL)createTableWithClassArray:(NSMutableArray *)tempClassArray;

- (id)findObjBySearchKey:(NSString *)searchKey searchValue:(NSString *)searchValue class:(Class)tempClass;
- (NSMutableArray *)findAllObjsByClass:(Class)tempClass;
- (NSMutableArray *)findManyObjsByClass:(Class)tempClass limit:(NSString *)limit;


- (BOOL)addClassWithObj:(id)obj;
- (BOOL)addManyClassWithObj:(NSArray *)array;


- (BOOL)updateObjsByClass:(Class)tempClass limit:(NSString *)limit dictionary:(NSMutableDictionary *)dic;
- (BOOL)updateClassWithObj:(id)obj searchKey:(NSString *)searchKey searchValue:(NSString *)searchValue;
- (BOOL)updateTableWithDictionary:(NSMutableDictionary *)dic searchKey:(NSString *)searchKey searchValue:(NSString *)searchValue tableClass:(Class) tempClass;
- (BOOL)resetClassWithObj:(id)obj searchKey:(NSString *)searchKey searchValue:(NSString *)searchValue;


- (BOOL)deleteObjWithClass:(Class)tempClass;
- (BOOL)deleteObjWithClass:(Class)tempClass limit:(NSString *)limit;
- (BOOL)deleteObjWithClass:(Class)tempClass searchKey:(NSString *)searchKey searchValue:(NSString *)searchValue;


- (int)countItemByClass:(Class)tempClass limit:(NSString *)limit;

- (void)closeDataBase;
- (void)openDataBase;
@end
