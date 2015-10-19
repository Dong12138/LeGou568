//
//  ReportViewController.m
//  Lg
//
//  Created by echo21 on 15/10/9.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()
@property (nonatomic,strong) NSString *reportStr;
@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _reportStr = @"卖假货";
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
//卖假货 点击事件
- (IBAction)jiahuoButClick:(UIButton *)but {
    if (but.selected) {
        //but.selected = NO;
    }else{
        but.selected = YES;
        _reportStr = @"卖假货";
        UIView *v = (UIView*)but.superview;
        for (int i =0; i<v.subviews.count; i++) {
            if ([v.subviews[i] isKindOfClass:[UIButton class]]) {
                UIButton *otherBut = v.subviews[i] ;
                if(otherBut.tag != but.tag){
                    otherBut.selected = NO;
                }
            }
        }
    }
}
//卖过期货 点击事件
- (IBAction)overTimeButClick:(UIButton *)but {
    if (but.selected) {
        //but.selected = NO;
    }else{
        but.selected = YES;
        _reportStr = @"卖过期货物";
        UIView *v = (UIView*)but.superview;
        for (int i =0; i<v.subviews.count; i++) {
            if ([v.subviews[i] isKindOfClass:[UIButton class]]) {
                UIButton *otherBut = v.subviews[i] ;
                if(otherBut.tag != but.tag){
                    otherBut.selected = NO;
                }
            }
        }
    }
    
}
//服务态度不好 点击事件
- (IBAction)badServiceButClick:(UIButton *)but {
    if (but.selected) {
       // but.selected = NO;
    }else{
        but.selected = YES;
        _reportStr = @"服务态度不好";
        UIView *v = (UIView*)but.superview;
        for (int i =0; i<v.subviews.count; i++) {
            if ([v.subviews[i] isKindOfClass:[UIButton class]]) {
                UIButton *otherBut = v.subviews[i] ;
                if(otherBut.tag != but.tag){
                    otherBut.selected = NO;
                }
            }
        }
    }
    
}
//宰客 点击事件
- (IBAction)zaiKeButClick:(UIButton *)but {
    if (but.selected) {
       // but.selected = NO;
    }else{
        but.selected = YES;
        _reportStr = @"宰客";
        UIView *v = (UIView*)but.superview;
        for (int i =0; i<v.subviews.count; i++) {
            if ([v.subviews[i] isKindOfClass:[UIButton class]]) {
                UIButton *otherBut = v.subviews[i] ;
                if(otherBut.tag != but.tag){
                    otherBut.selected = NO;
                }
            }
        }
    }
    
}
//提交按钮 点击事件
- (IBAction)addReportButClick:(UIButton *)sender {
    NSString *addReportUrl = @"http://www.lg568.com/index.php/Home/API/add_report";
    NSDictionary *dic = @{
                          @"user_id":_user_id,
                          @"company_id":_company_id,
                          @"report_content":_reportStr,
                          };
    __weak typeof(self)myself = self;
    [HttpTools postWithURL:addReportUrl params:dic success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [FVCustomAlertView showDefaultWarningAlertOnView:myself.view withTitle:dic[@"content"]];
        double delay = 2.0;//设置延迟时间
        dispatch_time_t time= dispatch_time(DISPATCH_TIME_NOW, (int64_t)delay*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [FVCustomAlertView hideAlertFromView:myself.view fading:YES];
            [myself.navigationController popViewControllerAnimated:YES];
        });

    } failure:^(NSError *error) {
        NSLog(@"error == %@",error.description);
    }];
}

@end
