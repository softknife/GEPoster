//
//  GEPoster.m
//  GEPoster
//
//  Created by 黄继平 on 2017/11/23.
//

#import "GEPoster.h"


void GELog(NSString *format, ...) {
#ifdef DEBUG
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}


@implementation GEPoster



+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [GEHolder share].poster = [[self alloc] init];
    });
    
    return [GEHolder share].poster;
}

+ (void)registObserver:(id)observer
{
    [[GEHolder share] registObserver:observer];
}



// 转发消息
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    
    GELog(@"startForwardInvocation : %@",NSStringFromSelector(anInvocation.selector));
    
    [[[GEHolder share] getObservers].allObjects enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Class clazz =  [obj class];
        
        if ([clazz instanceMethodForSelector:anInvocation.selector]) {
            
            if ([obj respondsToSelector:anInvocation.selector]) {
                
                [anInvocation invokeWithTarget:obj];
                GELog(@"forwardInvocationTo:%@",obj);
                
            }
        }
    }];
}



@end
