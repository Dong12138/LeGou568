//
//  SureOrderViewController.m
//  Lg
//
//  Created by echo21 on 15/10/16.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "SureOrderViewController.h"
#import "ZhifuAndPeisongView.h"
#import "UpdateShouHuoViewController.h"
#import "OrderDetailViewController.h"
@interface SureOrderViewController ()<ZhifuAndPeisongDelegate,UpdateShouHuoDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *acountLabel;
@property(nonatomic,strong) NSDictionary *info;
@property (nonatomic,strong) NSDictionary *Consignee;
//支付方式数组
@property(nonatomic,strong) NSArray *zhifuArr;

//配送方式数组
@property(nonatomic,strong) NSArray *peisongArr;

@property (nonatomic,assign) long flag;

@property (nonatomic,strong) NSString *remark;
//支付方式标示
@property (nonatomic,assign) long zhifuFlag;
//配送方式标示
@property (nonatomic,assign) long peisongFlag;
@end

@implementation SureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    //[backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"top_backbtn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//设置背景图片
    self.navigationItem.backBarButtonItem = backItem;

    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dicc;
    int p = [_good.goods_price intValue];
    int c = [_count intValue];
    int sum = p*c;
    NSString *pStr = [NSString stringWithFormat:@"¥%d",sum ];
    _acountLabel.text = pStr;
    _info = _user.userinfo;
    _tableview.tableFooterView = [[UIView alloc]init];
    [self getDAta];
    // Do any additional setup after loading the view.
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
-(void)getDAta{
    
    NSString *str = [NSString stringWithFormat:@"http://www.lg568.com/index.php/Home/APIgoods/confOrder/user_id/%@",_info[@"user_id"]];
    __weak typeof(self)myself = self;
    [HttpTools getWithURL:str params:nil success:^(id json) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        myself.Consignee = dic[@"Consignee"];
        myself.zhifuArr = dic[@"order_pay_id"];
        myself.peisongArr = dic[@"order_delivery"];
        [myself.tableview reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error == %@",error.description);
    }];
}
#pragma  mark Tableview_代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        UIImageView *imgView = (UIImageView *)[cell viewWithTag:2000];
        NSDictionary *dic = _good.goods_imgs_new[0];
        NSString *str = [NSString stringWithFormat:MyURL,dic[@"img"]];
        [imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
       // imgView.image = [UIImage imageNamed:str];
        
        UILabel *label = (UILabel *)[cell viewWithTag:2001];
        label.text = _good.goods_name;
        
        UILabel *countLabel = (UILabel *)[cell viewWithTag:2002];
        NSString *countStr = [NSString stringWithFormat:@"x%@",_count];
        countLabel.text = countStr;
        
        UILabel *priceLabel = (UILabel *)[cell viewWithTag:2003];
        priceLabel.text = @"本店价";
        
        UILabel *priceLabel1 = (UILabel *)[cell viewWithTag:2004];
        NSString *priceStr = [NSString stringWithFormat:@"¥%@",_good.goods_price];
        priceLabel1.text = priceStr;
        
        UILabel *markLabel = (UILabel *)[cell viewWithTag:2005];
        markLabel.text = @"市场价";
        
        UILabel *markLabel1 = (UILabel *)[cell viewWithTag:2006];
        NSString *markStr = [NSString stringWithFormat:@"¥%@",_good.goods_marke_price];
        markLabel1.text = markStr;
        
        UILabel *label1 = (UILabel *)[cell viewWithTag:2007];
        label1.text = @"购物金额小计";
        
        UILabel *price = (UILabel *)[cell viewWithTag:2008];
        int p = [_good.goods_price intValue];
        int c = [_count intValue];
        int sum = p*c;
        NSString *pStr = [NSString stringWithFormat:@"¥%d",sum ];
        price.text = pStr;
        return cell;
    }else{
       // NSDictionary *info = _user.userinfo;
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secCell" forIndexPath:indexPath];
            UILabel *nameLabel = (UILabel *)[cell viewWithTag:2000];
            nameLabel.text = _Consignee[@"user_name"];
            
            UILabel *phoneLabel = (UILabel *)[cell viewWithTag:2001];
            phoneLabel.text = _Consignee[@"user_phone"];
            
            UILabel *addressLabel = (UILabel *)[cell viewWithTag:2002];
            addressLabel.text = _Consignee[@"user_address"];
            return cell;
        }
        if (indexPath.row == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell" forIndexPath:indexPath];
            UILabel *zhifuLabel = (UILabel *)[cell viewWithTag:2000];
            NSDictionary *dic = _zhifuArr[0];
            zhifuLabel.text = dic[@"content"];
//            int sum = [dic[@"money"]intValue]+[_count intValue];
//            _acountLabel.text = [NSString stringWithFormat:@"¥%d",sum];
            return cell;
        }if (indexPath.row == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fourthCell" forIndexPath:indexPath];
            UILabel *peisongLabel = (UILabel *)[cell viewWithTag:2000];
            NSDictionary *dic =_peisongArr[0];
            peisongLabel.text = dic[@"content"];
            int sum = [_good.goods_price intValue]*[_count intValue]+[dic[@"money"]intValue];
            _acountLabel.text = [NSString stringWithFormat:@"¥%d",sum];
            return cell;
        }
        return nil;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        _flag = indexPath.row;
        if (indexPath.row == 0) {
            UpdateShouHuoViewController *updateVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdateShouHuoViewController"];
            updateVC.dic = _Consignee;
            updateVC.delegate = self;
            [self.navigationController pushViewController:updateVC animated:YES];
        }
        if (indexPath.row == 1) {
            
            ZhifuAndPeisongView *zhifuView = [[ZhifuAndPeisongView alloc]initWithFrame:self.view.frame :_zhifuArr];
            zhifuView.delegate = self;
            [self.view addSubview:zhifuView];
        }if (indexPath.row == 2) {
            ZhifuAndPeisongView *zhifuView = [[ZhifuAndPeisongView alloc]initWithFrame:self.view.frame :_peisongArr];
            zhifuView.delegate = self;
            [self.view addSubview:zhifuView];
        }
    }
    
}
//支付方式和配送方式代理
-(void)callBack:(long)tag{
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:_flag inSection:1]];
    UILabel *label = (UILabel *)[cell viewWithTag:2000];
    NSDictionary *dic = nil;
    if (_flag == 1) {
        dic = _zhifuArr[tag-2000];
        label.text = dic[@"content"];
        _zhifuFlag = tag-2000;
    }else{
        dic = _peisongArr[tag-2000];
        label.text = dic[@"content"];
        int sum = [_good.goods_price intValue]*[_count intValue]+[dic[@"money"]intValue];
        _acountLabel.text = [NSString stringWithFormat:@"¥%d",sum];
        _peisongFlag = tag-2000;
    }
    
