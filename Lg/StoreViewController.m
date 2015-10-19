//
//  StoreViewController.m
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "StoreViewController.h"
#import "GoodsTypeModel.h"
#import "FVCustomAlertView.h"
#import "ListgoodsModel.h"
#import "Add_goodsModel.h"
#import "GoodDetailViewController.h"
@interface StoreViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
//商品类型数组
@property (nonatomic,strong) NSMutableArray *goodsTypeArr;
//当前选中的tableviewCell
@property (nonatomic,assign) long flag;
@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTableViewData];
    //改变返回按钮的样式
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    //[backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"top_backbtn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//设置背景图片
    self.navigationItem.backBarButtonItem = backItem;
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dicc;
    
    
    
    _flag = 0;
    _goodsTypeArr = [NSMutableArray array];
    _tableview.tableFooterView = [[UIView alloc]init];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getTableViewData{
    NSString *url_Str = @"http://www.lg568.com/index.php/Home/APIgoods/goodsType/city_id/2";
    [SVProgressHUD showWithStatus:@"正在加载.."];
    __weak typeof(self)myself = self;
    dispatch_async(dispatch_queue_create("www.lg.com", 0), ^{
        
        [HttpTools getWithURL:url_Str params:nil success:^(id json) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            for(NSDictionary *dic in arr){
                GoodsTypeModel *goodsType = [[GoodsTypeModel alloc]init];
                [goodsType setGoodsTypeValue:dic];
                [myself.goodsTypeArr addObject:goodsType];
            }
            [myself.tableview reloadData];
            [myself.collectionview reloadData];
            NSIndexPath *first = [NSIndexPath indexPathForRow:0 inSection:0];
            [_tableview selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionNone];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        } failure:^(NSError *error) {
            NSLog(@"error == %@",error.description);
        }];

    });
    }
////选中tableviewcell的背景view
//-(void)addTabelBgView{
//    _bgView.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//}
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
    return _goodsTypeArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    //设置cell的选中背景
    UIView *bgView = [[UIView alloc]initWithFrame:cell.frame];
    bgView.backgroundColor = [UIColor whiteColor];
    UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, 3, bgView.frame.size.height-2)];
    blueView.backgroundColor = [UIColor blueColor];
    [bgView addSubview:blueView];
    cell.selectedBackgroundView = bgView;
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:20];
    GoodsTypeModel *goodType = _goodsTypeArr[indexPath.row];
    typeLabel.text = goodType.goods_type_name;
    typeLabel.font = [UIFont systemFontOfSize:14.0];
    if (indexPath.row == 0) {
        typeLabel.textColor = [UIColor redColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for(int i = 0;i<_goodsTypeArr.count;i++){
        
        if (i == indexPath.row) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UILabel *label = (UILabel *)[cell viewWithTag:20];
            label.textColor = [UIColor redColor];
        }else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            UILabel *label = (UILabel *)[cell viewWithTag:20];
            label.textColor = [UIColor blackColor];
        }
    }
    _flag = indexPath.row ;
    [_collectionview reloadData];
}



#pragma mark collectionView_代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //第一次执行代理的时候_goodsTypeArr为空，直接取值的话报错，所以加判断
    if (_goodsTypeArr.count == 0) {
        return 0;
    }
    GoodsTypeModel *goodtype = _goodsTypeArr[_flag];
    //NSArray *listgoods = goodtype.listgoods;
    if (goodtype.listgoods.count == 0 ) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"暂无数据，请稍后重试!"];
        
        return 0;
    }
    return goodtype.listgoods.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsTypeModel *goodtype = _goodsTypeArr[_flag];
    NSArray *listArr = goodtype.listgoods;
    ListgoodsModel *listgood = listArr[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:20];
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = 5;
    NSString *img_Str = [NSString stringWithFormat:MyURL,listgood.goods_imgs];
    [imgView sd_setImageWithURL:[NSURL URLWithString:img_Str] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:21];
    nameLabel.text = listgood.goods_name;
    //cell.backgroundColor = [UIColor purpleColor];
  
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    GoodsTypeModel *goodtype;
    if (_goodsTypeArr.count != 0) {
        goodtype = _goodsTypeArr[_flag];
    }
    NSArray *arr =goodtype.add_goods;
    if (arr.count != 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
            
            UIScrollView *scrollview = (UIScrollView *)[header viewWithTag:20];
            for (UIView *imageview in scrollview.subviews) {
                if(imageview.tag==50){
                    [imageview removeFromSuperview];
                }
            }
            scrollview.contentSize = CGSizeMake(header.frame.size.width*arr.count, header.frame.size.height);
            for (int i = 0; i<arr.count; i++) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(header.frame.size.width*i, 0, header.frame.size.width, header.frame.size.height)];
                Add_goodsModel *add = arr[i ];
                NSString *imgStr1 =add.goods_ad;
                NSString *imgStr = [NSString stringWithFormat:MyURL,imgStr1];
                [imgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
                imgView.tag = 50;
                [scrollview addSubview:imgView];
            }
            return header;
        }
    }else{
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        header.frame = CGRectMake(0, 0, 0, 0);
        return header;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (collectionView.frame.size.width)/3.0;
    return CGSizeMake(width, width);
}
//设置Header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (_goodsTypeArr.count == 0) {
        return CGSizeZero;
    }
    GoodsTypeModel *goodType = _goodsTypeArr[_flag];
    if (goodType.add_goods.count != 0) {
        return CGSizeMake(collectionView.frame.size.width, 100);
    }
    return CGSizeZero;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(5, 0, 0, 0);
}
//cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodDetailViewController *goodDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodDetailViewController"];
    GoodsTypeModel *goodtype = _goodsTypeArr[_flag];
    NSArray *listArr = goodtype.listgoods;
    ListgoodsModel *listgood = listArr[indexPath.row];
    goodDetailVC.goods_id = listgood.goods_id;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:goodDetailVC animated:YES];
}
@end
