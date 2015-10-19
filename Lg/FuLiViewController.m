//
//  FuLiViewController.m
//  Lg
//
//  Created by echo21 on 15/10/13.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "FuLiViewController.h"

@interface FuLiViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *fuliArr;
@end

@implementation FuLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fuliArr = [NSMutableArray array];
    _tableView.rowHeight = 30;
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getData{
    NSString *str = @"http://www.lg568.com/index.php/Home/APIinfo/addInfoconfig/";
    [SVProgressHUD showWithStatus:@"正在加载.."];
    dispatch_async(dispatch_queue_create("lg.com", 0), ^{
        __weak typeof(self)myself = self;
        [HttpTools postWithURL:str params:_dic success:^(id responseObject) {
           // NSLog(@"dic == %@",_dic);
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            for(NSDictionary *dic in arr){
                [myself.fuliArr addObject:dic];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [myself.tableView reloadData];
                [SVProgressHUD dismiss];
            });
        } failure:^(NSError *error) {
            NSLog(@"error == %@",error.description);
        }];

    });
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
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<_fuliArr.count; i++) {
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        UIButton *but = (UIButton *)[cell viewWithTag:3000];
        if (but.selected) {
            UILabel *label = (UILabel *)[cell viewWithTag:2000];
            NSString *str = label.text;
            [arr addObject:str];
        }
    }
    if (arr.count == 0) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"请先选择"];
    }else{
        if ([_delegete respondsToSelector:@selector(callBack:)]) {
            [_delegete callBack:arr];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    NSLog(@"OK");
}


#pragma mark tableView_代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_fuliArr.count == 0) {
        return 0;
    }
    return _fuliArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic = _fuliArr[indexPath.row];
    UILabel *label = (UILabel *)[cell viewWithTag:2000];
    label.text = dic[@"name"];
    //[but setTitle:dic[@"name"] forState:UIControlStateNormal];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIButton *but = (UIButton *)[cell viewWithTag:3000];
    but.selected = !but.selected;
}

@end
