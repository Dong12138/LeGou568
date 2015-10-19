//
//  FenLeiViewController.m
//  Lg
//
//  Created by echo21 on 15/10/8.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "FenLeiViewController.h"
#include "FenLeiGoodsModel.h"
#import "GoodDetailViewController.h"
#import "TableView.h"
@interface FenLeiViewController ()<FenLeiDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *listGoodsArr;
@property (nonatomic,strong) NSMutableArray *listTypeArr;
//上下刷新
@property (nonatomic,assign) BOOL isHeaderRefresh;
@property (nonatomic,assign) BOOL isFooterRefresh;

@property (nonatomic,assign) NSString *pageIndex;
@property (nonatomic,assign) NSString *pageSize;
//点的是哪个按钮，价格，时间，销量
@property (nonatomic,strong) NSString *order;

@property (nonatomic,strong) UIView *fenleiView;

//加载分类的tableview
@property (nonatomic,strong) TableView *tabView ;
@property (nonatomic,assign) BOOL isSelectrd;
@end

@implementation FenLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    //[backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"top_backbtn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//设置背景图片
    self.navigationItem.backBarButtonItem = backItem;
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    
    _listGoodsArr = [NSMutableArray array];
    _listTypeArr = [NSMutableArray array];
    _tableview.tableFooterView = [[UIView alloc]init];
    _pageIndex = @"1";
    _pageSize = @"10";
    _order = @"1";
    // [self fenLeiView];
    [self.view addSubview:_tabView];
    [self getFenLeiData];
    [self HeaderAndFooterRefresh];
    // Do any additional setup after loading the view.
}
//-(void)fenLeiView{
//    _fenleiView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
//    _fenleiView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//
//    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
//    [window addSubview:_fenleiView];
//}
-(void)getFenLeiData{
    
    [SVProgressHUD showWithStatus:@"正在加载.."];
    __weak typeof(self)myself = self;
    NSDictionary *dic=@{
                        @"list_order":_order,
                        @"page_num":_pageIndex,
                        @"page_size":_pageSize
                        };
    dispatch_async(dispatch_queue_create("lg.com", 0), ^{
        [HttpTools postWithURL:_goods_type_url params:dic success:^(id json) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            NSArray *goodsArr = dic[@"listGoods"];
            NSArray *goodType = dic[@"listType"];
            if (myself.isHeaderRefresh) {
                //若是刷新数据时，将数组清空，加载最新的10条数据
                //                _goods_type_url = [NSString stringWithFormat:@"%@/list_order/1/page_num/%@/page_size/%@",_goods_type_url,@"0",_pageSize];
                [myself.listGoodsArr removeAllObjects];
                
            }
//            if (myself.listTypeArr.count!=0) {
//                //[myself.listGoodsArr removeAllObjects];
//                [myself.listTypeArr removeAllObjects];
//            }
            for(NSDictionary *subDic in goodsArr){
                FenLeiGoodsModel *goods = [[FenLeiGoodsModel alloc]init];
                [goods setFenLeiGoods:subDic];
                [myself.listGoodsArr addObject:goods];
                
            }
            if (goodType.count != 0) {
                [myself.listTypeArr removeAllObjects];
            }
            for(NSDictionary *subdic in goodType){
                [myself.listTypeArr addObject:subdic];
            }
            [myself.tableview reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            [myself endRefresh];
        } failure:^(NSError *error) {
            NSLog(@"error == %@",error.description);
            [myself endRefresh];
        }];
        
    });
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
#pragma mark TableView_代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listGoodsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FenLeiGoodsModel *goods = _listGoodsArr[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:2000];
    NSString *imgStr = goods.goods_imgs;
    imgStr = [NSString stringWithFormat:MyURL,imgStr];
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2001];
    nameLabel.text = goods.goods_name;
    UILabel *priceLabel = (UILabel *)[cell viewWithTag:2002];
    priceLabel.text = [NSString stringWithFormat:@"¥%@",goods.goods_price];
    UILabel *saleLabel = (UILabel *)[cell viewWithTag:2003];
    saleLabel.text = [NSString stringWithFormat:@"%@人付款",goods.goods_sales];
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:2004];
    NSString *timeStr = [goods.goods_addtime substringToIndex:10];
    timeLabel.text = timeStr;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FenLeiGoodsModel *goods = _listGoodsArr[indexPath.row];
    GoodDetailViewController *goodsDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodDetailViewController"];
    goodsDetailVC.goods_id = goods.goods_id;
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
}


