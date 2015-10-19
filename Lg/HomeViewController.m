//
//  HomeViewController.m
//  Lg
//
//  Created by echo21 on 15/9/25.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "HomeViewController.h"
#import "OpenCityModel.h"
#import "CompanyModel.h"
#import "CompanyTypeModel.h"
#import "SortViewController.h"
#import "ShopDetailViewController.h"
#import "Small_Company.h"
#import "SmallCompanyModel.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) UIView *myView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cityArr;
@property (nonatomic,strong) NSMutableArray *recommendShopArr;
//获得获取店铺分类及店铺
@property (nonatomic,strong) NSMutableArray *companyTypeArr;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLay;
//二级城市数组
@property (nonatomic,strong) NSMutableArray *smallCityArr;
//
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRecommendShopData];
    
    
    
    _smallCityArr = [NSMutableArray array];
    _recommendShopArr = [NSMutableArray array];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title=@"";//设置返回按钮的title
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];//设置字体颜色
    //[backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"top_backbtn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//设置背景图片
    
    self.navigationItem.backBarButtonItem = backItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)addCityView{
    //初始化城市数组
    _cityArr = [NSMutableArray array];
    //创建view
    _myView = [[UIView alloc]initWithFrame:self.view.bounds];
    _myView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.6];
   // _myView.alpha =0.15;
    _myView.center =CGPointMake(WIDTH/2.0, -HEIGHT/2.0);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , WIDTH, HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.rowHeight = 40;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.alpha = 1;
    
    [self getOpenData];
    [_myView addSubview:_tableView];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:_myView];
    //[window insertSubview:_myView aboveSubview:self.view];
}

//获得已开通城市信息
-(void)getOpenData{
    NSString *opCity_url = @"http://www.lg568.com/index.php/Home/API/openCity";
    __weak typeof(self)myself = self;
    [HttpTools getWithURL:opCity_url params:nil success:^(id json) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *cityDic in arr){
            OpenCityModel *city = [[OpenCityModel alloc]init];
            [city setOpenCityModel:cityDic];
            [myself.cityArr addObject:city];
        }
        [myself.tableView reloadData];
        //NSLog(@"json = = %@",dic);
    } failure:^(NSError *error) {
        NSLog(@"openCityError = %@",error.description);
    }];
}

