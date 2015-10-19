//
//  GoodsModel.h
//  Lg
//
//  Created by echo21 on 15/10/7.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject
@property (nonatomic,strong) NSString *goods_id;
@property (nonatomic,strong) NSString *goods_type_id;
@property (nonatomic,strong) NSString *goods_name;
@property (nonatomic,strong) NSString *goods_imgs;
@property (nonatomic,strong) NSString *goods_ad;
@property (nonatomic,strong) NSString *goods_title;
@property (nonatomic,strong) NSString *goods_isnew;
@property (nonatomic,strong) NSString *goods_sales;
@property (nonatomic,strong) NSString *goods_addtime;
@property (nonatomic,strong) NSString *goods_ishot;
@property (nonatomic,strong) NSString *goods_price;
@property (nonatomic,strong) NSString *goods_marke_price;

@property (nonatomic,strong) NSString *goods_number;
@property (nonatomic,strong) NSString *goods_content;
@property (nonatomic,strong) NSString *goods_status;
@property (nonatomic,strong) NSString *shop_id;
@property (nonatomic,strong) NSString *city_id;
@property (nonatomic,strong) NSDictionary *contentShop;
@property (nonatomic,strong) NSString *goods_typename;
@property (nonatomic,strong) NSString *goods_type_url;


@property (nonatomic,strong) NSString *goods_type_pid;
@property (nonatomic,strong) NSArray *goods_imgs_new;
@property (nonatomic,strong) NSString *share_title;
@property (nonatomic,strong) NSString *share_img;
@property (nonatomic,strong) NSString *share_url;
@property (nonatomic,strong) NSString *share_content;
-(void)setGoodsValue:(NSDictionary *)dic;
@end
