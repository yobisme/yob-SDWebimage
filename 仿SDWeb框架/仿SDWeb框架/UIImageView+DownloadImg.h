//
//  UIImageView+DownloadImg.h
//  仿SDWeb框架
//
//  Created by Macx on 2017/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DownloadImg)

- (void)dl_imageWithUrlStr:(NSString *)urlStr;

@property (nonatomic,strong)NSString * preUrl;

@end
