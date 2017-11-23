//
//  MyPoster.h
//  GEPoster_Example
//
//  Created by 黄继平 on 2017/11/23.
//  Copyright © 2017年 hjphfut@163.com. All rights reserved.
//

#import <GEPoster.h>

@protocol MyNotification1<NSObject>

@optional
- (void)controllerDidReceiveSomething:(NSString *)something;
- (void)controllerIsDealloc;
@end


@class Model;
@protocol MyNotification2<NSObject>

@optional
- (void)controllerDidReceiveSomeModelInfo:(Model *)info;

@end




@protocol MyNotification<MyNotification1,MyNotification2>@end

@interface MyPoster : GEPoster<MyNotification>



@end


