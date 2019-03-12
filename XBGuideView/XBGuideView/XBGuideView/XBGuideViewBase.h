//
//  XBGuideViewBase.h
//  TongMeng
//
//  Created by 谢贤彬 on 2019/3/11.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import "XBAlertViewBase.h"
#import "XBGuideViewConfig.h"
#import "Masonry.h"

@class XBGuideViewBase;

@protocol XBGuideViewBaseDelegate <NSObject>

- (void)guideView:(XBGuideViewBase *)guideView didScrollToIndex:(NSInteger)index;
- (void)guideView:(XBGuideViewBase *)guideView didCreateImageView:(UIImageView *)imageView atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface XBGuideViewBase : XBAlertViewBase
@property (nonatomic,strong) UIScrollView *sv_content;
@property (nonatomic,strong) NSArray *arr_imageName;
@property (nonatomic,weak) id<XBGuideViewBaseDelegate>delegate;
@property (nonatomic,assign,readonly) NSInteger currentIndex;

- (instancetype)initWithImageNameArr:(NSArray *)imageNameArr;

- (void)didScrollToIndex:(NSInteger)index;
- (void)didCreateImageView:(UIImageView *)imageView atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
