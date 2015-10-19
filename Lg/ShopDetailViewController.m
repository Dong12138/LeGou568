//
//  ShopDetailViewController.m
//  Lg
//
//  Created by echo21 on 15/9/29.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ShopDetailModel.h"
#import "ProductModel.h"
#import "FVCustomAlertView.h"
#import "LoginViewController.h"
#import "CommentViewController.h"
#import "UserMpdel.h"
#import "AddCommentViewController.h"
#import "ReportViewController.h"
@interface ShopDetailViewController ()
@property (nonatomic,strong) ShopDetailModel *shop;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *shopDetailArr;
@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shopDetailArr = [NSMutableArray array];
    [self getShopData];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    //[backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"top_backbtn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//设置背景图片
    
    self.navigationItem.backBarButtonItem = backItem;

    ////self.title = _shop.company_name;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getShopData{
    NSString *url = [NSString stringWithFormat:@"http://www.lg568.com%@%@",@"/index.php/Home/API/content_company/company_id/",_company_id];
    //NSLog(@"%@",url);
    //更改navigation中title的颜色
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dicc;
    [SVProgressHUD showWithStatus:@"正在加载.."];
    __weak typeof(self)myself = self;
    //NSDictionary *dic = @{@"pragma":_company_id};
    dispatch_async(dispatch_queue_create("www.Lg.com", 0), ^{
        [HttpTools getWithURL:url params:nil success:^(id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //NSLog(@"dic == %@",dic);
            myself.shop = [[ShopDetailModel alloc]init];
            [myself.shop setDetailValue:dic];
            //[myself.shopDetailArr addObject:myself.shop];
            [myself.collectionView reloadData];
            myself.title = myself.shop.company_name;
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"error == %@",error.description);
            });
            
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    if (section<3) {
    //        return 1;
    //    }else{
    //        return 0;
    //    }
    NSArray *productArr = _shop.company_pro;
    return 6+productArr.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstCell" forIndexPath:indexPath];
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:30];
        UILabel *addLabel = (UILabel *)[cell viewWithTag:31];
        nameLabel.text = _shop.company_name;
        addLabel.text = _shop.company_address;
        return cell;
    }
    if (indexPath.row == 1) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"secCell" forIndexPath:indexPath];
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:20];
        NSString *contactStr = @"";
        if (_shop.company_contact.length !=0) {
            contactStr = [NSString stringWithFormat:@"%@:",_shop.company_contact];
            if (_shop.company_tel.length != 0) {
                contactStr = [NSString stringWithFormat:@"%@ %@",contactStr,_shop.company_tel];
            }
        }
        
        
        nameLabel.text = contactStr;
        UIButton *telBut = (UIButton *)[cell viewWithTag:21];
        [telBut addTarget:self action:@selector(telButClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    if (indexPath.row == 2) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"thirdCell" forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.row == 3) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fourthCell" forIndexPath:indexPath];
        if (![_shop.company_about isKindOfClass:[NSNull class]]) {
            UILabel *companyAboutLabel = (UILabel *)[cell viewWithTag:20];
            companyAboutLabel.text =[NSString stringWithFormat:@"      %@", _shop.company_about];
        }
        
        return cell;
    }
    if (indexPath.row == 4) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fifthCell" forIndexPath:indexPath];
        UIButton *videoBut = (UIButton *)[cell viewWithTag:21];
        NSString *video = _shop.company_video;
        if (video.length == 0) {
            [videoBut setTitle:@"无视频" forState:UIControlStateNormal];
           
        }else{
            [videoBut setTitle:@"视频" forState:UIControlStateNormal];
//            [videoBut addTarget:self action:@selector(videoButClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        [videoBut addTarget:self action:@selector(noVideoClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    if (indexPath.row == 5) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sevenCell" forIndexPath:indexPath];
        return cell;
    }
    
    
    if (indexPath.row > 5) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sixCell" forIndexPath:indexPath];
        NSArray *productArr = _shop.company_pro;
        if (productArr.count == 0) {
            return nil;
        }
        ProductModel *product = [[ProductModel alloc]init];
        [product setProductModelValue:productArr[indexPath.row-5]];
        UIImageView *imgView = (UIImageView *)[cell viewWithTag:20];
        UILabel *P_nameLabel = (UILabel *)[cell viewWithTag:21];
        UILabel *P_aboutLabel = (UILabel *)[cell viewWithTag: 22];
        UILabel *P_remarLabel = (UILabel *)[cell viewWithTag:23];
        NSString *P_imgUrl = [NSString stringWithFormat:MyURL,product.company_pro_imgsrc];
        [imgView sd_setImageWithURL:[NSURL URLWithString:P_imgUrl] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
        P_nameLabel.text = product.company_pro_title;
        P_aboutLabel.text = product.company_pro_content;
        P_remarLabel.text = product.company_pro_remarks;
        return cell;
    }
    return nil;
}
//有视频按钮事件
-(void)videoButClick:(UIButton *)but{
    NSLog(@"aaaaa");
}
//无视频是按钮事件
-(void)noVideoClick:(UIButton *)but{
    if ([but.currentTitle isEqualToString:@"无视频"]) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"暂无视频"];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_shop.company_video]];
    }
    
}
//打电话按钮事件
-(void)telButClick:(UIButton *)but{
        if (_shop.company_tel.length == 0) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"暂无电话"];
    }else {
        NSString *tell = _shop.company_tel;
        tell = [NSString stringWithFormat:@"tel://%@",_shop.company_tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tell]];
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        UIScrollView *scrollView = (UIScrollView *)[header viewWithTag:20];
        scrollView.contentSize = CGSizeMake(0, 0);
        if (indexPath.section ==0) {
            NSString *imgStr = _shop.company_imgs;
            UILabel * label = (UILabel *)[header viewWithTag:21];
            label.text = @"商家信息";
            UIButton *button = (UIButton *)[header viewWithTag:22];
            button.enabled = NO;
            if (_shop.company_hits.length == 0) {
                [button setTitle:[NSString stringWithFormat:@"0人浏览"] forState:UIControlStateDisabled];
            }else{
                [button setTitle:[NSString stringWithFormat:@"%@人浏览",_shop.company_hits] forState:UIControlStateDisabled];
            }
            
            //判断字符串是否为空
            if ([imgStr isKindOfClass:[NSNull class]]) {
                scrollView.contentSize = CGSizeMake(WIDTH, 150);
                UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
                imgv.backgroundColor = [UIColor whiteColor];
                imgv.image = [UIImage imageNamed:@"net_error_icon.png"];;
                [scrollView addSubview:imgv];
                return header;
            }else{
                NSArray *imgArr = [imgStr componentsSeparatedByString:@","];
                scrollView.contentSize = CGSizeMake(WIDTH*imgArr.count, 150);
                for (int i = 0; i<imgArr.count; i++) {
                    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.frame.size.height)];
                    imgView.backgroundColor = [UIColor whiteColor];
                    NSString *img_url = [NSString stringWithFormat:MyURL,imgArr[i ]];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:img_url] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
                    [scrollView addSubview:imgView];
                }
                return header;
                
            }
        }
        
    }
    return nil;
}
//设置Header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(WIDTH, 200);
    }
    //    if (section == 1) {
    //        return CGSizeZero;
    //    }
    return CGSizeZero;
    
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return CGSizeMake(WIDTH, 75);
    }
   
    if (indexPath.row == 3) {
        CGFloat height = [LZXHelper textHeightFromTextString:_shop.company_about width:WIDTH fontSize:19.0];
        if (height<50) {
            return CGSizeMake(WIDTH, 50);
        }
        return CGSizeMake(WIDTH, height);
    }if (indexPath.row > 5) {
        return CGSizeMake(WIDTH, 130);
    }
    return CGSizeMake(WIDTH, 50);
}
//写评论按钮点击事件
- (IBAction)editBarClick:(UIBarButtonItem *)sender {
    //判断用户是否登录
    UserMpdel *user = [LZXHelper IsLogin];
    if (user) {
        AddCommentViewController *addCommentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCommentViewController"];
        addCommentVC.user = user;
        addCommentVC.company_id = _shop.company_id;
        [self.navigationController pushViewController:addCommentVC animated:YES];
        NSLog(@"已经登录");
    }else{
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES ];
    }
    
}
//查看评论点击事件
- (IBAction)recommandBarClick:(UIBarButtonItem *)sender {
    NSArray *commentArr = _shop.company_comment;
    CommentViewController *commentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentViewController"];
    commentVC.commentArr = commentArr;
    commentVC.company_id = _shop.company_id;
    [self.navigationController pushViewController:commentVC animated:YES];
}
//分享按钮点击事件
- (IBAction)shareBarClick:(UIBarButtonItem *)sender {
    NSLog(@"分享");
}
//举报按钮点击事件
- (IBAction)jubaoBarClick:(UIBarButtonItem *)sender {
    UserMpdel *user = [LZXHelper IsLogin];
    if (user) {
        ReportViewController *reportVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportViewController"];
        NSDictionary *userInfo = user.userinfo;
        reportVC.user_id = userInfo[@"user_id"];
        reportVC.company_id = _shop.company_id;
        [self.navigationController pushViewController:reportVC animated:YES];
    }else{
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES ];
    }
    
    //NSLog(@"举报");
}

@end
