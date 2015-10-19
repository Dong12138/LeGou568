//
//  CommentViewController.m
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentModel.h"
#import "FVCustomAlertView.h"
#import "ShopDetailModel.h"
@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *muCommentArr;
@property (nonatomic,strong) ShopDetailModel*shop;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getShopData];
    
    // Do any additional setup after loading the view.
    _tableview.tableFooterView = [[UIView alloc]init];
    
}
-(void)getData{
    _muCommentArr = [NSMutableArray array];
    for (NSDictionary *dic in _commentArr) {
        CommentModel *comment = [[CommentModel alloc]init];
        [comment setCommentModelValue:dic];
        [_muCommentArr addObject:comment];
    }
}
-(void)getShopData{
    _muCommentArr = [NSMutableArray array];
    NSString *url = [NSString stringWithFormat:@"http://www.lg568.com%@%@",@"/index.php/Home/API/content_company/company_id/",_company_id];
    //NSLog(@"%@",url);
    //更改navigation中title的颜色
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dicc;
    //[SVProgressHUD showWithStatus:@"正在加载.."];
    __weak typeof(self)myself = self;
    __block NSArray *arr = [NSArray array];
    __block NSDictionary *subDic = [[NSDictionary alloc]init];
    //NSDictionary *dic = @{@"pragma":_company_id};
    dispatch_async(dispatch_queue_create("www.Lg.com", 0), ^{
        [HttpTools getWithURL:url params:nil success:^(id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //NSLog(@"dic == %@",dic);
            myself.shop = [[ShopDetailModel alloc]init];
            [myself.shop setDetailValue:dic];
            //[myself.shopDetailArr addObject:myself.shop];
            arr = myself.shop.company_comment;
            for(subDic in arr){
                CommentModel *comment = [[CommentModel alloc]init];
                [comment setCommentModelValue:subDic];
                [myself.muCommentArr addObject:comment];
            }
            if (myself.muCommentArr.count == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"还没有评论哦亲!快去评论吧~"];
                });
            }
            [myself.tableview reloadData];
            //[SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"error == %@",error.description);
            });
            
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
#pragma mark Tableview_代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_muCommentArr.count == 0) {
        
        return 0;
    }
    return _muCommentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *comment = _muCommentArr[indexPath.row];
    NSString *timeStr = comment.comment_addtime;
    timeStr = [timeStr substringWithRange:NSMakeRange(5, 5)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *userNameLabel = (UILabel *)[cell viewWithTag:20];
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:21];
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:22];
    userNameLabel.text = comment.user_name;
    timeLabel.text = timeStr;
    contentLabel.text = comment.comment_content;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *comment = _muCommentArr[indexPath.row];
    CGFloat height = [LZXHelper textHeightFromTextString:comment.comment_content width:tableView.frame.size.width fontSize:18.0];
    return height+65;
}
@end
