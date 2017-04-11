//
//  CZRefreshHeader.h
//  SAGA_iOS
//
//  Created by  location on 16/9/9.
//  Copyright © 2016年 it.sozi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZCircleView.h"

@interface CZRefreshHeader : UIView

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
@property (weak, nonatomic) IBOutlet CZCircleView *circleView;
@property (nonatomic,weak) UIScrollView *scrollView;

- (void)startRefreshing;
- (void)endRefreshing;

@end


/*****************************************  UIScrollView (CZRefresh)  *****************************************/

@interface UIScrollView (CZRefresh)

- (void)setRefreshHeader:(CZRefreshHeader *)refreshHeader;
- (CZRefreshHeader *)refreshHeader;

@end
