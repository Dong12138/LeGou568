//
//  OrderDetailViewController.m
//  Lg
//
//  Created by echo21 on 15/10/17.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *but;
@property (nonatomic,strong) NSDictionary *orderDic;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getOrderDetailData];
    _but.layer.borderColor = _but.titleLabel.textColor.CGColor;
    _but.layer.borderWidth = 1.0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getOrderDetailData{
    NSString *str = [NSString stringWithFormat:@"http://www.lg568.com/index.php/Home/APIuser/infoorder/order_sn/%@",_order_sn];
    [SVProgressHUD show];
    __weak typeof(self)myself = self;
    [HttpTools getWithURL:str params:nil success:^(id json) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        myself.orderDic = dic;
        [myself.tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"error == %@",error.description);
    }];
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
    if (_orderDic == nil) {
        return 0;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        UILabel *snLabel = (UILabel *)[cell viewWithTag:2000];
        UILabel *orderStatusL = (UILabel *)[cell viewWithTag:2001];
        UILabel *payStatusL = (UILabel *)[cell viewWithTag:2002];
        UILabel *priceL = (UILabel *)[cell viewWithTag:2003];
        UIButton *payBut = (UIButton *)[cell viewWithTag:2004];
        snLabel.text = _orderDic[@"order_sn"];
        orderStatusL.text = _orderDic[@"order_status_text"];
        payStatusL.text = _orderDic[@"order_pay_status_text"];
        NSString *str = [NSString stringWithFormat:@"¥%@",_orderDic[@"order_amount"]];
        priceL.text = str;
        payBut.layer.masksToBounds = YES;
        payBut.layer.borderColor = payBut.titleLabel.textColor.CGColor;
        payBut.layer.borderWidth = 1.0;
        return cell;
    }
    if (indexPath.section == 1) {
        NSArray *listgoods = _orderDic[@"listgoods"];
        NSDictionary *goodDic = listgoods[0];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secCell" forIndexPath:indexPath];
        UIImageView *imgView = (UIImageView *)[cell viewWithTag:2000];
        UILabel *nameL = (UILabel *)[cell viewWithTag:2001];
        UILabel *priceL = (UILabel *)[cell viewWithTag:2002];
        UILabel *markPL = (UILabel *)[cell viewWithTag:2003];
        NSString *img_url = [NSString stringWithFormat:MyURL,goodDic[@"goods_imgs"]];
        [imgView sd_setImageWithURL:[NSURL URLWithString:img_url] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
        nameL.text = goodDic[@"goods_name"];
        NSString *pricestr = [NSString stringWithFormat:@"¥%@",goodDic[@"goods_price"]];
        priceL.text = pricestr;
        NSString *markpricestr = [NSString stringWithFormat:@"¥%@",goodDic[@"goods_marke_price"]];
        markPL.text = markpricestr;
        return cell;
    }
    if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell" forIndexPath:indexPath];
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:2000];
        nameLabel.text = _orderDic[@"order_consignee"];
        
        UILabel *phoneLabel = (UILabel *)[cell viewWithTag:2001];
        phoneLabel.text = _orderDic[@"order_tel"];
        
        UILabel *addressLabel = (UILabel *)[cell viewWithTag:2002];
        addressLabel.text = _orderDic[@"order_address"];
        return cell;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 170;
    }if (indexPath.section ==1) {
        return 110;
    }if (indexPath.section ==2) {
        return 70;
    }
    return 0;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;{
    if (section == 1) {
        UIView *v  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
        v.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 9, WIDTH-20, 21)];
        titleLabel.text = @"商品列表";
        titleLabel.backgroundColor = [UIColor clearColor];
        [v addSubview:titleLabel];
        return v;
    }if (section == 2) {
        UIView *v  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
         v.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 9, WIDTH-20, 21)];
        titleLabel.text = @"收货信息";
        titleLabel.backgroundColor = [UIColor clearColor];
        [v addSubview:titleLabel];
        return v;
        NSLog(@"aaaaaaaaa");
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   if (section == 1) {
        return 30;
    }if (section == 2) {
        return 30;
    }
    return 0;
}


//待发货按钮 点击事件
- (IBAction)butClick:(UIButton *)sender {
}

@end
