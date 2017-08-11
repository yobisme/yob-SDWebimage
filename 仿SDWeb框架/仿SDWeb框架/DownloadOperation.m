//
//  DownloadOperation.m
//  仿SDWeb框架
//
//  Created by Macx on 2017/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "DownloadOperation.h"

#import "NSString+path.h"

@interface DownloadOperation ()

@property (nonatomic,strong)NSString * urlStr;

@property (nonatomic,copy)void(^finishedBlock)(UIImage *);

@end


@implementation DownloadOperation

+ (instancetype)downloadOperationWithUrlStr:(NSString *)urlStr finishedBlock:(void (^)(UIImage *))finishedBlock
{
    DownloadOperation *op = [DownloadOperation new];
    
    op.urlStr = urlStr;
    
    op.finishedBlock = finishedBlock;

    return op;
}


- (void)main
{
    [NSThread sleepForTimeInterval:1];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    //沙盒缓存二进制data数据
    if (image != nil)
    {
        [data writeToFile:[self.urlStr appendCachePath] atomically:YES];
    }
    
    
    if (self.cancelled == YES)
    {
        return;
    }
    
    
    if (self.finishedBlock) {
        
        
        //回到主线程回调block
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.finishedBlock(image);
        }];
    }
    
}


@end
