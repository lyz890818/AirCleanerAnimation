//
//  StarView.m
//  tools
//
//  Created by zly on 2018/11/26.
//  Copyright © 2018 lyz. All rights reserved.
//

#import "StarView.h"

@implementation StarView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 定时添加飞入点
    static dispatch_source_t _timer;
    NSTimeInterval period = 0.3; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    // 事件回调
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i = 0; i < 1; i++) {
                int rand = random()%4;
                if (rand == 0) {
                    int x = random()%20;
                    int y = random()%((int)self.bounds.size.height);
                    CGPoint point = CGPointMake(x, y);
                    [self drawStarWithPoint:point];
                }
                if (rand == 1) {
                    int y = random()%20;
                    int x = random()%((int)self.bounds.size.width);
                    CGPoint point = CGPointMake(x, y);
                    [self drawStarWithPoint:point];
                }
                
                if (rand == 2) {
                    int x = random()%20 + self.bounds.size.width - 20;
                    int y = random()%((int)self.bounds.size.height);
                    CGPoint point = CGPointMake(x, y);
                    [self drawStarWithPoint:point];
                }
                
                if (rand == 3) {
                    int y = random()%20 + self.bounds.size.height - 20;
                    int x = random()%((int)self.bounds.size.width);
                    CGPoint point = CGPointMake(x, y);
                    [self drawStarWithPoint:point];
                }
            }
        });
    });
    
    // 开启定时器
    dispatch_resume(_timer);
}


- (void)drawStarWithPoint:(CGPoint)point {
    
    // 贝塞尔曲线(创建一个圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:3.0 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    // 创建一个shapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame         = CGRectMake(point.x, point.y, 6, 6);
    layer.fillColor     = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;;   // 闭环填充的颜色
    layer.path          = path.CGPath;                    // 从贝塞尔曲线获取到形状
    layer.strokeStart   = 0.0f;
    layer.strokeEnd     = 1.0f;
    [self.layer addSublayer:layer];
    
    // 点的移动动画
    CAKeyframeAnimation *keyFramedAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 创建路径
    CGMutablePathRef animationPath = CGPathCreateMutable();
    // 添加贝塞尔曲线路径
    CGPathMoveToPoint(animationPath, nil, point.x, point.y);
    CGPathAddLineToPoint(animationPath, nil, self.bounds.size.width/2.0, self.bounds.size.width/2.0);
    keyFramedAnimation.path = animationPath;
    keyFramedAnimation.duration = 5;
    keyFramedAnimation.repeatCount = 1;
    [layer addAnimation:keyFramedAnimation forKey:@"keyFrame"];
    
    // 点的颜色渐变动画
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    colorAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    colorAnimation.toValue = [NSNumber numberWithFloat:-1.0f];//透明度。
    colorAnimation.autoreverses = NO;
    colorAnimation.duration = 5;
    colorAnimation.repeatCount = 1;
    colorAnimation.removedOnCompletion = NO;
    colorAnimation.fillMode = kCAFillModeForwards;
    colorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:colorAnimation forKey:@"aAlpha"];
    
    // 点的大小缩放动画
    CABasicAnimation *frameAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    frameAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    frameAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    frameAnimation.autoreverses = NO;
    frameAnimation.duration = 5;
    frameAnimation.repeatCount = 1;
    frameAnimation.removedOnCompletion = NO;
    frameAnimation.fillMode = kCAFillModeForwards;
    [layer addAnimation:frameAnimation forKey:@"scale"];
    
    // 动画执行完后移除当前layer
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [layer removeFromSuperlayer];
    });
    
}




@end