//    [_tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:_flag inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
}
//修改配送地址代理
-(void)callback:(NSDictionary *)dic{
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
    UILabel *nameL = (UILabel *)[cell viewWithTag:2000];
    nameL.text = dic[@"name"];
    UILabel *phoneLabel = (UILabel *)[cell viewWithTag:2001];
    phoneLabel.text = dic[@"phone"];
    UILabel *addressL = (UILabel *)[cell viewWithTag:2002];
    addressL.text = dic[@"address"];
    _remark = dic[@"remark"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"订单详情";
    }else{
        return @"收货地址";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 70;
        }else {
            return 50;
        }
    }
    return 0;
}

//提交订单  按钮点击事件
- (IBAction)OKButClick:(UIButton *)sender {
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
    UILabel *addressL = (UILabel *)[cell viewWithTag:2002];
    UILabel *nameL = (UILabel *)[cell viewWithTag:2000];
    UILabel *phoneL = (UILabel *)[cell viewWithTag:2001];
    if ([addressL.text containsString:@"请输入地址"]) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"请输入地址"];
        return;
    }else{
        NSString *zhifu = [NSString stringWithFormat:@"%ld",_zhifuFlag];
        NSString *peisong = [NSString stringWithFormat:@"%ld",_peisongFlag];
        NSString *buyorder_url = @"http://www.lg568.com/index.php/Home/APIgoods/buyorder";
        NSDictionary *dic = @{
                              @"goods_id":_good.goods_id,
                              @"goods_number":_count,
                              @"user_id":_info[@"user_id"],
                              @"order_consignee":nameL.text,
                              @"order_tel":phoneL.text,
                              @"order_address":addressL.text,
                              @"order_pay_id":zhifu,
                              @"order_remarks":_remark,
                              @"order_delivery":peisong
                              };
        [SVProgressHUD show];
        __weak typeof(self)myself = self;
        [HttpTools postWithURL:buyorder_url params:dic success:^(id responseObject) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            [FVCustomAlertView showDefaultWarningAlertOnView:myself.view withTitle:resultDic[@"content"]];
            if ([resultDic[@"status"] intValue]) {
                [SVProgressHUD dismiss];
               // NSLog(@"订单生成成功");
                //NSLog(@"订单号=====%@",resultDic[@"order_sn"]);
                OrderDetailViewController *orderVC = [myself.storyboard instantiateViewControllerWithIdentifier:@"OrderDetailViewController"];
                orderVC.order_sn = resultDic[@"order_sn"];
                [myself.navigationController pushViewController:orderVC animated:YES];
            }
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error.description);
            [SVProgressHUD dismiss];
        }];
    }
}

@end
