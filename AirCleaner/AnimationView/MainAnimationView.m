//
//  MainAnimationView.m
//  tools
//
//  Created by zly on 2018/11/28.
//  Copyright © 2018 lyz. All rights reserved.
//

#import "MainAnimationView.h"
#import "StarView.h"
#import "OvalView.h"


@implementation MainAnimationView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        StarView *starView = [[StarView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [self addSubview:starView];
        
        OvalView *view = [[OvalView alloc] initWithFrame:CGRectMake((frame.size.width - 250.0/414.0 * frame.size.width)/2, (frame.size.width - 250.0/414.0 * frame.size.width)/2, 250.0/414.0 * frame.size.width, 250.0/414.0 * frame.size.width)];
        [self addSubview:view];
        
    }
    return self;
}

@end
