//
//  DownLoadManager.m
//  仿SDWeb框架
//
//  Created by Macx on 2017/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "DownLoadManager.h"
#import "DownloadOperation.h"
#import "NSString+path.h"

@interface DownLoadManager ()
@property (nonatomic,strong)NSMutableDictionary * opCache;

@property (nonatomic,strong)NSString * preUrl;

@property (nonatomic,strong)NSOperationQueue * queue;


//自定义的图片内存缓存池
@property (nonatomic,strong)NSMutableDictionary * imgCache;
@end

@implementation DownLoadManager


//单例方法
+ (instancetype)sharedManager
{
    static id instance;
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}


- (instancetype)init
{
    if (self = [super init])
    {
        self.opCache = [NSMutableDictionary new];
        
        self.queue = [NSOperationQueue new];
        
        self.imgCache = [NSMutableDictionary new];
        
        
        //处理内存警告的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMomery) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
    }
    return self;
}

- (void)clearMomery
{
    [self.imgCache removeAllObjects];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)downLoadManagerWithUrlStr:(NSString *)urlStr finishedBlock:(void (^)(UIImage *))finishedBlock
{
    
    //判断缓存数据
    
    //先判断是否在内存中有缓存,有的话回调,然后return
    if ([self.imgCache objectForKey:urlStr])
    { if (finishedBlock != nil)
        {
            finishedBlock([self.imgCache objectForKey:urlStr]);
            
            NSLog( @"从内存中加载");
            return;
        
        }
    }
    
    
    //判断沙盒里面有没有缓存
    UIImage *image = [UIImage imageWithContentsOfFile:[urlStr appendCachePath]];
    if (image)
    {
        [self.imgCache setObject:image forKey:urlStr];

        if (finishedBlock != nil)
        {
            finishedBlock(image);
            
            NSLog( @"从沙盒中加载");
            return;
            
        }
    }
    
    
/*
 
 从网络下载图片
 
 */
    DownloadOperation *op = [DownloadOperation downloadOperationWithUrlStr:urlStr finishedBlock:^(UIImage *image) {
        if (finishedBlock != nil)
        {
             finishedBlock(image);
            NSLog(@"从网络下载");
            
            //将图片缓存到内存图片缓存池里面
            [self.imgCache setObject:image forKey:urlStr];
            
        }
   //图片下载完了之后,该操作没必要存在,直接移除
        //[self.opCache removeObjectForKey:url];
    }];
    
    [self.opCache setObject:op forKey:urlStr];
    
    [self.queue addOperation:op];

}

- (void)cancelPreOperationWithPreUrlStr:(NSString *)preUrl
{
    DownloadOperation *preOp = [self.opCache objectForKey:preUrl];
    
    if (preOp != nil)
    {
        [preOp cancel];
        [self.opCache removeObjectForKey:preUrl];
    }
    
}


@end
