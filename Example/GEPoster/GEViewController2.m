//
//  GEViewController2.m
//  GEPoster_Example
//
//  Created by 黄继平 on 2017/11/23.
//  Copyright © 2017年 hjphfut@163.com. All rights reserved.
//

#import "GEViewController2.h"

#import "MyPoster.h"
#import "Model.h"

@interface GEViewController2 ()<MyNotification2>

@end

@implementation GEViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [MyPoster registObserver:self];
    
}

- (void)dealloc{
    
    NSLog(@"第二个controller死了");
    
    [[MyPoster share] controllerIsDealloc];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"touched.....");
    
    Model *info = [Model new];
    info.name = @"小狗子";
    info.isMale = YES;
    [[MyPoster share] controllerDidReceiveSomeModelInfo:info];
    
}

#pragma mark -MyNotification2
- (void)controllerDidReceiveSomeModelInfo:(Model *)info
{
    NSLog(@"%@", [NSString stringWithFormat:@"did Receive info:%@",info]);
    
}

@end
