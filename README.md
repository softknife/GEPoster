
![logo](https://github.com/EricYellow/PopularSite/blob/master/logo.png)

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
```objc

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

```objc
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

## 中文说明:

为什么这个库会出现? 系统通知有什么局限性?
带着这个问题,我们看一下如下代码:

```objc

// 发出通知

NSString *name = @"SomeNotification";
NSDictionary *para = @{
                        @"key1":@"参数1",
                        @"key2":@"参数2",
                        .....    
                        };
                        

[[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:para];


// 接收通知
@implementation Observer
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)init {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processNotification:) name:@"SomeNotification" object:nil];
}
- (void)processNotification:(NSNotification *)note {
     
     NSDictionary *userInfo = note.userInfo;
     NSString *para1 = userInfo[@"key1"];
     NSString *para2 = userInfo[@"key2"];
     
}
@end
```

从上面的代码中,我们可以看出两个问题:
- 1.每次监听通知后,都必须移除,实际上,我们的移除通知的作用仅仅是告诉系统该监听对象不再需要监听通知了, 而往往我们这个移除的过程都是当前监听者将要dealloc了;
- 2.我们发送通知时, 使用的参数和名字都是字符串类型, 而这个字符串的使用在团队开发时是个很棘手的问题, 你不能保证你的搭档永远和你写的一样,除非我们将这些字符串常量都定义为宏或者const常量, 但这显然也是事倍功半的.

正式基于这两个问题, 我特地做了这么一个库, 借助protocol和NSHashTable的作用, 解决了上面两个问题.具体使用方法请参考上述.

具体使用,请参考上面英文部分.

