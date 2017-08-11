//
//  UIImageView+DownloadImg.m
//  仿SDWeb框架
//
//  Created by Macx on 2017/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "UIImageView+DownloadImg.h"

#import "DownLoadManager.h"

#import <objc/runtime.h>

@implementation UIImageView (DownloadImg)

- (void)setPreUrl:(NSString *)preUrl
{
    objc_setAssociatedObject(self, "key", preUrl, 0);

}

- (NSString *)preUrl
{
    return objc_getAssociatedObject(self, "key");
}

- (void)dl_imageWithUrlStr:(NSString *)urlStr
{
    //判断当前图片的地址和上一个图片的地址是否相同,如果不相同,应该把上一次的图片地址相对应的操作取消,并从操作缓存池里面移除掉,这么做是为了防止连点之后出现图片连闪的情况
    if (![urlStr isEqualToString:self.preUrl] && self.preUrl != nil)
    {
        [[DownLoadManager sharedManager] cancelPreOperationWithPreUrlStr:self.preUrl];
        
    
    }
    self.preUrl = urlStr;
    
    
    [[DownLoadManager sharedManager] downLoadManagerWithUrlStr:urlStr finishedBlock:^(UIImage *image) {
        self.image = image;
    }];
    

}

@end
