//
//  UpdateInfoViewController.m
//  Lg
//
//  Created by echo21 on 15/10/15.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "UpdateInfoViewController.h"

@interface UpdateInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation UpdateInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_flag == 0) {
        _tf.placeholder = _str;
    }else{
        _tf.text = _str;
    }
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
- (IBAction)OKButClick:(UIButton *)sender {
    if (_tf.text.length == 0) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"请输入信息"];
    }else{
        if ([_delegeta respondsToSelector:@selector(callBack::)]) {
            [_delegeta callBack:_row :_tf.text];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
           NSLog(@"错误");
        }
        
    }
    
}

@end