#pragma mark Button_点击事件
//价格list_order/2/page_num/1/page_size/10
- (IBAction)priceButClick:(UIButton *)but {
    _pageIndex = @"1";
    [_listGoodsArr removeAllObjects];
    if (!_tabView.hidden) {
        _tabView.hidden = YES;
    }
    UIView *v = but.superview;
    but.backgroundColor = [UIColor groupTableViewBackgroundColor];
    for(UIButton *bb in v.subviews){
        if (bb != but) {
            bb.backgroundColor = [UIColor whiteColor];
        }
    }
    
    
    _order = @"1";
    [self getFenLeiData];
}
//分类按钮 点击事件
- (IBAction)fenLeiButClick:(id)sender {
    
    
        if (_tabView) {
        if (_tabView.hidden) {
            _tabView.hidden = NO;
        }else{
            _tabView.hidden = YES;
        }
        
    }else{
        _tabView = [[TableView alloc]initWithFrame:CGRectMake(0, 94, WIDTH, HEIGHT)];
        _tabView.delegate = self;
        _tabView.listType = _listTypeArr;
        _tabView.tableView.frame = CGRectMake(((WIDTH-7)/4.0*3+8), 0, (WIDTH-4)/4.0,30*_listTypeArr.count);
        [_tabView.tableView reloadData];
        //_tabView.center = CGPointMake(WIDTH/2.0, (HEIGHT-94)/2.0);
        _isSelectrd = YES;
        [self.view addSubview:_tabView];
    }

}
//给view添加touch事件 ，点击的时候隐藏
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _tabView.hidden =YES;
}


//销量
- (IBAction)saleButClick:(UIButton *)but {
    _pageIndex = @"1";
    [_listGoodsArr removeAllObjects];
    if (!_tabView.hidden) {
        _tabView.hidden = YES;
    }

    but.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView *v = but.superview;
    for(UIButton *bb in v.subviews){
        if (bb != but) {
            bb.backgroundColor = [UIColor whiteColor];
        }
    }
    
    _order = @"2";
    [self getFenLeiData];
}
//时间
//- (IBAction)timeButClick:(UIButton *)but {
//
//}
- (IBAction)timeButClick:(UIButton *)but {
    _pageIndex = @"1";
    [_listGoodsArr removeAllObjects];
    if (!_tabView.hidden) {
        _tabView.hidden = YES;
    }

    but.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView *v = but.superview;
    for(UIButton *bb in v.subviews){
        if (bb != but) {
            bb.backgroundColor = [UIColor whiteColor];
        }
    }
    
    _order = @"3";
    [self getFenLeiData];
}
-(void)HeaderAndFooterRefresh{
    __weak typeof(self)myself= self;//解决循环引用问题
    [_tableview addHeaderWithCallback:^{
        //如果正在刷新，不让其再次刷新
        
        if (myself.isHeaderRefresh) {
            return ;
        }
        myself.isHeaderRefresh = YES;
        myself.pageIndex = @"1";
        myself.pageSize = @"10";
        [myself getFenLeiData];
    }];
    [_tableview addFooterWithCallback:^{
        if (myself.isFooterRefresh) {
            return ;
        }
        myself.isFooterRefresh = YES;
        //改变当前的页数
        __block int pageIndex = [myself.pageIndex intValue];
        pageIndex++;
        myself.pageIndex = [NSString stringWithFormat:@"%d",pageIndex];
        
        [myself getFenLeiData];
    }];
}
//停止刷新http://www.lg568.com/index.php/Home/APIgoods/listGoods/goods_type_pid/12/goods_type_id/82/city_id/2
-(void)endRefresh{
    if (self.isHeaderRefresh) {
        self.isHeaderRefresh = NO;
        [_tableview headerEndRefreshing];
    }
    if (self.isFooterRefresh) {
        self.isFooterRefresh = NO;
        [_tableview footerEndRefreshing];
    }
}
//分类的tableview 上的代理方法
-(void)reloadCollectionView:(NSString *)url{
    _goods_type_url = url;
    [_listGoodsArr removeAllObjects];
    
    [self getFenLeiData];
}

@end
