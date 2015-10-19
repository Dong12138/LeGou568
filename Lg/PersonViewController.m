//
//  PersonViewController.m
//  Lg
//
//  Created by echo21 on 15/10/15.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "PersonViewController.h"
#import "UserMpdel.h"
#import "UserInfoModel.h"
#import "PersonInfoSettingViewController.h"
#import "LoginViewController.h"
#import "MyOrderViewController.h"
@interface PersonViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *imgArr;
@property (nonatomic,strong) UserMpdel *user;
@property (nonatomic,strong) NSArray *strArr;
@end

@implementation PersonViewController

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
    
    self.title = @"个人中心";
    UIButton *noticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noticeButton setBackgroundImage:[UIImage imageNamed:@"notice.png"] forState:UIControlStateNormal];
    [noticeButton addTarget:self action:@selector(noticeButClick:) forControlEvents:UIControlEventTouchUpInside];
    noticeButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:noticeButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    _imgArr = @[@"grzx_icon1.png",@"grzx_icon5.png",@"grzx_icon6.png",@"grzx_icon3.png",@"icon_shoucang.png",@"grzx_icon4.png"];
    _strArr = @[@"订单管理",@"我的账单",@"我的购物车",@"我的店铺",@"我的收藏",@"浏览信息"];
    // Do any additional setup after loading the view.
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    _user = [LZXHelper IsLogin];
    if (_user) {
        _tableview.tableHeaderView = [self headerView];
    }else{
        _tableview.tableHeaderView = [self addHeaderView];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//注意按钮  点击事件
-(void)noticeButClick:(UIButton *)but{
    
}

//已经登陆的 header
-(UIView *)headerView{
    UserInfoModel *info = [[UserInfoModel alloc]init];
    [info setUserInfoValue:_user.userinfo];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    v.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    imgView.image = [UIImage imageNamed:@"grzx_topbg.png"];
    
    UILabel *nihaoL = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, 40, 21)];
    nihaoL.text = @"你好:";
    nihaoL.font = [UIFont systemFontOfSize:14.0];
    nihaoL.backgroundColor = [UIColor clearColor];
    
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(63, 30, 100, 21)];
    nameL.text = info.user_name;
    nameL.font = [UIFont systemFontOfSize:14.0];
    nameL.backgroundColor = [UIColor clearColor];
    
    UIButton *personBut = [UIButton buttonWithType:UIButtonTypeCustom];
    personBut.frame = CGRectMake(WIDTH-108, 30, 100, 21);
    personBut.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [personBut setTitle:@"个人资料" forState:UIControlStateNormal];
    [personBut setFont:[UIFont systemFontOfSize:14.0]];
    [personBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [personBut addTarget:self action:@selector(personButClick:) forControlEvents:UIControlEventTouchUpInside];
    personBut.layer.masksToBounds = YES;
    personBut.layer.cornerRadius = 5;

    
    UILabel *jifenL = [[UILabel alloc]initWithFrame:CGRectMake(15, 59, 70, 21)];
    jifenL.text = @"累计积分";
    jifenL.font = [UIFont systemFontOfSize:14.0];
    jifenL.backgroundColor = [UIColor clearColor];
    
    UILabel *zhiLabel = [[UILabel alloc]initWithFrame:CGRectMake(88, 59, 30, 21)];
    zhiLabel.text = info.user_integral;
    zhiLabel.font = [UIFont systemFontOfSize:14.0];
    zhiLabel.textColor = [UIColor redColor];
    zhiLabel.backgroundColor = [UIColor clearColor];
    
    UIButton *vipBut = [UIButton buttonWithType:UIButtonTypeCustom];
    vipBut.frame = CGRectMake(126, 59, 30, 21);
    [vipBut setTitle:info.vip forState:UIControlStateNormal];
    [vipBut setBackgroundColor:[UIColor redColor]];
    [vipBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vipBut setFont:[UIFont systemFontOfSize:14.0]];
    vipBut.layer.masksToBounds = YES;
    vipBut.layer.cornerRadius = 5;
    
    UILabel *jibieLa = [[UILabel alloc]initWithFrame:CGRectMake(15, 88, 150, 21)];
    jibieLa.text = info.next_integral;
    jibieLa.font = [UIFont systemFontOfSize:14.0];
    jibieLa.backgroundColor = [UIColor clearColor];
    
    UIButton *jibieBut = [UIButton buttonWithType:UIButtonTypeCustom];
    jibieBut.frame = CGRectMake(WIDTH-108, 88, 100, 21);
    jibieBut.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [jibieBut setTitle:@"等级说明" forState:UIControlStateNormal];
    [jibieBut setFont:[UIFont systemFontOfSize:14.0]];
    [jibieBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jibieBut addTarget:self action:@selector(jibieButClick:) forControlEvents:UIControlEventTouchUpInside];
    jibieBut.layer.masksToBounds = YES;
    jibieBut.layer.cornerRadius = 5;
    
    
    [v addSubview:imgView];
    [v addSubview:nihaoL];
    [v addSubview:nameL];
    [v addSubview:jifenL];
    [v addSubview:zhiLabel];
    [v addSubview:vipBut];
    [v addSubview:jibieLa];
    [v addSubview:personBut];
    [v addSubview:jibieBut];
    //[v addSubview:label];
    return v;
}
//个人资料按钮 点击事件
-(void)personButClick:(UIButton *)but{
    UserInfoModel *info1 = [[UserInfoModel alloc]init];
    [info1 setUserInfoValue:_user.userinfo];

    PersonInfoSettingViewController *infoSettingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonInfoSettingViewController"];
    infoSettingVC.info = info1;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:infoSettingVC animated:self];
}
//等级说明按钮 点击事件
-(void)jibieButClick:(UIButton *)but{
    
}
//未登录 的header
-(UIView *)addHeaderView{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    v.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    imgView.image = [UIImage imageNamed:@"grzx_topbg.png"];
    
    UIButton *loginBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBut addTarget:self action:@selector(loginButClick:) forControlEvents:UIControlEventTouchUpInside];
    loginBut.frame = CGRectMake((WIDTH-100)/2.0, 30, 100, 40);
    loginBut.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [loginBut setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBut setFont:[UIFont systemFontOfSize:15.0]];
    [loginBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBut.layer.masksToBounds = YES;
    loginBut.layer.cornerRadius = 5;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-100)/2.0, 88, 100, 24)];
    label.text = @"您还没有登陆";
    label.font = [UIFont systemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    
    [v addSubview:imgView];
    [v addSubview:loginBut];
    [v addSubview:label];
    return v;

}
//登陆按钮   点击事件
-(void)loginButClick:(UIButton *)but{
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark tableview_代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        UIImageView *imgView = (UIImageView *)[cell viewWithTag:2000];
        UILabel *label = (UILabel *)[cell viewWithTag:2001];
        imgView.image = [UIImage imageNamed:_imgArr[indexPath.row]];
        label.text = _strArr[indexPath.row];
        return cell;
    }if(indexPath.section == 1){
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secCell" forIndexPath:indexPath];
            UIImageView *imgView = (UIImageView *)[cell viewWithTag:2000];
            UILabel *label = (UILabel *)[cell viewWithTag:2001];
            UIButton *but = (UIButton *)[cell viewWithTag:2002];
            imgView.image = [UIImage imageNamed:_imgArr[indexPath.row+3]];
            label.text = _strArr[indexPath.row+3];
            [but setTitle:@"申请店铺" forState:UIControlStateNormal];
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
            UIImageView *imgView = (UIImageView *)[cell viewWithTag:2000];
            UILabel *label = (UILabel *)[cell viewWithTag:2001];
            imgView.image = [UIImage imageNamed:_imgArr[indexPath.row+3]];
            label.text = _strArr[indexPath.row+3];
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfoModel *info = [[UserInfoModel alloc]init];
    [info setUserInfoValue:_user.userinfo];
    UserMpdel *user = [LZXHelper IsLogin];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            if (user == nil) {
                LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                [self.navigationController pushViewController:loginVC animated:YES];
            }
            else{
            MyOrderViewController *myOrderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyOrderViewController"];
            myOrderVC.user_id = info.user_id;
            self.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:myOrderVC animated:YES];
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"订单管理";
    }else{
        return @"其他";
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
@end
