//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * 🌟🌟🌟 新建SDCycleScrollView交流QQ群：185534916 🌟🌟🌟
 *
 * 在您使用此自动轮播库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * 新浪微博:GSD_iOS
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios
 *
 * 另（我的自动布局库SDAutoLayout）：
 *  一行代码搞定自动布局！支持Cell和Tableview高度自适应，Label和ScrollView内容自适应，致力于
 *  做最简单易用的AutoLayout库。
 * 视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * 用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 * GitHub：https://github.com/gsdios/SDAutoLayout
 *********************************************************************************
 
 */


#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"

@implementation SDCollectionViewCell
{
    __weak UILabel *_titleLabel;
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleImageView];
        [self setupTitleLabel];
    }
    
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel
{    
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
    
}

- (void)setupTitleImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
//    [_titleImageView setImage:KKImage(@"gradient_bar")];
    _titleImageView = imageView;
    _titleImageView.hidden = YES;
    [self.contentView addSubview:imageView];
}

- (void)setTitleImageView:(UIImageView *)titleImageView
{
    if (![_titleImageView isEqual:titleImageView])
    {
        _titleImageView = titleImageView;
    }
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    
    CGFloat titleLabelW = self.sd_width-60-10;
    CGFloat titleLabelH = _titleLabelHeight;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = self.sd_height - titleLabelH;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    _titleLabel.hidden = !_titleLabel.text;
    
    _titleImageView.frame = CGRectMake(0, self.sd_height - _titleLabelHeight, SCREEN_WIDTH, _titleLabelHeight);
    
    _titleImageView.hidden = !_titleLabel.text;//如果没有内容就隐藏标题背景图
}

@end
