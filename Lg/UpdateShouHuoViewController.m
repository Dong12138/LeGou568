//
//  UpdateShouHuoViewController.m
//  Lg
//
//  Created by echo21 on 15/10/17.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "UpdateShouHuoViewController.h"

@interface UpdateShouHuoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *contactTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *remarkTF;

@end

@implementation UpdateShouHuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *name = _dic[@"user_name"];
    NSString *phone = _dic[@"user_phone"];
    NSString *address = _dic[@"user_address"];
    if (name.length !=0) {
        _contactTF.text = name;
        
    }if (phone.length != 0) {
        _phoneTF.text = phone;
    }if (address.length != 0) {
        _addressTF.text = address;
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
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}
- (IBAction)OKButClick:(UIButton *)sender {
    if (_contactTF.text.length == 0) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"请输入联系人姓名"];
        return;
    }else{
        if (_phoneTF.text.length == 0) {
            [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"请输入联系人电话"];
            return;
        }else{
            if (_addressTF.text.length == 0) {
                [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"请输入联系人地址"];
                return;
            }else{
                NSDictionary *dicc = @{
                                       @"name":_contactTF.text,
                                       @"phone":_phoneTF.text,
                                       @"address":_addressTF.text,
                                       @"remark":_remarkTF.text
                                       };
                if ([_delegate respondsToSelector:@selector(callback:)]) {
                    [_delegate callback:dicc];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
    }
}

@end
