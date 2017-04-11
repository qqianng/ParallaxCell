//
//  cell.m
//  Demo
//
//  Created by new on 16/11/16.
//  Copyright © 2016年 it.sozi. All rights reserved.
//

#import "CZCell.h"

CGFloat const CZCellH = 240.0;
NSString * const CZTableVCTableViewDidScrollNotification = @"CZTableVCTableViewDidScrollNotification";


@interface CZCell ()

@end

@implementation CZCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewDidScrollAction) name:CZTableVCTableViewDidScrollNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tableViewDidScrollAction {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    //将self坐标系下点的坐标，转换成window下的坐标。
    CGPoint point = [window convertPoint:CGPointZero fromView:self];
//    NSLog(@"y--%f",point.y);
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat imageH = self.bgView.frame.size.height;//235
    CGFloat delta = imageH - CZCellH;
    
    CGFloat minY = -delta;
    CGFloat maxY = 0;
    CGFloat imageY = -delta + (point.y+CZCellH)/(screenH+CZCellH) * delta;
    
    if (imageY < minY) imageY = minY;
    if (imageY > maxY) imageY = maxY;
    
    CGRect frame = self.bgView.frame;
    frame.origin.y = imageY;
    self.bgView.frame = frame;
}


@end
