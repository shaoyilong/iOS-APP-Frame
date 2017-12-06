//
//  MainViewController.m
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/26.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import "MainViewController.h"
#import "SDCycleScrollView.h"
#import "PosterModel.h"

@interface MainViewController ()<SDCycleScrollViewDelegate>
{
    SDCycleScrollView *sliderScrollView;
}

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *scrollDataArr;
@property (nonatomic, strong) NSMutableArray *scrollImgArr;

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    self.navTitleName = @"首页";
    self.view.backgroundColor = [UIColor orangeColor];
    [super viewDidLoad];
    
    [self creatTableView];
    [self creatHeaderView];
    [self sendRequest];
    // Do any additional setup after loading the view.
}

- (void)sendRequest
{
    [[MainRequest sharedInstance] getMainViewInfoSuccess:^(MainViewModel *model) {
        
        [self loadData:model];
        
    } failure:^(NSError *error) {
        
    } noNetWork:^{
        
    }];
}

- (void)loadData:(MainViewModel *)model
{
    self.scrollImgArr = [NSMutableArray arrayWithCapacity:5];
    self.scrollDataArr = [NSMutableArray arrayWithArray:model.posters];
    
    for (PosterModel *m in _scrollDataArr)
    {
        [self.scrollImgArr addObject:m.picUrl];
    }

}

- (void)creatTableView
{
    self.myTableView = [UITableView new];
    [self.view addSubview:self.myTableView];
    
    self.myTableView.backgroundColor = [UIColor orangeColor];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.tableFooterView = [[UIView alloc] init];
}

- (void)creatHeaderView
{
    UIView *header = [UIView new];
    
    sliderScrollView = [SDCycleScrollView new];
    //    sliderScrollView.imageURLStringsGroup = imagesURLStrings;
    [header addSubview:sliderScrollView];
    
    sliderScrollView.delegate = self;
    sliderScrollView.placeholderImage = ImageNamed(@"img_placeholder_header");
    sliderScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;//动画效果pagecontrol  如果不设置这个  就不能设置下面pagecontrol的图片
    sliderScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;//pagecontrol居中对齐
    sliderScrollView.currentPageDotImage = ImageNamed(@"ic_dot_select");
    sliderScrollView.pageDotImage = ImageNamed(@"ic_dot");
    sliderScrollView.autoScrollTimeInterval = 3.0f;
    
    if (IS_IPAD)
    {
        [sliderScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.height.equalTo(@260);
        }];
    }
    else
    {
        [sliderScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.height.equalTo(@160);
        }];
    }

    self.myTableView.tableHeaderView = header;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identi = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    
    cell.textLabel.text = @"aaaaaaaaaaaaaaa";
    cell.detailTextLabel.text = @"bbbbbbbbbbb";

    cell.backgroundColor = [UIColor cyanColor];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
