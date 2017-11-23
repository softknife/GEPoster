# GEPoster


[![CI Status](http://img.shields.io/travis/hjphfut@163.com/GEPoster.svg?style=flat)](https://travis-ci.org/hjphfut@163.com/GEPoster)
[![Version](https://img.shields.io/cocoapods/v/GEPoster.svg?style=flat)](http://cocoapods.org/pods/GEPoster)
[![License](https://img.shields.io/cocoapods/l/GEPoster.svg?style=flat)](http://cocoapods.org/pods/GEPoster)
[![Platform](https://img.shields.io/cocoapods/p/GEPoster.svg?style=flat)](http://cocoapods.org/pods/GEPoster)



## Description
Replacement for  NSNotificationCenter !

In order to take full advantage of the system notification tool, I made this library specifically.
This library mimics the usage of system notification, while extending the userInfo parameter.



## Example

Subclass GEPoster , and then you can use it like this:

1. Create  your notification methods and Poster instance
```object-c

#import <GEPoster.h>

@protocol MyNotification1<NSObject>

@optional
- (void)controllerDidReceiveSomething:(NSString *)something;
@end


@class Model;
@protocol MyNotification2<NSObject>

@optional
- (void)controllerDidReceiveSomeModelInfo:(Model *)info;

@end


@protocol MyNotification<MyNotification1,MyNotification2>@end

@interface MyPoster : GEPoster<MyNotification>
@end
```

2. Use the poster like this:

```object-c
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


- (void)controllerDidReceiveSomething:(NSString *)something
{
    NSLog(@"%@", [NSString stringWithFormat:@"did Receive somethion:%@",something]);
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"touched.....");
    
    
    Model *info = [Model new];
    info.name = @"Hello Gloria";
    info.isMale = YES;
    [[MyPoster share] controllerDidReceiveSomeModelInfo:info];
    
    
    // or 
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

```


To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

GEPoster is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GEPoster'
```

## Author

hjphfut@163.com

## License

GEPoster is available under the MIT license. See the LICENSE file for more info.




**********************

说明:

鉴于系统通知使用不便, 我特地制作了这个库, 你可以像使用系统通知一样使用这个库.同时你可以得到如下特性:
- 1.不需要remove observer.
- 2.我扩展了系统通知的userInfo这个参数, 你可以写任意参数.

具体使用,请参考上面英文部分.

