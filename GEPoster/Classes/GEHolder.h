//
//  GEHolder.h
//  GEPoster
//
//  Created by 黄继平 on 2017/11/23.
//

#import <Foundation/Foundation.h>

@class GEPoster;
@interface GEHolder : NSObject
+ (instancetype)share;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**<广播者*/
@property (nonatomic , strong) GEPoster *poster;

#pragma mark - 注册
- (void)registObserver:(id)observer;

- (NSHashTable *)getObservers;

@end
