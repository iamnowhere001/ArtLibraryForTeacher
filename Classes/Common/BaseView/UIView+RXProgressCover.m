//
//  UIView+RXProgressCover.m
//  RXProgressCover
//
//  Created by iXcoder on 16/5/15.
//  Copyright © 2016年 iXcoder. All rights reserved.
//
#import <objc/runtime.h>
#import "UIView+RXProgressCover.h"

const void *RXProgressCoverOuterKey = &RXProgressCoverOuterKey;
const void *RXProgressCoverInnerKey = &RXProgressCoverInnerKey;

@implementation UIView (RXProgressCover)

- (void)setRate:(CGFloat)rate {
    [self outerCover];
    self.innerLayer.strokeStart = rate;
}

- (CGFloat)rate {
    return self.innerLayer.strokeStart;
}

- (CAShapeLayer *)outerCover {
    CAShapeLayer *outer = objc_getAssociatedObject(self, RXProgressCoverOuterKey);
    if (outer) {
        
    } else {
        CGFloat holeRadius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 4.;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        UIBezierPath *holePath = [UIBezierPath bezierPathWithArcCenter:center radius:holeRadius startAngle:M_PI_2 endAngle:-M_PI * 3 / 2 clockwise:NO];
        [path appendPath:holePath];
        
        outer = [CAShapeLayer layer];
        outer.frame = self.bounds;
        outer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
        outer.fillRule = kCAFillRuleEvenOdd;
        outer.path = path.CGPath;
        
        [self.layer addSublayer:outer];
        self.layer.masksToBounds = YES;
        objc_setAssociatedObject(self, RXProgressCoverOuterKey, outer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return outer;
}

- (CAShapeLayer *)innerLayer
{
    CAShapeLayer *layer = objc_getAssociatedObject(self, RXProgressCoverInnerKey);
    if (layer) {
        
    } else {
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat holeRadius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 4.;
        holeRadius -= 3;
        
        layer = [CAShapeLayer layer];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:holeRadius / 2. startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
        [path closePath];
        
        layer.path = path.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineWidth = holeRadius;
        layer.contentsGravity = @"center";
        layer.strokeEnd = 1.0;
        layer.strokeStart = 0.f;
        layer.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
        
        //layer.affineTransform = CGAffineTransformMakeRotation(- M_PI_2);
        
        [self.layer addSublayer:layer];
        self.layer.masksToBounds = YES;
        objc_setAssociatedObject(self, RXProgressCoverInnerKey, layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return layer;
}


- (void)removeProgressCover:(BOOL)animated
{
    CALayer *inner = objc_getAssociatedObject(self, RXProgressCoverInnerKey);
    if (inner) {
        [inner removeFromSuperlayer];
        objc_setAssociatedObject(self, RXProgressCoverInnerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    CAShapeLayer *outer = objc_getAssociatedObject(self, RXProgressCoverOuterKey);
    if (outer) {
        if (animated) {
            CGFloat holeRadius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 4.;
            CGFloat width = CGRectGetWidth(self.bounds);
            CGFloat height = CGRectGetHeight(self.bounds);
            CGFloat diaginal = sqrt(width * width + height * height);
            
            NSTimeInterval duration = 2.f;
            
            CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scale.fromValue = @1;
            scale.toValue = @(diaginal / holeRadius);
            scale.duration = duration;
            scale.fillMode = kCAFillModeForwards;
            scale.removedOnCompletion = NO;
            scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            [outer addAnimation:scale forKey:@"expand"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [outer removeFromSuperlayer];
            });
            
        } else {
            [outer removeFromSuperlayer];
        }
        
        objc_setAssociatedObject(self, RXProgressCoverOuterKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
