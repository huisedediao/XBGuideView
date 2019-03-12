//
//  XBGuideViewBase.m
//  TongMeng
//
//  Created by 谢贤彬 on 2019/3/11.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import "XBGuideViewBase.h"

@interface XBGuideViewBase ()<UIScrollViewDelegate>

@end

@implementation XBGuideViewBase

- (instancetype)initWithImageNameArr:(NSArray *)imageNameArr
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if (self = [super initWithDisplayView:window])
    {
        self.arr_imageName = imageNameArr;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.sv_content = ({
        UIScrollView *scrollView = [UIScrollView new];
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        scrollView;
    });
}

- (void)actionBeforeShow
{
    UIView *lastView = nil;
    for (NSString *imageName in self.arr_imageName)
    {
        NSInteger index = [self.arr_imageName indexOfObject:imageName];
        UIImageView *imageView = [UIImageView new];
        [self.sv_content addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([UIScreen mainScreen].bounds.size);
            if (lastView)
            {
                make.left.equalTo(lastView.mas_right);
            }
            else
            {
                make.left.equalTo(self.sv_content);
            }
            make.top.equalTo(self.sv_content);
            if (imageName == [self.arr_imageName lastObject])
            {
                make.right.lessThanOrEqualTo(self.sv_content);
            }
        }];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:imageName];
        if (self.delegate && [self.delegate respondsToSelector:@selector(guideView:didCreateImageView:atIndex:)])
        {
            [self.delegate guideView:self didCreateImageView:imageView atIndex:index];
        }
        [self didCreateImageView:imageView atIndex:index];
        lastView = imageView;
    }
    
    self.showLayoutBlock = ^(XBAlertViewBase *alertView) {
        alertView.frame = [UIScreen mainScreen].bounds;
    };
    self.hiddenLayoutBlock = ^(XBAlertViewBase *alertView) {
        alertView.frame = [UIScreen mainScreen].bounds;
    };
}

#pragma mark - scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / kScreenWidth;
    [self didScrollToIndex:_currentIndex];
    if (self.delegate && [self.delegate respondsToSelector:@selector(guideView:didScrollToIndex:)])
    {
        [self.delegate guideView:self didScrollToIndex:_currentIndex];
    }
}

- (void)didScrollToIndex:(NSInteger)index
{
    
}

- (void)didCreateImageView:(UIImageView *)imageView atIndex:(NSInteger)index
{
    
}

@end
