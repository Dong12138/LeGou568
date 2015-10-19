//
//  SortViewController.m
//  Lg
//  分类VC
//  Created by echo21 on 15/9/28.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "SortViewController.h"
#import "CompanyTypeModel.h"
#import "Small_Company.h"
@interface SortViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_collectionView reloadData];
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
#pragma mark collectionView_代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSArray *small_company =_companyTypeModel.small_company_type;//一级城市中所包含的二级城市数
    return small_company.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *small_company =_companyTypeModel.small_company_type;//一级城市中所包含的二级城市数组
    NSDictionary *dic = small_company[section];
    NSArray *companyArr = dic[@"company"];//二级城市中分类所包含的多个店铺
    if (companyArr.count == 0) {
        return 0;
    }
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *small_company =_companyTypeModel.small_company_type;//一级城市中所包含的二级城市数组
    NSDictionary *dic = small_company[indexPath.section];
    NSArray *companyArr = dic[@"company"];//二级城市中分类所包含的多个店铺

    UICollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopCell" forIndexPath:indexPath];
    //解决cell复用问题
    for (UIView *label in collectionCell.contentView.subviews) {
        for (UIButton*but in label.subviews) {
            if (but.tag ==51 || but.tag == 52 || but.tag == 50 ) {
                [but setTitle:@"" forState:UIControlStateNormal] ;
            }
        }
        
        
    }
    for (int i = 0;i<companyArr.count;i++) {
        UIButton *but = (UIButton *)[collectionCell viewWithTag:50+i];
        NSDictionary *dic = companyArr[i];
        [but setTitle:dic[@"company_name"] forState:UIControlStateNormal];
        //label.text = dic[@"company_name"];
    }
    return collectionCell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[header viewWithTag:60];
//    CompanyTypeModel *companyType = _companyTypeArr[indexPath.section];
    NSArray *small_company = _companyTypeModel.small_company_type;//一级城市中所包含的二级城市数组
    NSDictionary *dic = small_company[indexPath.section];
    label.text = dic[@"company_type_name"];
    return header;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(WIDTH-20, 30);
}
//设置Header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(WIDTH-20, 45);
    
}
////设置Footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return CGSizeMake(375, 76);
//    }
//    return CGSizeZero;
//    
//}

@end
