//
//  UpdatePwdViewController.m
//  Lg
//
//  Created by echo21 on 15/10/16.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "UpdatePwdViewController.h"

@interface UpdatePwdViewController ()
//旧密码
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTF;
//新密码
@property (weak, nonatomic) IBOutlet UITextField *NPwdTf;
//再次输入密码
@property (weak, nonatomic) IBOutlet UITextField *inputPwdAgin;

@end

@implementation UpdatePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dicc;
    
    self.title = @"修改密码";
    
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
//确定按钮 点击事件
- (IBAction)OKButClick:(UIButton *)sender {
//    if (![_oldPwdTF.text isEqualToString:_info.user_password]) {
//        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"旧密码输入错误"];
//        return;
//    }else{
//        if (![_NPwdTf.text isEqualToString:_inputPwdAgin.text]) {
//            [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"两次密码输入不一致"];
//            return;
//        }else{
//            if ([_NPwdTf.text isEqualToString:_oldPwdTF.text]) {
//                [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"旧密码与新密码相同"];
//            }else{
//                
//            }
//        }
//
//    }
    NSString *urlStr = @"http://www.lg568.com/index.php/Home/APIuser/updatepass";
    NSDictionary *dic = @{
                          @"user_id":_info.user_id,
                          @"oldpass":_oldPwdTF.text,
                          @"newpass":_NPwdTf.text,
                          @"newpass2":_inputPwdAgin.text
                          };
    __weak typeof(self)myself = self;
    dispatch_async(dispatch_queue_create("lg.com", 0), ^{
        [HttpTools postWithURL:urlStr params:dic success:^(id responseObject) {
            NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            [FVCustomAlertView showDefaultWarningAlertOnView:myself.view withTitle:dic[@"content"]];
            if ([dic[@"status"] isEqualToString:@"1"]) {
                double delay = 1.0;//设置延迟时间

                dispatch_time_t time= dispatch_time(DISPATCH_TIME_NOW, (int64_t)delay*NSEC_PER_SEC);
                dispatch_after(time, dispatch_get_main_queue(), ^{
                    [myself.navigationController popViewControllerAnimated:YES];
                });

            }
        } failure:^(NSError *error) {
            NSLog(@"error == %@",error.description);
        }];
    });
    
}

@end
