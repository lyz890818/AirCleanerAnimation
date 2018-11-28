//
//  OvalView.m
//  tools
//
//  Created by zly on 2018/11/27.
//  Copyright © 2018 lyz. All rights reserved.
//

#import "OvalView.h"

@implementation OvalView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self startLoadingRotationAnimation];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    for (int i = 0; i < 15; i ++) {
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-self.bounds.size.width/2.0, -self.bounds.size.width/10.0 * 4.5, self.bounds.size.width, self.bounds.size.width/10.0 * 9.0)];
        [path applyTransform:CGAffineTransformMakeRotation((90 + 6 * i) * M_PI/180.0)];
        [path applyTransform:CGAffineTransformMakeTranslation(self.bounds.size.width/2, self.bounds.size.height/2)];
        [[UIColor colorWithWhite:1.0 alpha:(0.7 - 0.04*i)] setStroke];
        [path stroke];
    }
}


- (void)startLoadingRotationAnimation
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 10.0;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
