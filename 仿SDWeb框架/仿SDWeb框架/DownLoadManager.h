//
//  DownLoadManager.h
//  仿SDWeb框架
//
//  Created by Macx on 2017/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownLoadManager : NSObject

+ (instancetype)sharedManager;


- (void)downLoadManagerWithUrlStr:(NSString *)urlStr finishedBlock:(void(^)(UIImage *image))finishedBlock;


- (void)cancelPreOperationWithPreUrlStr:(NSString *)preUrl;

@end
