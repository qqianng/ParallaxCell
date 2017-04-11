//
//  CZCircleView.m
//  SAGA_iOS
//
//  Created by new on 17/3/22.
//  Copyright © 2017年 it.sozi. All rights reserved.
//

#import "CZCircleView.h"
#import "Colours.h"


@implementation CZCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupAnimation];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupAnimation];
}

- (void)setupAnimation {
    CGFloat radius = self.frame.size.width / 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 6;
    shapeLayer.strokeColor = [UIColor colorFromHexString:@"#cfcfcf"].CGColor;//@"#ececec"
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    //路径的头
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    anim1.values = @[@0,@1,@1];
    
    //路径的尾
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    anim2.values = @[@0,@0,@1];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    group.duration = 1;
    group.repeatCount = CGFLOAT_MAX;
    group.animations = @[anim1, anim2];
    
    [shapeLayer addAnimation:group forKey:@"group"];
    [self.layer addSublayer:shapeLayer];
}

- (CGSize)intrinsicContentSize {
    return self.frame.size;
}

@end
