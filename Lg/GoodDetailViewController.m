//
//  GoodDetailViewController.m
//  Lg
//
//  Created by echo21 on 15/10/7.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "GoodsModel.h"
#import "UserMpdel.h"
#import "LoginViewController.h"
#import "FenLeiViewController.h"
#import "UserMpdel.h"
#import "SureOrderViewController.h"
@interface GoodDetailViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) GoodsModel *good;
//购买的数量
@property (nonatomic,strong) NSString *count;
@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = @"1";
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    //[backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"top_backbtn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//设置背景图片
    self.navigationItem.backBarButtonItem = backItem;
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    //设置navigtionBar 的右按钮
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame = CGRectMake(0, 0, 25, 25);
    [rightBut setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    [self getGoodsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getGoodsData{
    NSString *url_str = [NSString stringWithFormat:@"http://www.lg568.com/index.php/Home/APIgoods/contentGoods/goods_id/%@",_goods_id];
    __weak typeof(self)myself = self;
    [SVProgressHUD showWithStatus:@"正在加载.." ];
    dispatch_async(dispatch_queue_create("lg.com", 0), ^{
        [HttpTools getWithURL:url_str params:nil success:^(id json) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            myself.good = [[GoodsModel alloc]init];
            [myself.good setGoodsValue:dic];
            myself.title = myself.good.goods_name;
            [myself.collectionView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error.description);
        }];
    });
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark Collection_代理


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"";
    switch (indexPath.row) {
        case 0:
            identifier = @"firstCell";
            break;
        case 1:
            identifier = @"secCell";
            break;
        case 2:
            identifier = @"thirdCell";
            break;
        case 3:
            identifier = @"fourthCell";
            break;
        case 4:
            identifier = @"fifthCell";
            break;
        case 5:
            identifier = @"sixCell";
            break;
        case 6:
            identifier = @"sevenCell";
            break;
        case 7:
            identifier = @"eightCell";
            break;
            
        default:
            break;
    }
    if (indexPath.row == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UILabel *titlelabel = (UILabel *)[cell viewWithTag:2000];
        titlelabel.text = _good.goods_title;
        UIButton *shoucangBut = (UIButton *)[cell viewWithTag:2001];
        [shoucangBut addTarget:self action:@selector(shoucangButClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    if (indexPath.row == 1) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UILabel *typeLabel = (UILabel *)[cell viewWithTag:2000];
        typeLabel.text = _good.goods_typename;
        UIButton *fenleiBut = (UIButton *)[cell viewWithTag:2001];
        [fenleiBut addTarget:self action:@selector(fenleiButClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    if (indexPath.row == 2) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UILabel *markePriceLabel = (UILabel *)[cell viewWithTag:2000];
        markePriceLabel.text =[NSString stringWithFormat:@"%@.0元",_good.goods_price] ;
        UILabel *priceLabel = (UILabel *)[cell viewWithTag:2001];
        if (_good.goods_price.length != 0 ) {
            
            
            priceLabel.text = [NSString stringWithFormat:@"%@.0元",_good.goods_marke_price] ;
            
            // 根据字体得到NSString的尺寸
            UIFont *fnt = [UIFont fontWithName:priceLabel.text size:26.0];
            CGSize size = [priceLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,priceLabel.frame.size.height/2.0,size.width,1)];
            label.backgroundColor = [UIColor lightGrayColor];
            //(0, priceLabel.frame.size.height/2.0, priceLabel.frame.size.width, 1)
            [priceLabel addSubview:label];
        }else{
            priceLabel.text = @"";
        }
        
        UIButton *plusBut = (UIButton *)[cell viewWithTag:2002];
        [plusBut addTarget:self action:@selector(plusButClick:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *addBut = (UIButton *)[cell viewWithTag:2004];
        [addBut addTarget:self action:@selector(addButClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *countLabel = (UILabel *)[cell viewWithTag:2003];
        countLabel.text = _count;
        return cell;
    }
    if (indexPath.row == 3) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UILabel *jifenLabel = (UILabel *)[cell viewWithTag:2000];
        jifenLabel.text = [NSString stringWithFormat:@"购买可以获得%@.0积分",_good.goods_marke_price];
        return cell;
    }
    if (indexPath.row == 4) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UILabel *contentLabel = (UILabel *)[cell viewWithTag:2000];
        contentLabel.text = [NSString stringWithFormat:@"   %@",_good.goods_content];
        return cell;
    }
    if (indexPath.row == 5) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UILabel *shopNameLabel = (UILabel *)[cell viewWithTag:2000];
        NSDictionary *dic = _good.contentShop;
        shopNameLabel.text = dic[@"shop_name"];
        UILabel *shopAddressLabel = (UILabel *)[cell viewWithTag:2001];
        shopAddressLabel.text = dic[@"shop_address"];
        return cell;
    }
    if (indexPath.row == 6) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UILabel *shopContactLabel = (UILabel *)[cell viewWithTag:2000];
        NSDictionary *dic = _good.contentShop;
        shopContactLabel.text = [NSString stringWithFormat:@"联系人:%@",dic[@"shop_contact"]];
        UILabel *shopTelLabel = (UILabel *)[cell viewWithTag:2001];
        shopTelLabel.text =[NSString stringWithFormat:@"电话:%@",dic[@"shop_tel"]] ;
        UIButton *callBut = (UIButton *)[cell viewWithTag:2002];
        [callBut addTarget:self action:@selector(callButClick:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *QQBut = (UIButton *)[cell viewWithTag:2003];
        [QQBut addTarget:self action:@selector(QQButClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    if (indexPath.row == 7) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UILabel *shopAboutLabel = (UILabel *)[cell viewWithTag:2000];
        NSDictionary *dic = _good.contentShop;
        shopAboutLabel.text = dic[@"shop_about"];
        return cell;
    }
    
    
    return nil;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        UIScrollView *scrollView = (UIScrollView *)[header viewWithTag:2000];
        NSArray *imgArr = _good.goods_imgs_new;
        if (imgArr.count !=0) {
            scrollView.contentSize = CGSizeMake(WIDTH*imgArr.count, 150);
            for (int i = 0; i<imgArr.count; i++) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.frame.size.height)];
                imgView.backgroundColor = [UIColor whiteColor];
                NSString *img_url = [NSString stringWithFormat:MyURL,imgArr[i ]];
                [imgView sd_setImageWithURL:[NSURL URLWithString:img_url] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
                [scrollView addSubview:imgView];
            }
        }else{
            scrollView.contentSize = CGSizeMake(WIDTH, 150);
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.frame.size.height)];
            imgView.image = [UIImage imageNamed:@"net_error_icon.png"];
            [scrollView addSubview:imgView];
        }
        return header;
    }
    return nil;
//    UICollectionViewFlowLayout
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0||indexPath.row == 1||indexPath.row == 3) {
        return CGSizeMake(WIDTH, 40);
    }
    if (indexPath.row == 2) {
        return CGSizeMake(WIDTH, 65);
    }
    if (indexPath.row == 4) {
        CGFloat height = [LZXHelper textHeightFromTextString:_good.goods_content width:WIDTH fontSize:16.0];
        return CGSizeMake(WIDTH, height+50);
    }
    if (indexPath.row == 5) {
        return CGSizeMake(WIDTH, 90);
    }
    if (indexPath.row == 6) {
        return CGSizeMake(WIDTH, 60);
    }
    if (indexPath.row == 7) {
        NSDictionary *dic = _good.contentShop;
    
        CGFloat height = [LZXHelper textHeightFromTextString:dic[@"shop_about"] width:WIDTH fontSize:16.0];
        return CGSizeMake(WIDTH, height+50);
    }
    return CGSizeZero;
}
//数量减按钮 点击事件
-(void)plusButClick:(UIButton *)but{
    //得到面板上的数量
    UICollectionViewCell *cell = (UICollectionViewCell *)but.superview.superview;
    UILabel *countLabel = (UILabel *)[cell viewWithTag:2003];
    UIButton *plusBut = (UIButton *)[cell viewWithTag:2002];
    //NSDictionary *dic = _good.contentShop;
    //NSString *num_str = dic[@"goods_number"];
    int textNum = [countLabel.text intValue];
    
    //int num = [num_str intValue];
    //数量最小为1
    if (textNum ==2) {
        //当数量为1时，改变减按钮的图片
        [plusBut setImage:[UIImage imageNamed:@"jian_gray.png"] forState:UIControlStateNormal];
        countLabel.text = [NSString stringWithFormat:@"%d",textNum];
        
    }
    if (textNum >1) {
        textNum = textNum-1;
        _count = [NSString stringWithFormat:@"%d",textNum];
        countLabel.text = [NSString stringWithFormat:@"%d",textNum];
    }
}
//数量加按钮 点击事件
-(void)addButClick:(UIButton *)but{
    UICollectionViewCell *cell = (UICollectionViewCell *)but.superview.superview;
    UILabel *countLabel = (UILabel *)[cell viewWithTag:2003];
    //NSDictionary *dic = _good.contentShop;
    NSString *num_str = _good.goods_number;
    int textNum = [countLabel.text intValue];
    int num = [num_str intValue];
    if(textNum == num){
        return;
    }
    UIButton *plusBut = (UIButton *)[cell viewWithTag:2002];
    if (textNum>=1) {
        //当数量大于2时，改变减按钮的图片
        [plusBut setImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
    }
    textNum+=1;
    _count = [NSString stringWithFormat:@"%d",textNum];
    countLabel.text = [NSString stringWithFormat:@"%d",textNum];
}
//收藏按钮点击事件
-(void)shoucangButClick:(UIButton *)but{
    UserMpdel *user = [LZXHelper IsLogin];
    if (user == nil) {
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else{
        NSDictionary *userInfo = user.userinfo;
        NSString *shoucang_Url = [NSString stringWithFormat:@"http://www.lg568.com/index.php/Home/APIuser/add_collect/goods_id/%@/user_id/%@",_goods_id,userInfo[@"user_id"]];
        __weak typeof(self)myself  = self;
        [HttpTools getWithURL:shoucang_Url params:nil success:^(id json) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"status"] intValue]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [FVCustomAlertView showDefaultWarningAlertOnView:myself.view withTitle:dic[@"content"]];
                });
                
            }
        } failure:^(NSError *error) {
            NSLog(@"error == %@",error.description);
        }];
    }
}
//打电话按钮事件
-(void)callButClick:(UIButton *)but{
    NSDictionary *contentShop = _good.contentShop;
    NSString *tell = contentShop[@"shop_tel"];
    if (tell.length == 0) {
        return;
    }
    NSString *openStr = [NSString stringWithFormat:@"tel://%@",tell];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openStr]];
}
//QQ 按钮事件
-(void)QQButClick:(UIButton *)but{
    [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"暂无QQ客服专员"];
}
//跳转分类按钮事件
-(void)fenleiButClick:(UIButton *)but{
    FenLeiViewController *fenleiVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FenLeiViewController"];
    fenleiVC.goods_type_url = _good.goods_type_url;
    [self.navigationController pushViewController:fenleiVC animated:YES];
}
//加入购物车事件http://www.lg568.com/index.php/Home/APIgoods/addcart/goods_id/3/goods_number/2/user_id/1
- (IBAction)addCarButClick:(id)sender {
    //http://www.lg568.com/index.php/Home/APIgoods/addcart/goods_id/3/goods_number/2/user_id/1
    UserMpdel *user = [LZXHelper IsLogin];
    if (user == nil) {
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES ];
    }else{
        NSString *url_str = @"http://www.lg568.com/index.php/Home/APIgoods/addcart";
        NSDictionary *userInfo = user.userinfo;
        NSDictionary *prama = @{
                                @"goods_id":_goods_id,
                                @"goods_number":_count,
                                @"user_id":userInfo[@"user_id"]
                                    };
        __weak typeof(self) myself = self;
        [HttpTools postWithURL:url_str params:prama success:^(id responseObject) {
            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([result isEqualToString:@"\"success\""]) {
                [FVCustomAlertView showDefaultWarningAlertOnView:myself.view withTitle:@"成功加入购物车"];
            }else{
                [FVCustomAlertView showDefaultWarningAlertOnView:myself.view withTitle:@"加入购物车失败，请稍后再试"];
            }
        } failure:^(NSError *error) {
            NSLog(@"error == %@",error.description);
        }];
    }
}

//立即购买事件
- (IBAction)buyNowButClick:(id)sender {
    UserMpdel *user = [LZXHelper IsLogin];
    if (user == nil) {
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES ];
    }else{
        SureOrderViewController * sureOrderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SureOrderViewController"];
        sureOrderVC.good = _good;
        sureOrderVC.count = _count;
        sureOrderVC.user = user;
        [self.navigationController pushViewController:sureOrderVC animated:YES];
    }
    
    
    
}
@end
