//
//  AddCommentViewController.m
//  Lg
//
//  Created by echo21 on 15/10/7.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "AddCommentViewController.h"
#import "UserInfoModel.h"
@interface AddCommentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AddCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //_textView.p
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
//提交评论事件
- (IBAction)addCommentButClick:(id)sender {
    if (_textView.text.length == 0) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"请输入评论"];
        return;
    }
    UserInfoModel *info = [[UserInfoModel alloc]init];
    [info setUserInfoValue:_user.userinfo];
    NSString *user_id = info.user_id;
    NSString *company_id = _company_id;
    NSString *comment = _textView.text;
    //创建
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    //添加字典
    [dictionary setObject:user_id forKey:@"user_id"];
    [dictionary setObject:company_id forKey:@"company_id"];
    [dictionary setObject:comment forKey:@"comment_content"];
    NSString *url = [NSString stringWithFormat:MyURL,@"/index.php/Home/API/add_comment"];
    __weak typeof(self)myself = self;
    [HttpTools postWithURL:url params:dictionary success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"status"]) {
            [myself.textView resignFirstResponder];
            [FVCustomAlertView showDefaultWarningAlertOnView: myself.view withTitle:@"评论成功"];
            double delay = 1.5;//设置延迟时间
            dispatch_time_t time= dispatch_time(DISPATCH_TIME_NOW, (int64_t)delay*NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{                    [myself.navigationController popViewControllerAnimated:YES];            });
        }
    } failure:^(NSError *error) {
        NSLog(@"error == %@",error.description);
    }];
}
#pragma mark TextView_代理
//实现textview的提示信息功能，先在textview下面加一个view，崽崽这个view上加一个label，当输入的时候将label隐藏，textview的length为0时，显示label
/*
 基本思路：
 完成按钮：检测到 \n 换行功能就释放键盘。
 placeholder功能：用一个label写了文字，然后当检测到长度不为0的时候就把label隐藏。 由于输入法有拼音，所以要加多个判断！！ adviceMsg为textviwe.
 */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {//检测到“完成”
        [textView resignFirstResponder];//释放键盘
        return NO;
    }
    if (_textView.text.length==0){//textview长度为0
        if ([text isEqualToString:@""]) {//判断是否为删除键
            _placeholderLabel.hidden=NO;//隐藏文字
        }else{
            _placeholderLabel.hidden=YES;
        }
    }else{//textview长度不为0
        if (_textView.text.length==1){//textview长度为1时候
            if ([text isEqualToString:@""]) {//判断是否为删除键
                _placeholderLabel.hidden=NO;
            }else{//不是删除
                _placeholderLabel.hidden=YES;
            }
            
        }else{//长度不为1时候
            _placeholderLabel.hidden=YES;
        }
    }
    return YES;
}
@end
