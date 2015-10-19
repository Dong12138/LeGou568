//
//  PersonInfoSettingViewController.m
//  Lg
//
//  Created by echo21 on 15/10/15.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "PersonInfoSettingViewController.h"
#import "UpdateInfoViewController.h"
#import "ZHPickView.h"
#import "UpdatePwdViewController.h"
#import "WCAlertView.h"
#import "UserMpdel.h"
@interface PersonInfoSettingViewController ()<UpdateInfoDelegate,UIActionSheetDelegate,ZHPickViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSArray *arr1;
@property(nonatomic,strong)ZHPickView *pickview;
@end

@implementation PersonInfoSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    //[backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"top_backbtn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//设置背景图片
    self.navigationItem.backBarButtonItem = backItem;

    
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dicc;
    
    self.title = @"个人中心";
    UIButton *OKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [OKButton setTitle:@"保存" forState:UIControlStateNormal];
    [OKButton setFont:[UIFont systemFontOfSize:15.0]];
    [OKButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [OKButton addTarget:self action:@selector(OKButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    OKButton.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:OKButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    _arr = @[@"用户名",@"性别",@"生日",@"手机号",@"QQ",@"地址",@"邮箱",@"备用号码",@"备用地址",];
    _arr1 = @[@"修改密码",@"安全退出"];
    _tableview.tableHeaderView = [self headerView];
    _tableview.tableFooterView = [[UIView alloc]init];
}
//保存按钮 点击事件
-(void)OKButtonClick:(UIButton *)but{
    NSArray *nameArr = @[@"user_id",@"user_name",@"user_sex",@"user_birthday",@"user_phone",@"user_qq",@"user_address",@"user_mail",@"user_phone2",@"user_address2"];
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i<_arr.count; i++) {
        UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        UILabel *label = (UILabel *)[cell viewWithTag:2001];
        [arr addObject:label.text];
    }
    for (int i = 0; i<arr.count; i++) {
        if (i == 0) {
            [dic setValue:_info.user_id forKey:nameArr[i]];
        }else{
            [dic setValue:arr[i-1] forKey:nameArr[i]];
        }
        
    }
    NSString *urlStr = @"http://www.lg568.com/index.php/Home/APIuser/updateinfo/";
    __weak typeof(self)myself = self;
    [SVProgressHUD show];
    dispatch_async(dispatch_queue_create("lg.com", 0), ^{
        [HttpTools postWithURL:urlStr params:dic success:^(id responseObject) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            [FVCustomAlertView showDefaultWarningAlertOnView:myself.view withTitle:resultDic[@"content"]];
            if (resultDic[@"status"]) {
                NSString *loginUrl = @"http://www.lg568.com/index.php/Home/APIuser/loginUser/";
                    
                    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
                    NSString *password = [userD objectForKey:@"password"] ;
                    NSDictionary *dic = @{
                                          @"user_phone":myself.info.user_phone,
                                          @"user_password":password
                                          };
                    [HttpTools postWithURL:loginUrl params:dic success:^(id responseObject) {
                        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        UserMpdel *user = [[UserMpdel alloc]init];
                        [user setUserValue:result];
                        //归档
                        //将user对象转化为NSData类型
                        [userD removeObjectForKey:@"user"];
                        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
                        //将当前用户粗存入本地
                        
                        [userD setObject:userData forKey:@"user"];
                        [SVProgressHUD dismiss];
                        //NSLog(@"登陆成功");
                        [self.navigationController popViewControllerAnimated:YES];
                    } failure:^(NSError *error) {
                        NSLog(@"error == %@",error.description);
                    }];

            
            }
        } failure:^(NSError *error) {
            NSLog(@"error == %@",error.description);
            
            
            
            
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

-(UIView *)headerView{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(8, 0, WIDTH-16, 30)];
    v.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 9, WIDTH-16, 21)];
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor lightGrayColor];
    label.backgroundColor = [UIColor clearColor];
    NSString *str = [NSString stringWithFormat:@"你好:%@",_info.user_name];
    label.text = str;
    [v addSubview:label];
    return v;
}
#pragma mark tableview_代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _arr.count;
    }else{
        return _arr1.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell viewWithTag:2000];
        UILabel *label1 = (UILabel *)[cell viewWithTag: 2001];
        label.text = _arr[indexPath.row];
        switch (indexPath.row) {
            case 0:
                label1.text = _info.user_name;
                break;
            case 1:
                if ([_info.user_sex isKindOfClass:[NSNull class]]) {
                    label1.text = @"请选择性别";
                }else{
                    label1.text = _info.user_sex;
                }
                break;
            case 2:
                if ([_info.user_birthday isKindOfClass:[NSNull class]]) {
                    label1.text = @"请选择生日";
                }else{
                    label1.text = _info.user_birthday;
                }
                break;
            case 3:
                if ([_info.user_phone isKindOfClass:[NSNull class]]) {
                    label1.text = @"请输入电话";
                }else{
                   label1.text = _info.user_phone;
                }
                break;
            case 4:
                if ([_info.user_qq isKindOfClass:[NSNull class]]) {
                    label1.text = @"请输入QQ";
                }else{
                    label1.text = _info.user_qq;
                }
                break;
            case 5:
                if ([_info.user_address isKindOfClass:[NSNull class]]) {
                    label1.text = @"请输入地址";
                }else{
                    label1.text = _info.user_address;
                }
                break;
            case 6:
                if ([_info.user_mail isKindOfClass:[NSNull class]]) {
                    label1.text = @"请输入邮箱";
                }else{
                    label1.text = _info.user_mail;
                }
                break;
            case 7:
                if ([_info.user_phone2 isKindOfClass:[NSNull class]]) {
                    label1.text = @"请输入备用电话";
                }else{
                   label1.text = _info.user_phone2;
                }
                break;
            case 8:
                if ([_info.user_address2 isKindOfClass:[NSNull class]]) {
                    label1.text = @"请输入备用地址";
                }else{
                    label1.text = _info.user_address2;
                }
                break;
            default:
                break;
        }
        return cell;

    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell viewWithTag:2000];
        label.text = _arr1[indexPath.row];
        UILabel *label1 = (UILabel *)[cell viewWithTag:2001];
        label1.text = @"  ";

        return cell;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else {
        return 25;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row!=1 && indexPath.row!=2) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UILabel *label = (UILabel *)[cell viewWithTag:2001];
            UpdateInfoViewController *updateVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdateInfoViewController"];
            updateVC.delegeta = self;
            updateVC.row = indexPath.row;
            updateVC.str = label.text;
            if ([label.text containsString:@"请"]) {
                updateVC.flag = 0;
            }
            else{
                updateVC.flag = 1;
            }
            [self.navigationController pushViewController:updateVC animated:YES];
        }
        //性别选择
        if (indexPath.row == 1) {
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"男" otherButtonTitles:@"女", nil];
            [sheet showInView:self.view];
        }if (indexPath.row == 2) {
            NSDate *date = [NSDate date];
            //NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
            //[_pickview initWithFrame:CGRectMake(0, 400, WIDTH, HEIGHT-400)];
            _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
            _pickview.delegate=self;
            
            [_pickview show];
        }

    }
        if (indexPath.section == 1 ) {
            if (indexPath.row == 0) {
                UpdatePwdViewController *updatePwdVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdatePwdViewController"];
                updatePwdVC.info = _info;
                [self.navigationController pushViewController:updatePwdVC animated:YES];
            }else{
                [WCAlertView showAlertWithTitle:@"提示" message:@"确定要退出当前登录么？" customizationBlock:^(WCAlertView *alertView) {
                    alertView.style = WCAlertViewStyleVioletHatched;
                } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
                    if (buttonIndex == 0) {
                        NSLog(@"Cancel");
                    } else {
                        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"退出登录"];
                        double delay = 1.0;//设置延迟时间
                        
                        dispatch_time_t time= dispatch_time(DISPATCH_TIME_NOW, (int64_t)delay*NSEC_PER_SEC);
                        dispatch_after(time, dispatch_get_main_queue(), ^{
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
                            [self.navigationController popViewControllerAnimated:YES];
                        });

                        
                    }

                } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
            }
    }
}


#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    UITableViewCell * cell=[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];;
    //cell.detailTextLabel.text=resultString;
    UILabel *label = (UILabel *)[cell viewWithTag:2001];
    label.text = [resultString substringToIndex:10];
}

#pragma mark ActionSheet_代理


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"取消"]) {
        return;
    }
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
    UILabel *label = (UILabel *)[cell viewWithTag:2001];
    label.text = [actionSheet buttonTitleAtIndex:buttonIndex];

//    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"男"]) {
//        
//        
//    }else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"拍照"]){
//        
//    }else{
//        return;
//    }
}

#pragma mark UpdateInfoViewController_回调代理

-(void)callBack:(long)row :(NSString *)infoStr{
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:row inSection:0]];
    UILabel *label = (UILabel *)[cell viewWithTag:2001];
    label.text = infoStr;
}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section == 1) {
//        return @"  ";  
//    }
//    return nil;
//}
@end
