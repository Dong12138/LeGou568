//
//  TableViewController.m
//  Lg
//
//  Created by echo21 on 15/10/14.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic,assign) int flag;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 100;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // self.view.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableViewReloadData{
    [self getData];
}
-(void)getData{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    __weak typeof(self)myself = self;
    dispatch_async(dispatch_queue_create("lg.com", 0), ^{
        [HttpTools getWithURL:_type_link params:nil success:^(id json) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            myself.listInfoArr = dic[@"listInfo"];
            if (myself.listInfoArr.count != 0) {
                myself.flag = 1;
            }else{
                [FVCustomAlertView showDefaultWarningAlertOnView:myself.view withTitle:@"暂无数据,请稍后再试"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData ];
                [SVProgressHUD dismiss];
            });
        } failure:^(NSError *error) {
            NSLog(@"error == %@",error.description);
        }];
        
    });
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
//    if (_listInfoArr.count == 0) {
//        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"暂无数据,请稍后再试"];
//    }
    return _listInfoArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = _listInfoArr[indexPath.row];
    //imageView
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 80, 80)];
    NSString *str = [NSString stringWithFormat:MyURL,dic[@"info_imgs"]];
    [imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
    
    //商品名称
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 8, WIDTH-104, 21)];
    nameLabel.font = [UIFont systemFontOfSize:15.0];
    nameLabel.text = dic[@"info_title"];
    
    //商品地址
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 37,  WIDTH-104, 21)];
    addressLabel.font = [UIFont systemFontOfSize:14.0];
    addressLabel.textColor = [UIColor groupTableViewBackgroundColor];
    
    if ([dic[@"info_type"] isEqualToString:@"1"]) {
         addressLabel.text = dic[@"info_home_address"];
    }else{
        addressLabel.text = dic[@"info_job_position"];
    }
   
    
    //商品价格
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, 66, 150, 21)];
    priceLabel.textColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:235/255.0 alpha:1.0];
    priceLabel.font = [UIFont systemFontOfSize:14.0];
    NSString *priceStr ;
    if ([dic[@"info_type"] isEqualToString:@"1"]) {
        priceStr = [NSString stringWithFormat:@"¥%@",dic[@"info_money"]];
    }else{
        priceStr = [NSString stringWithFormat:@"¥%@",dic[@"info_job_salary"]];
    }
    
    priceLabel.text = priceStr;
    
    //商品发布时间
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-108, 66, 100, 21)];
    timeLabel.textColor = [UIColor groupTableViewBackgroundColor];
    timeLabel.font = [UIFont systemFontOfSize:14.0];
    NSString *timeStr = dic[@"info_addtime"];
    timeStr = [timeStr substringToIndex:10];
    timeLabel.text = timeStr;
    if (indexPath.row !=0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(8, 0, WIDTH-16, 5)];
        
        view.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
        [cell.contentView addSubview:view];
    }
    [cell addSubview:imgView];
    [cell addSubview:nameLabel];
    [cell addSubview:addressLabel];
    [cell addSubview:priceLabel];
    [cell addSubview:timeLabel];
    //Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegeta respondsToSelector:@selector(callBack::)]) {
        NSDictionary *dic = _listInfoArr[indexPath.row];
        [_delegeta callBack:dic[@"info_link"] :_index ];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
