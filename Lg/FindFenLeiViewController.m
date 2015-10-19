//
//  FindFenLeiViewController.m
//  Lg
//
//  Created by echo21 on 15/10/14.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "FindFenLeiViewController.h"
#import "TableViewController.h"
#import "FindDetailViewController.h"
@interface FindFenLeiViewController ()<UIScrollViewDelegate,TiaozhuanDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *buttonScroll;
@property (weak, nonatomic) IBOutlet UIScrollView *tableviewScroll;
@property (nonatomic,strong) UIView *selectedView;
@property (nonatomic,assign) BOOL IsFirst;
@end

@implementation FindFenLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //改变返回按钮的样式
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    //[backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"top_backbtn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//设置背景图片
    self.navigationItem.backBarButtonItem = backItem;
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dicc;
    self.title = @"分类信息";
    _tableviewScroll.delegate = self;
    [self addButtonScrollView];
    [self addTableViewScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addButtonScrollView{
    _buttonScroll.contentSize = CGSizeMake(WIDTH/5.0*_small_infp_type.count, 40);
    _buttonScroll.backgroundColor = [UIColor groupTableViewBackgroundColor];
    for (int i = 0; i<_small_infp_type.count; i++) {
        NSDictionary *dic = _small_infp_type[i];
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.tag = 2000+i;
        but.font = [UIFont systemFontOfSize:14.0];
        if (i == _flag) {
            [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        but.frame = CGRectMake(i*(WIDTH/5.0), 0, WIDTH/5.0, 35);
        [but setTitle:dic[@"info_type_name"] forState:UIControlStateNormal];
        [but setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [but addTarget:self action:@selector(typeButClick:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonScroll addSubview:but];
    }
    _selectedView = [[UIView alloc]initWithFrame:CGRectMake(_flag*WIDTH/5.0, 35, WIDTH/5.0, 5)];
    _selectedView.backgroundColor = [UIColor colorWithRed:199/255.0  green:97/255.0 blue:20/255.0 alpha:1.0];
    [_buttonScroll addSubview:_selectedView];
}
-(void)addTableViewScrollView{
    _tableviewScroll.contentSize = CGSizeMake(WIDTH*_small_infp_type.count, HEIGHT-64-48);
    _tableviewScroll.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<_small_infp_type.count; i++) {
        TableViewController *tableVC = [[TableViewController alloc]init];
        tableVC.delegeta = self;
        tableVC.index = _index;
        if (i == _flag) {
            NSDictionary *dic = _small_infp_type[i];
            tableVC.type_link = dic[@"type_link"];
            tableVC.aaaa = _flag;
            [tableVC tableViewReloadData];
        }
        tableVC.view.frame = CGRectMake(i*WIDTH, 0, WIDTH, _tableviewScroll.frame.size.height);
        tableVC.view.backgroundColor = [UIColor clearColor];
        [self addChildViewController:tableVC];
        [_tableviewScroll addSubview:tableVC.view];
    }
    [_tableviewScroll setContentOffset:CGPointMake(WIDTH*_flag, 0)];
}
//
-(void)typeButClick:(UIButton *)but{
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _selectedView.frame = CGRectMake((but.tag-2000)*WIDTH/5.0, 35, WIDTH/5.0, 5);
    for(UIView *vvv in _buttonScroll.subviews){
        if ([vvv isKindOfClass:[UIButton class]]) {
            UIButton *bb = (UIButton *)vvv;
            if (bb.tag!=but.tag) {
                [bb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
    NSDictionary *dic = _small_infp_type[but.tag-2000];
    TableViewController *tableVC = self.childViewControllers[but.tag-2000];
    tableVC.type_link = dic[@"type_link"];
    [tableVC tableViewReloadData];
    CGPoint point = CGPointMake(tableVC.view.frame.origin.x, tableVC.view.frame.origin.y);
    [_tableviewScroll setContentOffset:point animated:YES];
    _IsFirst = YES;
    //TableViewController *tableViewVC =
}



#pragma mark ScrollView_代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{
    _IsFirst = YES;
    int x = scrollView.contentOffset.x/WIDTH;
    if (x == _small_infp_type.count) {
        return;
    }
    NSLog(@"xxxxx == %d",x);
    TableViewController *tableVC = self.childViewControllers[x] ;
    NSDictionary *dic = _small_infp_type[x];
    tableVC.type_link = dic[@"type_link"];
    [tableVC tableViewReloadData];
//    if (_IsFirst) {
//        if (tableVC.listInfoArr.count == 0) {
//            [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"暂无数据,请稍后再试"];
//        }
//    }
    
    for(UIView *vvv in _buttonScroll.subviews){
        if ([vvv isKindOfClass:[UIButton class]]) {
            UIButton *bb = (UIButton *)vvv;
            if (bb.tag == 2000+x) {
                [bb setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                _selectedView.frame = CGRectMake(x*WIDTH/5.0, 35, WIDTH/5.0, 5);
                // _buttonScroll.contentOffset = CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
//                if (bb.frame.origin.x>=WIDTH-WIDTH/5.0) {
//                    [_buttonScroll setContentOffset:CGPointMake(x*WIDTH/5.0, 0) animated:YES];
//                }
                 [_buttonScroll setContentOffset:CGPointMake(x*WIDTH/5.0, 0) animated:YES];

            }else{
                [bb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
    
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)callBack:(NSString *)info_link :(int)index{
    FindDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FindDetailViewController"];
    detailVC.info_link = info_link;
    detailVC.flag = index;
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
