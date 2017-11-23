//
//  Model.m
//  GEPoster_Example
//
//  Created by 黄继平 on 2017/11/23.
//  Copyright © 2017年 hjphfut@163.com. All rights reserved.
//

#import "Model.h"

@implementation Model

- (NSString *)description
{
    return [NSString stringWithFormat:@"name=%@,sex=%@",self.name,self.isMale?@"男":@"女"];
}

@end
