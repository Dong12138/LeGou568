//
//  WelcomeViewController.m
//  Lg
//
//  Created by echo21 on 15/9/25.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "WelcomeViewController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface WelcomeViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIPageControl *pc;
@property (nonatomic,strong) UIScrollView * sv;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.backgroundColor = [UIColor whiteColor];
    //[self.window makeKeyAndVisible];
    
    //    利用NSUserDefaults实现
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [self addScrollViewContent];
        NSLog(@"首次启动");
        NSLog(@"path == %@",NSHomeDirectory() );
    }else {
        NSLog(@"非首次启动");
        
    }

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
    [self.view addSubview:_pc];
    [self.view addSubview:_sv];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
