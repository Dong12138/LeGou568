//
//  ViewController.m
//  Lg
//
//  Created by echo21 on 15/9/25.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIPageControl *pc;
@property (nonatomic,strong) UIScrollView * sv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.backgroundColor = [UIColor whiteColor];
    //[self.window makeKeyAndVisible];
    
    //    利用NSUserDefaults实现
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        NSLog(@"首次启动");
        [self addScrollViewContent];
    }else {
        NSLog(@"非首次启动");
        [self addImageViewContent];
    }
    

}
//加载启动动画
-(void)addImageViewContent{
    UIStoryboard *mainSto = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UITabBarController *TBC= [mainSto instantiateViewControllerWithIdentifier:@"TabBarController"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"load_640_1136.png"];
    [self.view addSubview:imageView];
    [self.view bringSubviewToFront:imageView];
    NSString *urlStr = @"http://www.lg568.com/index.php/Home/API/yindaoCompany/city_id/2";
    [HttpTools getWithURL:urlStr params:nil success:^(id json) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        NSString *imgUrl = dic[@"company_ad"];
        imgUrl = [NSString stringWithFormat:MyURL,imgUrl];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"load_640_1136.png"]];
            double delay = 1.0;//设置延迟时间
            dispatch_time_t time= dispatch_time(DISPATCH_TIME_NOW, (int64_t)delay*NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1.0 animations:^{
                    imageView.center = CGPointMake(-WIDTH/2.0, HEIGHT/2.0);
                } completion:^(BOOL finished) {
                    [imageView removeFromSuperview];
                    [self addChildViewController:TBC];
                    [self.view addSubview:TBC.view];
                }];
            });

       // NSLog(@"string = %@",imgUrl);
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error.description);
    }];
    
}


//加载欢迎页，ScrollView
-(void)addScrollViewContent{
    _sv = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _sv.backgroundColor = [UIColor whiteColor];
    _sv.contentSize = CGSizeMake(WIDTH*4, HEIGHT);
    _sv.delegate = self;
    _sv.showsVerticalScrollIndicator = NO;
    _sv.pagingEnabled = YES;
    NSArray *imgArr = @[@"w1.jpg",@"w2.jpg",@"w3.jpg",@"w4.jpg"];
    for (int i = 0; i<4; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT)];
        imgView.image = [UIImage imageNamed:imgArr[i]];
        imgView.userInteractionEnabled = YES;//图片可点击
        if (i == 3) {
            UIButton *goMainBut = [UIButton buttonWithType:UIButtonTypeCustom];
            
            goMainBut.frame = CGRectMake((WIDTH-180)/2.0, (HEIGHT-150), 180, 48);
            goMainBut.backgroundColor = [UIColor clearColor];
            [goMainBut setImage:[UIImage imageNamed:@"scr_button_jr.png"] forState:UIControlStateNormal];
            [goMainBut addTarget:self action:@selector(goHomeButClick:) forControlEvents:UIControlEventTouchUpInside];
            [imgView addSubview:goMainBut];
        }
        [_sv addSubview:imgView];
    }
    //pageControl 初始化
    _pc = [[UIPageControl alloc] initWithFrame:CGRectMake((WIDTH-45)/2.0, HEIGHT-95, 39, 37)];
    _pc.backgroundColor = [UIColor clearColor];
    _pc.numberOfPages = imgArr.count;
    _pc.hidesForSinglePage = YES;
    _pc.currentPage = 0;
    [_pc addTarget:self action:@selector(pcClick:) forControlEvents:UIControlEventValueChanged];
    //NSLog(@"window == %@",self.window);
    [self.view addSubview:_sv];
    [self.view addSubview:_pc];
    
}
#pragma mark goMain_点击事件
-(void)goHomeButClick:(UIButton *)but{
    [_sv removeFromSuperview];
    UIStoryboard *mainSto = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UITabBarController *TBC= [mainSto instantiateViewControllerWithIdentifier:@"TabBarController"];
    [self addChildViewController:TBC];
    [self.view addSubview:TBC.view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark scrollView_代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int current = scrollView.contentOffset.x/WIDTH;
    
    //根据scrollView 的位置对page 的当前页赋值
    //_pc = (UIPageControl *)[self.view viewWithTag:201];
    _pc.currentPage = current;
    
    //当显示到最后一页时，让滑动图消失
    if (_pc.currentPage == 3) {
        
        //调用方法，使滑动图消失
        //        [self scrollViewDisappear];
    }
}
//pageController 点击事件
-(void)pcClick:(UIPageControl *)p{
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = self.view.frame.size;
    CGRect rect = CGRectMake(p .currentPage * viewSize.width, 600, WIDTH, 20);
    [_sv scrollRectToVisible:rect animated:YES];
}

@end