//获得推荐店铺信息
-(void)getRecommendShopData{
//    self.activityIndicator = [[UIActivityIndicatorView alloc]init];
//    self.activityIndicator.frame = CGRectMake((WIDTH-30)/2.0,( HEIGHT-30)/2.0, 30, 30);
//    self.activityIndicator.backgroundColor = [UIColor redColor];
//    [self.view addSubview:_activityIndicator];
    //获得获取店铺分类及店铺
   
    [SVProgressHUD showWithStatus:@"正在加载.."];
    
    __weak typeof(self)myself = self;
        dispatch_async(dispatch_queue_create("com.lg.net", 0), ^{
           
//            
             //开始显示加载圈

            //NSLog(@"耗时");

        NSString *recommendShop_url = @"http://www.lg568.com/index.php/Home/API/recommendCompany/city_id/2";
        
        [HttpTools getWithURL:recommendShop_url params:nil success:^(id json) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary *recommendShopDic in arr) {
                CompanyModel *company = [[CompanyModel alloc ]init];
                [company setCompanyModelWithDic:recommendShopDic];
                [myself.recommendShopArr addObject:company];
            }
            NSString *CompanyType_yrl = @"http://www.lg568.com/index.php/Home/API/CompanyType/city_id/2/";
            [HttpTools GetStoreInfo:CompanyType_yrl success:^(NSArray *array) {
                myself.companyTypeArr = [NSMutableArray arrayWithArray:array];
                [myself.collectionView reloadData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];//隐藏加载圈
                   // NSLog(@"完成");
                });
            }];
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
- (IBAction)cityButClick:(id)sender {
    if (_myView) {
        //隐藏view
        [UIView transitionWithView:_myView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _myView.center = CGPointMake(WIDTH/2.0, -HEIGHT/2.0);
        } completion:^(BOOL finished) {
            _myView = nil;
           // self.tabBarController.tabBar.hidden = NO;
        }];
        

    }else{
        //加载view
        [self addCityView];
        //self.tabBarController.tabBar.hidden = YES;
        [UIView transitionWithView:_myView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _myView.center = CGPointMake(WIDTH/2.0, HEIGHT/2.0+62);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}
#pragma mark TableView_代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        UIButton *cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cityButton setTitle:@"郑州市" forState:UIControlStateNormal];
        [cityButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cityButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        cityButton.frame =CGRectMake(10, 5, (WIDTH-40)/3.0, 30);
        cityButton.layer.masksToBounds = YES;
        cityButton.layer.borderColor = [UIColor redColor].CGColor;
        cityButton.layer.borderWidth = 1;
        [cell addSubview:cityButton];
        return cell;
    }else{
        for (int i = 0; i<_cityArr.count; i++) {
            OpenCityModel *city = _cityArr[i ];
            UIButton *cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [cityButton setTitle:city.city_name forState:UIControlStateNormal];
            cityButton.frame =CGRectMake((10*(i+1)+((WIDTH-40)/3.0)*i), 5, (WIDTH-40)/3.0, 30);
            [cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cityButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
            cityButton.layer.masksToBounds = YES;
            cityButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cityButton.layer.borderWidth = 1;
            //[cityButton setBackgroundImage:[UIImage imageNamed:@"search_bg.png"] forState:UIControlStateNormal];
            [cell addSubview:cityButton];
        }
        return cell;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"当前城市";
    }else{
        return @"开通城市";
    }
}
#pragma mark Collection_代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
         return _recommendShopArr.count;
    }else{
        CompanyTypeModel *company = _companyTypeArr[section-1];
       
        if (company.isOpen) {
            NSArray *array = company.small_company_type;
            //NSLog(@"count == %d",array.count);
            return array.count;
        }else{
            return 0;
        }
        
    }
   
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _companyTypeArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        CompanyModel *company = _recommendShopArr[indexPath.row];
        UICollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
        UIImageView *imgView = (UIImageView *)[collectionCell viewWithTag:20];
        UILabel *nameLabel = (UILabel *)[collectionCell viewWithTag:21];
        
        NSString *ico_url = [NSString stringWithFormat:MyURL,company.company_ico];
        [imgView sd_setImageWithURL:[NSURL URLWithString:ico_url] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
        nameLabel.text = company.company_shortname;
        return collectionCell;
        
    }else {
        
        CompanyTypeModel *companyType = _companyTypeArr[indexPath.section-1];
        NSArray *small_company = companyType.small_company_type;//一级城市中所包含的二级城市数组
        NSDictionary *dic = small_company[indexPath.row];
        UICollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"secCell" forIndexPath:indexPath];
       // NSLog(@"celle == %@",collectionCell);
        //NSLog(@"viewss == %@",collectionCell.contentView.subviews);
        
        //UIImageView *imgView = (UIImageView *)[collectionCell viewWithTag:40];//40
        UILabel *nameLabel1 = (UILabel *)[collectionCell viewWithTag:40];
        
        nameLabel1.text =dic[@"company_type_name"];
        NSArray *companyArr = dic[@"company"];//二级城市中分类所包含的多个店铺
        //解决cell复用数据错乱问题
        for (UIButton *but in collectionCell.contentView.subviews) {
            if (but.tag == 41 || but.tag == 42 || but.tag == 43 ) {
                [but setTitle:@"" forState:UIControlStateNormal];
               // but.titleLabel.text = @"";
            }
            
        }
        
        
//        NSLog(@"count == %lu",(unsigned long)companyArr.count);
        for (int i =0; i<companyArr.count; i++) {
            NSDictionary *compDic = companyArr[i];
            UIButton *but = (UIButton *)[collectionCell viewWithTag:41+i];
            [but setTitle:compDic[@"company_name"] forState:UIControlStateNormal];
           // but.titleLabel.text = compDic[@"company_name"];
            [but addTarget:self action:@selector(shopButClick:) forControlEvents:UIControlEventTouchUpInside];
            //nameLabel.text = compDic[@"company_name"];
          //   NSLog(@" label == %@;;; nameLabel.text == %@",nameLabel, nameLabel.text);
        }
        //[collectionCell prepareForReuse];
        
        
        return collectionCell;
    }
}
//cell上button的点击事件，调到商铺的详情页面
-(void)shopButClick:(UIButton *)but{
    if ([but.titleLabel.text isEqualToString:@""]) {
        
        return;
    }else{
        ShopDetailViewController *shop = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopDetailViewController"];
        UICollectionViewCell *cell = (UICollectionViewCell *)but.superview.superview;
        NSIndexPath *path = [_collectionView indexPathForCell:cell];
        CompanyTypeModel *type = _companyTypeArr[path.section-1];
        NSArray *small_companyArr = type.small_company_type;
        Small_Company *small = [[Small_Company alloc]init];
        [small setSmallCompanyValue: small_companyArr[path.row]];
        //Small_Company *small = small_companyArr[path.row];
        NSArray *company = small.company;
        SmallCompanyModel *model = [[SmallCompanyModel alloc]init];
        [model setSmallCompanyValue:company[but.tag - 41]];
        NSString *company_id = model.company_id;
        shop.company_id = company_id;
        shop.view.backgroundColor = [UIColor whiteColor];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:shop animated:YES];
    }
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake((WIDTH-40)/3.0, 30);
    }
    return CGSizeMake(355, 30);
}
//设置Header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(375, 50);
    
}
//设置Footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(375, 76);
    }
    return CGSizeZero;
    
}
//Header代理
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        UIScrollView *scrollview = (UIScrollView *)[footer viewWithTag:60];
        CompanyTypeModel *store = _companyTypeArr[0];
        NSArray *array =[NSArray arrayWithArray:store.add_company];
        //scrollview内容区
        scrollview.contentSize = CGSizeMake(array.count*scrollview.bounds.size.width, scrollview.bounds.size.height);
        //scrollview.backgroundColor = [UIColor redColor];
        for (int i=0;i<array.count;i++) {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(i*scrollview.bounds.size.width, 0, scrollview.bounds.size.width, scrollview.frame.size.height)];
            [scrollview addSubview:imageview];
            imageview.userInteractionEnabled=YES;
            //imageview.backgroundColor=[UIColor purpleColor];
            NSDictionary *dic = array[i];
            NSString *imagename = dic[@"company_ad"];
            NSString *ss = [NSString stringWithFormat:MyURL,imagename];
            [imageview sd_setImageWithURL:[NSURL URLWithString:ss] placeholderImage:[UIImage imageNamed:@"usercenterbg.png"]];
        }
        
        return footer;
    }else{
        CompanyTypeModel *companyType = _companyTypeArr[indexPath.section-1];
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        header.tag = indexPath.section;
        UIImageView *imgView = (UIImageView *)[header viewWithTag:70];
        UILabel *name = (UILabel *)[header viewWithTag:71];
        NSString *url_str = [NSString stringWithFormat:MyURL,companyType.company_type_ico];
        [imgView sd_setImageWithURL:[NSURL URLWithString:url_str] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
        name.text = companyType.company_type_name;
        
        UIButton *secondBut = (UIButton *)[header viewWithTag:72];
        [secondBut addTarget:self action:@selector(secondOpenOrClose:) forControlEvents:UIControlEventTouchUpInside];
        if (companyType.isOpen) {
            [secondBut setImage:[UIImage imageNamed:@"arrow_up.png"] forState:UIControlStateNormal];
        }else{
            [secondBut setImage:[UIImage imageNamed:@"arrow_down.png"] forState:UIControlStateNormal];
        }
        // NSLog(@"companyType.company_type_name == %@",companyType.company_type_name);

        //imgView
        return header;
    }

}
//打开或者关闭分组
-(void)secondOpenOrClose:(UIButton *)but{
    
    UICollectionReusableView *header = (UICollectionReusableView *)but.superview;
   
    CompanyTypeModel *company = _companyTypeArr[header.tag-1];
   
    
    if (company.isOpen) {
        company.isOpen = NO;
        [_collectionView reloadData];
    }else{
        company.isOpen = YES;
        [_collectionView reloadData];
    }

}
//header上的button ，用来跳转到分类界面
- (IBAction)tzSortVCButClick:(UIButton *)sender {
    UICollectionReusableView *header = (UICollectionReusableView *)sender.superview;
    SortViewController *sortVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SortViewController"];
    sortVC.companyTypeModel = _companyTypeArr[header.tag-1];
    sortVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:sortVC animated:YES];
}
//跳转到详情页

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ShopDetailViewController *shop = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopDetailViewController"];
        CompanyModel *company = _recommendShopArr[indexPath.row];
        shop.company_id = company.company_id;
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:shop animated:YES];
    }
}
/*
1,


*/
@end
