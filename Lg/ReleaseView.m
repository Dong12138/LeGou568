//
//  ReleaseView.m
//  Lg
//
//  Created by echo21 on 15/10/13.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "ReleaseView.h"
@interface ReleaseView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) int i ;
@end

@implementation ReleaseView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame :  (int)f {
    self = [super initWithFrame:frame];
    self.flag = f;
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        _tableview = [[UITableView alloc]init];
        //WithFrame:CGRectMake(20, 100, self.frame.size.width-40, self.frame.size.height-200)
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.rowHeight = 30;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableview];
         [self getData];
    }
    return self;
}
-(void)getData{
    NSString *fenleiUrl = @"http://www.lg568.com/index.php/Home/APIinfo/alltypeInfo";
    __weak typeof(self)myself = self;
    [HttpTools getWithURL:fenleiUrl params:nil success:^(id json) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        myself.fenleiDic = arr[myself.flag];
        dispatch_async(dispatch_get_main_queue(), ^{
            __block NSArray *arr = _fenleiDic[@"small_infp_type"];
            myself.tableview.frame = CGRectMake(30, (myself.frame.size.height-arr.count*30)/2, myself.frame.size.width-60, arr.count*30);
            //[myself.tableview reloadData];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"error == %@",error.description);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _fenleiDic[@"small_infp_type"];
    if (arr.count == 0) {
        return 0;
    }
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = _fenleiDic[@"small_infp_type"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = arr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = dic[@"info_type_name"];
    cell.font =[UIFont systemFontOfSize:14.0];
    cell.textColor =[UIColor colorWithRed:221/255.0 green:160/255.0 blue:221/255.0 alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    UILabel *label = [[UILabel alloc]initWithFrame:cell.frame];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = dic[@"info_type_name"];
//    label.font = [UIFont systemFontOfSize:14.0];
//    label.textColor = [UIColor colorWithRed:221/255.0 green:160/255.0 blue:221/255.0 alpha:1.0];
//    [cell addSubview:label];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidden = YES;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.textLabel.text;
    NSArray *arr = _fenleiDic[@"small_infp_type"];
    NSDictionary *subDic = arr[indexPath.row];
    NSString *info_type_id = subDic[@"info_type_id"];
    NSString *info_type_pid = subDic[@"info_type_pid"];
    NSDictionary *dic = @{
                          @"info_type_id":info_type_id,
                          @"info_type_pid":info_type_pid
                          };
    if ([_delegate respondsToSelector:@selector(callBack::)]) {
        [_delegate callBack:str :dic];
    }
}

@end
