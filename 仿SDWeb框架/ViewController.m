//
//  ViewController.m
//  仿SDWeb框架
//
//  Created by Macx on 2017/5/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "AppModel.h"
#import "DownloadOperation.h"
#import "DownLoadManager.h"
#import "UIImageView+DownloadImg.h"
@interface ViewController ()

@property (nonatomic,strong)NSArray * array;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//创建队列
@property (nonatomic,strong)NSOperationQueue * queue;

@property (nonatomic,strong)NSMutableDictionary * opCache;

@property (nonatomic,strong)NSString * preUrl;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = [NSOperationQueue new];
    
    self.opCache = [NSMutableDictionary new];
    
    [self loadData];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.array == nil) {
        return;
    }
    int num = arc4random_uniform((int)self.array.count);
    
    AppModel *model = self.array[num];

    NSString *url = model.icon;

    [self.imgView dl_imageWithUrlStr:url];
    
//    
//    //判断当前图片的地址和上一个图片的地址是否相同,如果不相同,应该把上一次的图片地址相对应的操作取消,并从操作缓存池里面移除掉,这么做是为了防止连点之后出现图片连闪的情况
//    if (![url isEqualToString:self.preUrl] && self.preUrl != nil)
//    {
//        [[DownLoadManager sharedManager] cancelPreOperationWithPreUrlStr:self.preUrl];
//        
////        DownloadOperation *preOp = [self.opCache objectForKey:self.preUrl];
////        
////        [preOp cancel];
////        
////        [self.opCache removeObjectForKey:self.preUrl];
//        
//    }
//    self.preUrl = url;
//    
//    
//    [[DownLoadManager sharedManager] downLoadManagerWithUrlStr:url finishedBlock:^(UIImage *image) {
//        self.imgView.image = image;
//    }];
//    
//
//    
}



//加载数据
- (void)loadData
{
    [[AFHTTPSessionManager manager] GET:@"https://raw.githubusercontent.com/zhangxiaochuZXC/SHHM05/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.array = [NSArray yy_modelArrayWithClass:[AppModel class] json:responseObject];
        
         NSLog(@"%@",self.array);
        
    } failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
