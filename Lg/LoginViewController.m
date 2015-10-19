//
//  LoginViewController.m
//  Lg
//
//  Created by echo21 on 15/10/5.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPwdViewController.h"
#import "RegisterUserViewController.h"
#import "UserMpdel.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *userPwdTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    //[backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"top_backbtn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//设置背景图片
    
    self.navigationItem.backBarButtonItem = backItem;
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
//登陆事件
- (IBAction)loginButClick:(UIButton *)sender {
    if (_userNameTF.text.length == 0) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"请输入手机号"];
        return;
    }
    if (_userPwdTF.text.length == 0) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"请输入密码"];
        return;
    }
    NSString *user_name =_userNameTF.text;
    NSString *user_password = _userPwdTF.text;
    NSString *urlStr = [NSString stringWithFormat:@"http://www.lg568.com/index.php/Home/APIuser/loginUser/user_phone/%@/user_password/%@",user_name,user_password];
    __weak typeof(self)myself = self;
    dispatch_async(dispatch_queue_create("lg.com", 0), ^{
        [HttpTools getWithURL:urlStr params:nil success:^(id json) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"status"] intValue]) {
                UserMpdel *user = [[UserMpdel alloc]init];
                [user setUserValue:dic];
                //归档
                //将user对象转化为NSData类型
                NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
                //将当前用户粗存入本地
                NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
                [userD setObject:userData forKey:@"user"];
                [userD setObject:myself.userPwdTF.text forKey:@"password"];
                NSLog(@"登陆成功");
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [FVCustomAlertView showDefaultWarningAlertOnView:myself.view withTitle:@"手机号或密码错误"];
                });
            }
        } failure:^(NSError *error) {
            NSLog(@"error == %@",error.description);
        }];

    });
    }
//忘记密码
- (IBAction)forgetPWDClick:(UIButton *)sender {
    ForgetPwdViewController *forgetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPwdViewController"];
    [self.navigationController pushViewController:forgetVC animated:YES];
}
//新用户注册
- (IBAction)registerButClick:(UIButton *)sender {
    RegisterUserViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterUserViewController"];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

@end
