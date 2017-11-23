//
//  GEHolder.m
//  GEPoster
//
//  Created by 黄继平 on 2017/11/23.
//

#import "GEHolder.h"

// 单例
static id instance_;

@interface GEHolder()
/** 注册保存数组*/
@property (nonatomic , strong) NSHashTable *observers;
@end



@implementation GEHolder
- (NSHashTable *)observers
{
    if (!_observers) {
        _observers = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    return _observers;
}

+ (instancetype)share
{
    return [[self alloc] __init__];
}

- (instancetype)__init__
{
    return [super init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}




#pragma mark - 注册
- (void)registObserver:(id)observer
{
    
    __block BOOL hadRegist = NO;
    [self.observers.allObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isEqual:observer]) {
            
            hadRegist = YES;
            *stop = YES;
            return ;
        }
        
    }];
    
    if (hadRegist) return;
    
    [self.observers addObject:observer];
}


#pragma mark - OPEN
- (NSHashTable *)getObservers
{
    return  self.observers;
}



@end
