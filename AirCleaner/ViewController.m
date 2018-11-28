//
//  ViewController.m
//  AirCleaner
//
//  Created by zly on 2018/11/28.
//  Copyright © 2018 lyz. All rights reserved.
//

#import "ViewController.h"
#import "MainAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0];
    // create
    
    MainAnimationView *animationView = [[MainAnimationView alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    
    [self.view addSubview:animationView];
}


@end
