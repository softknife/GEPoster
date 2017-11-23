//
//  GEViewController.m
//  GEPoster
//
//  Created by hjphfut@163.com on 11/23/2017.
//  Copyright (c) 2017 hjphfut@163.com. All rights reserved.
//

#import "GEViewController.h"
#import "MyPoster.h"

#import "Model.h"

@interface GEViewController ()<MyNotification1>

@end

@implementation GEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MyPoster registObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

- (void)controllerDidReceiveSomething:(NSString *)something
{
    NSLog(@"%@", [NSString stringWithFormat:@"did Receive somethion:%@",something]);
}

- (void)controllerIsDealloc
{
    
    NSLog(@"some controller is dealloc");
    
    Model *info = [Model new];
    info.name = @"你死了吗?";
    info.isMale = YES;
    [[MyPoster share] controllerDidReceiveSomeModelInfo:info];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"touched.....");
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (int i  = 0; i < 100; i++) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"第%zd次",i);
                
                [[MyPoster share] controllerDidReceiveSomething:[NSString stringWithFormat:@"这是我发送的第 [%zd] 个通知",i]];
                
            });
            
        }
    });
}

@end
