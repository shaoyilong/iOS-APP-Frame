//
//  BaseTableViewController.h
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/25.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseTableViewController : BaseNavViewController <UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) NSMutableArray *arrayData;

@end
