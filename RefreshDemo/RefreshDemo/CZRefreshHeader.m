//
//  CZRefreshHeader.m
//  SAGA_iOS
//
//  Created by  location on 16/9/9.
//  Copyright © 2016年 it.sozi. All rights reserved.
//

#import "CZRefreshHeader.h"
#import "CZCircleView.h"
#import <objc/runtime.h>

static const CGFloat headerH = 55.0;
static const CGFloat refreshTopInset = 64.0;

@interface CZRefreshHeader ()

/** 回调对象 */
@property (weak, nonatomic) id refreshingTarget;
/** 回调方法 */
@property (assign, nonatomic) SEL refreshingAction;
@property (nonatomic,assign) BOOL animating;

@end


@implementation CZRefreshHeader

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    CZRefreshHeader *header = [[NSBundle mainBundle] loadNibNamed:@"CZRefreshHeader" owner:nil options:nil].lastObject;
    CGRect frame = header.frame;
    frame.origin.y = -header.frame.size.height;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    header.frame = frame;
    header.layer.speed = 0;
    
    [header setRefreshingTarget:target refreshingAction:action];
    return header;
}

- (void)startRefreshing {
    NSLog(@"startRefreshing");
    self.animating = YES;
    self.layer.speed = 1;
    
    [self.refreshingTarget performSelector:self.refreshingAction];
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(headerH, 0, 0, 0);
    }];
}

- (void)endRefreshing {
    NSLog(@"endRefreshing");
    self.animating = NO;
    self.layer.timeOffset = 0;
    self.layer.speed = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }];
}

- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action {
    self.refreshingTarget = target;
    self.refreshingAction = action;
}


@end



/*****************************************  UIScrollView (CZRefresh)  *****************************************/

static void * const refreshHeaderKey = @"refreshHeaderKey";
@implementation UIScrollView (CZRefresh)

- (void)setRefreshHeader:(CZRefreshHeader *)refreshHeader {
    refreshHeader.scrollView = self;
    objc_setAssociatedObject(self, refreshHeaderKey, refreshHeader, OBJC_ASSOCIATION_RETAIN);
    [self insertSubview:refreshHeader atIndex:0];
    [self addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}

- (CZRefreshHeader *)refreshHeader {
    return objc_getAssociatedObject(self, refreshHeaderKey);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (self.isDragging && !self.refreshHeader.animating) {//下拉中
        self.refreshHeader.layer.timeOffset = (-self.contentOffset.y)/refreshTopInset;
        NSLog(@"timeOffset--%f",self.refreshHeader.layer.timeOffset);
    }
    
    if (!self.isDragging && self.contentOffset.y < -64 && !self.refreshHeader.animating) {//刷新
        [self.refreshHeader startRefreshing];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

@end
