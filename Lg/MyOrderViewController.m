//
//  MyOrderViewController.m
//  Lg
//
//  Created by echo21 on 15/10/16.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderDetailViewController.h"
#import "LoginViewController.h"
@interface MyOrderViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *orderArr;
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    //[backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"top_backbtn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//设置背景图片
    self.navigationItem.backBarButtonItem = backItem;
    // Do any additional setup after loading the view.
    
    
    _tableview.tableFooterView = [[UIView alloc]init];
    _orderArr = [NSMutableArray array];
    [self getOrderData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getOrderData{
    NSString *order_url = @"http://www.lg568.com/index.php/Home/APIuser/listorder/";
    NSDictionary *dic = @{
                          @"user_id":_user_id
                          };
    __weak typeof(self)myself = self;
    [SVProgressHUD show];
    [HttpTools postWithURL:order_url params:dic success:^(id responseObject) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (arr.count!=0) {
            for (NSDictionary *dic in arr) {
                [myself.orderArr addObject:dic];
            }
            [myself.tableview reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD dismiss];
            [FVCustomAlertView showDefaultWarningAlertOnView:myself.view withTitle:@"暂无数据"];
        }
        
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


#pragma mark Tableview_代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _orderArr[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *order_snL = (UILabel *)[cell viewWithTag:2000];
    order_snL.text = @"订单号";
    UILabel *order_snL1 = (UILabel *)[cell viewWithTag:2001];
    order_snL1.text = dic[@"order_sn"];
    
    UILabel *order_amountL = (UILabel *)[cell viewWithTag:2002];
    order_amountL.text = @"订单金额";
    UILabel *order_amountL1 = (UILabel *)[cell viewWithTag:2003];
    order_amountL1.text =dic[@"order_amount"];
    
    UILabel *order_edittimeL = (UILabel *)[cell viewWithTag:2004];
    order_edittimeL.text = @"下单时间";
    UILabel *order_edittimeL1 = (UILabel *)[cell viewWithTag:2005];
    order_edittimeL1.text = dic[@"order_edittime"];
    
    UIButton *pay_stautsBut = (UIButton *)[cell viewWithTag:2006];
    [pay_stautsBut setTitle:dic[@"order_status_text"] forState:UIControlStateNormal];
    pay_stautsBut.layer.borderColor = pay_stautsBut.titleLabel.textColor.CGColor;
    pay_stautsBut.layer.borderWidth = 1.0;
   // [pay_stautsBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [pay_stautsBut addTarget:self action:@selector(pay_stautsButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancleOrderBut = (UIButton *)[cell viewWithTag:2007];
    [cancleOrderBut setTitle:@"取消订单" forState:UIControlStateNormal];
    cancleOrderBut.layer.borderColor = cancleOrderBut.titleLabel.textColor.CGColor;
    cancleOrderBut.layer.borderWidth = 1.0;
    //[cancleOrderBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancleOrderBut addTarget:self action:@selector(cancleOrderButClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserMpdel *user = [LZXHelper IsLogin];
    if (user == nil) {
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else{
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UILabel *snLabel = (UILabel *)[cell viewWithTag:2001];
        OrderDetailViewController *orderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderDetailViewController"];
        orderVC.order_sn = snLabel.text;
        [self.navigationController pushViewController:orderVC animated:YES];
    
    
    }

}


//支付状态按钮 点击事件
-(void)pay_stautsButClick:(UIButton *)but{
    
}
//取消订单按钮 点击事
-(void)cancleOrderButClick:(UIButton *)but{
    
}
@end
