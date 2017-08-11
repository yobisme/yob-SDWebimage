//
//  AppModel.h
//  仿SDWeb框架
//
//  Created by Macx on 2017/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

/// app名字
@property (nonatomic, copy) NSString *name;
/// app下载量
@property (nonatomic, copy) NSString *download;
/// app图标
@property (nonatomic, copy) NSString *icon;
@end
