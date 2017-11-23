//
//  GEPoster.h
//  GEPoster
//
//  Created by 黄继平 on 2017/11/23.
//

#import <Foundation/Foundation.h>
#import "GEHolder.h"


@interface GEPoster : NSObject

+ (instancetype)share;

+ (void)registObserver:(id)observer;

@end
