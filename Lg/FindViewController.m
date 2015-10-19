//
//  FindViewController.m
//  Lg
//
//  Created by echo21 on 15/10/10.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "FindViewController.h"
#import "FindTypeModel.h"
#import "FindDetailViewController.h"
#import "ReleaseViewController.h"
#import "ReleaseZhaopinViewController.h"
#import "FindFenLeiViewController.h"
@interface FindViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *releaseButton;
@property (nonatomic,strong) NSMutableArray *findTypeArr;
//房产还是招聘 标示
@property (nonatomic,assign) int flag;
//小的Cell是否打开
@property (nonatomic,assign) BOOL isOpen;
//第一个按钮的点击次数
@property (nonatomic,assign) int count;
//第二个按钮的点击次数
@property (nonatomic,assign) int count2;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _flag = 0;
    _findTypeArr = [NSMutableArray array];
    [self getFindVCData];
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dicc;

    self.title = @"乐购568";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    self.navigationItem.backBarButtonItem = backItem;
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)getFindVCData{
    NSString *findUrl = @"http://www.lg568.com/index.php/Home/APIinfo/typeInfo/city_id/2";
    __weak typeof(self)myself  = self;
    [SVProgressHUD showWithStatus:@"正在加载.."];
    dispatch_async(dispatch_queue_create("lg.com", 0), ^{
        [HttpTools getWithURL:findUrl params:nil success:^(id json) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = dictionary[@"type"];
            for(NSDictionary *dic in arr){
                FindTypeModel *findtype = [[FindTypeModel alloc]init];
                [findtype setFindtypeValue:dic];
                [myself.findTypeArr addObject:findtype];
            }
            [myself.collectionView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        } failure:^(NSError *error) {
            NSLog(@"error == %@",error.description);
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


#pragma mark Collection_代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_findTypeArr.count == 0) {
        return 0;
    }
    FindTypeModel *findtype = _findTypeArr[_flag];
    NSArray *arr = nil;
    if (section == 0) {
        if (_isOpen) {
            arr= findtype.small_infp_type;
        }else{
            return 0;
        }
        
    }
    else{
        arr = findtype.listinfo;
    }
    
    return arr.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _findTypeArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FindTypeModel *findtype = _findTypeArr[_flag];
    NSArray *arr = nil;
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"smallCell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell viewWithTag:2000];
        arr = findtype.small_infp_type;
        NSDictionary *dic = arr[indexPath.row];
        label.text = dic[@"info_type_name"];
        return cell;
    }
    if (indexPath.section == 1) {
        arr = findtype.listinfo;
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bigCell" forIndexPath:indexPath];
        UIImageView *imgView =(UIImageView *)[cell viewWithTag:2000];
        UILabel *titleLabel = (UILabel *) [cell viewWithTag: 2001];
        UILabel *addressLabel = (UILabel *) [cell viewWithTag:2002];
        UILabel *moneyLabel = (UILabel *)[cell viewWithTag:2003];
        UILabel *addtimeLabel = (UILabel *) [cell viewWithTag:2004];
        NSDictionary *dic = arr[indexPath.row];
        NSString *imgUrl =dic[@"info_imgs"];
        imgUrl = [NSString stringWithFormat:MyURL,imgUrl];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
        titleLabel.text = dic[@"info_title"];
        addressLabel.text = dic[@"info_address"];
        NSString *moneyStr = [NSString stringWithFormat:@"¥ %@",dic[@"info_money"]];
        moneyLabel.text = moneyStr;
        NSString *timeStr = [NSString stringWithFormat:@"%@",dic[@"info_addtime"]];
        timeStr = [timeStr substringToIndex:10];
        addtimeLabel.text = timeStr;
        return cell;
    }
    return nil;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        UIButton *firstBut = (UIButton *)[header viewWithTag:2000];
        [firstBut setTitle:@"房产" forState:UIControlStateNormal];
        [firstBut addTarget:self action:@selector(firstButClick:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *secBut = (UIButton *)[header viewWithTag:2001];
        [secBut setTitle:@"招聘" forState:UIControlStateNormal];
        [secBut addTarget:self action:@selector(secButClick:) forControlEvents:UIControlEventTouchUpInside];
        return header;
    }
    
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(WIDTH, 80);
    }else{
        return CGSizeZero;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake((WIDTH-3)/4.0, 30);
    }else{
        return CGSizeMake(WIDTH, 90);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FindTypeModel *findtype = _findTypeArr[_flag];
    if (indexPath.section == 0) {
        FindTypeModel *findtype = _findTypeArr[_flag];
        NSArray *arr = findtype.small_infp_type;
        FindFenLeiViewController *fenleiVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FindFenLeiViewController"];
        fenleiVC.small_infp_type = arr;
        fenleiVC.flag = indexPath.row;
        fenleiVC.index = _flag;
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:fenleiVC animated:YES];
    }else{
        NSArray *arr = findtype.listinfo;
        NSDictionary *dic = arr[indexPath.row];
        
        FindDetailViewController *findDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FindDetailViewController"];
        findDetailVC.info_link = dic[@"info_link"];
        findDetailVC.flag = _flag;
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:findDetailVC animated:YES];
    }
    
}
-(void)firstButClick:(UIButton *)but{
    
    //but.selected = !but.selected;
    _count++;
    _flag = 0;
    //将另一个button的计数清零
    _count2 = 0;
    //点击当前按钮时，如果另一个按钮为选中状态，则改为非选中状态
    UICollectionReusableView *header = (UICollectionReusableView *)but.superview;
    for (UIButton *bb in header.subviews) {
        if (bb.tag != but.tag) {
            if (bb.selected) {
                bb.selected = NO;
            }
        }
    }
    [_releaseButton setTitle:@"免费发布房产信息" forState:UIControlStateNormal];
    if (but.selected) {
        but.selected = NO;
        //当前smallCell已经打开，则关闭，否则反之
        if (_isOpen) {
            _isOpen = NO;
        }else{
            _isOpen = YES;
        }
        [_collectionView reloadData];
    }else{
        //当第一次点击按钮的时候，点击次数为2次的时候，打开smallCell,并将button设为选中
        if (_count%2 == 0) {
            _isOpen = YES;
            but.selected = YES;
        }else{
            _isOpen = NO;
        }
        
        
        [_collectionView reloadData];
    }
    
}
-(void)secButClick:(UIButton *)but{
    _flag = 1;
    _count2++;
    _count = 0;
    UICollectionReusableView *header = (UICollectionReusableView *)but.superview;
    for (UIButton *bb in header.subviews) {
        if (bb.tag != but.tag) {
            if (bb.selected) {
                bb.selected = NO;
            }
        }
    }
    [_releaseButton setTitle:@"免费发布招聘信息" forState:UIControlStateNormal];
    if (but.selected) {
        but.selected = NO;
        if (_isOpen) {
            _isOpen = NO;
        }else{
            _isOpen = YES;
        }
        [_collectionView reloadData];
    }else{
        if (_count2%2 == 0) {
            _isOpen = YES;
            but.selected = YES;
        }else{
            _isOpen = NO;
        }
        
        
        [_collectionView reloadData];
    }
    
}
//发布招聘信息 点击事件
- (IBAction)releseButClick:(UIButton *)sender {
    if (_flag == 0) {
        ReleaseZhaopinViewController *homeInfoVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ReleaseZhaopinViewController"];
        homeInfoVc.flag = _flag;
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:homeInfoVc animated:YES];

    }else{
        ReleaseViewController *releaseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ReleaseViewController"];
        releaseVC.flag = _flag;
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:releaseVC animated:YES];
        
        
    }
    
}
@end
