//
//  FindDetailViewController.m
//  Lg
//
//  Created by echo21 on 15/10/12.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "FindDetailViewController.h"
#import "FindContentInfoModel.h"
@interface FindDetailViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *telNumLabel;
@property (nonatomic,strong) FindContentInfoModel *content;
@end

@implementation FindDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dicc;
    UIButton *shareBut = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBut.frame = CGRectMake(0, 0, 30, 30);
    [shareBut setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:shareBut];
    [shareBut addTarget:self action:@selector(shareButClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightBar;
    [self getFindDetailData];
    
    // Do any additional setup after loading the view.
}
//分享按钮事件
-(void)shareButClick:(UIButton *)but{
    NSLog(@"分享事件");
}
-(void)getFindDetailData{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    __weak typeof(self)myself = self;
    dispatch_async(dispatch_queue_create("lg.com", 0), ^{
        [HttpTools getWithURL:_info_link params:nil success:^(id json) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            myself.content = [[FindContentInfoModel alloc]init];
            [myself.content setFindContentValue:dic];
            [myself.collectionView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                myself.contactLabel.text = myself.content.info_contact;
                myself.telNumLabel.text = myself.content.info_tel;
                [SVProgressHUD dismiss];
            });
        } failure:^(NSError *error) {
            NSLog(@"error ==  %@",error.description);
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


#pragma mark CollectionView_代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_content == nil) {
        return 0;
    }
    if (_flag == 0) {
        return 4;
    }
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstCell" forIndexPath:indexPath];
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:2000];
        UILabel *countLabel = (UILabel *)[cell viewWithTag:2001];
        UILabel *priceLabel = (UILabel *)[cell viewWithTag: 2002];
        UILabel *timeLabel = (UILabel *)[cell viewWithTag:2003];
        nameLabel.text = _content.info_title;
        NSString *str = [NSString stringWithFormat:@"%@人浏览",_content.info_hits];
        countLabel.text = str;
        if (_flag == 0) {
            priceLabel.text = _content.info_home_price;
        }else{
            priceLabel.text = _content.info_job_salary;
        }
        NSString *timeStr = [NSString stringWithFormat:@"%@",_content.info_addtime];
        timeStr = [timeStr substringToIndex:10];
        timeLabel.text = timeStr;
        return cell;
    }
    if (indexPath.row == 1) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"secCell" forIndexPath:indexPath];
        UILabel *addressLabel = (UILabel *)[cell viewWithTag:2000];
        if (_flag == 0) {
            addressLabel.text = _content.info_home_address;
        }else{
            addressLabel.text = _content.info_job_position;
        }
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        
        if (_flag == 0) {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"thirdCell" forIndexPath:indexPath];
            NSArray *arr = _content.info_home_config_new;
            NSInteger i = arr.count%3 == 0 ? arr.count/3 : arr.count/3+1;
            for (int j = 0; j < i; j++) {
                NSInteger m = 3;
                if (j == i-1) {
                    m = arr.count%3 == 0 ? 3:arr.count%3;
                }
                for (int n = 0; n<m; n++) {
                    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(10+n*(WIDTH-20)/3, j*30+10, (WIDTH-20)/3, 30)];
                    // v.backgroundColor = [UIColor purpleColor];
                    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,10,10)];
                    imgView.image = [UIImage imageNamed:@"star.png"];
                    NSDictionary *dic = arr[j*3+n];
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 30)];
                    label.numberOfLines = 0;
                    label.text = dic[@"text"];
                    label.font = [UIFont systemFontOfSize:14.0];
                    [v addSubview:imgView];
                    [v addSubview:label];
                    [cell addSubview:v];
                }
            }
            return cell;
        }
        else{
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fourthCell" forIndexPath:indexPath];
            UILabel *nameLabel = (UILabel *)[cell viewWithTag:2000];
            UILabel *numPeolabel = (UILabel *)[cell viewWithTag:2001];
            UILabel *label = (UILabel *)[cell viewWithTag:2002];
            nameLabel.text = _content.info_job_companyname;
            NSString *str = [NSString stringWithFormat:@"%@人",_content.info_job_number];
            numPeolabel.text = str;
            label.text = _content.info_job_requirement;
            return cell;
        }
        
    }
    if (indexPath.row == 3) {
        if (_flag == 0) {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeAboutCell" forIndexPath:indexPath];
            UILabel *homeAboutLabel = (UILabel *)[cell viewWithTag:2000];
            homeAboutLabel.text = _content.info_home_explain;
            return cell;
        }
        else{
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"thirdCell" forIndexPath:indexPath];
            NSArray *arr = _content.info_job_weal_new;
            NSInteger i = arr.count%3 == 0 ? arr.count/3 : arr.count/3+1;
            for (int j = 0; j < i; j++) {
                NSInteger m = 3;
                if (j == i-1) {
                    m = arr.count%3 == 0 ? 3:arr.count%3;
                }
                for (int n = 0; n<m; n++) {
                    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(10+n*(WIDTH-20)/3, j*30+10, (WIDTH-20)/3, 30)];
                    // v.backgroundColor = [UIColor purpleColor];
                    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,10,10)];
                    imgView.image = [UIImage imageNamed:@"star.png"];
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 30)];
                    NSDictionary *dic = arr[j*3+n];
                    label.numberOfLines = 0;
                    label.text = dic[@"text"];
                    label.font = [UIFont systemFontOfSize:14.0];
                    [v addSubview:imgView];
                    [v addSubview:label];
                    [cell addSubview:v];
                }
            }
            return cell;
        }
    }
    if (indexPath.row == 4) {
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"companyAboutCell" forIndexPath:indexPath];
        UILabel *companyLabel = (UILabel *)[cell viewWithTag:2000];
        companyLabel.text = _content.info_job_companyintro;
        return cell;
        
    }
    return nil;
}
//_flag == 0 的时候是指点击房产类的子类，flag= 1是指点击招聘类子类
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return CGSizeMake(WIDTH,  78);
    }
    if (indexPath.row == 1) {
        return CGSizeMake(WIDTH, 40);
    }
    if (indexPath.row == 2) {
        if (_flag == 0) {
            NSArray *arr = _content.info_home_config_new;
            NSInteger i = arr.count%3 == 0 ? arr.count/3 : arr.count/3+1;
            return CGSizeMake(WIDTH, i*30+20);
        }else{
            CGFloat height = [LZXHelper textHeightFromTextString:_content.info_job_requirement width:WIDTH-40 fontSize:17.0];
            return CGSizeMake(WIDTH, height+40);
        }
    }
    if (indexPath.row == 3) {
        if (_flag == 0) {
            CGFloat height = [LZXHelper textHeightFromTextString:_content.info_home_explain width:WIDTH-16 fontSize:17.0];
            return CGSizeMake(WIDTH, height+50);
        }else{
            NSArray *arr = _content.info_job_weal_new;
            NSInteger i = arr.count%3 == 0 ? arr.count/3 : arr.count/3+1;
            return CGSizeMake(WIDTH, i*30+20);
        }
    }
    if (indexPath.row == 4) {
        CGFloat height = [LZXHelper textHeightFromTextString:_content.info_job_companyintro width:WIDTH-16 fontSize:18.0];
        return CGSizeMake(WIDTH, height+50);
    }
    return CGSizeZero;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        NSArray *arr = _content.info_imgs_new;
        UIScrollView *scrollView = (UIScrollView *)[header viewWithTag:2000];
        scrollView.contentSize = CGSizeMake(WIDTH*arr.count, 150);
        for (int i = 0; i<arr.count; i++) {
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.frame.size.height)];
            imgView.backgroundColor = [UIColor whiteColor];
            NSDictionary *dic = arr[i ];
            NSString *img_url = [NSString stringWithFormat:MyURL,dic[@"img"]];
            [imgView sd_setImageWithURL:[NSURL URLWithString:img_url] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
            [scrollView addSubview:imgView];
        }
        return header;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 500)];
        v.backgroundColor = [UIColor whiteColor];
        [footer addSubview:v];
        return footer;
    }
    return nil;
}
//发短信 点击事件
- (IBAction)sendMsgButClick:(UIButton *)sender {
    NSLog(@"发短信");
}
//打电话 点击事件
- (IBAction)callButClick:(UIButton *)sender {
    NSLog(@"打电话");
}

@end
