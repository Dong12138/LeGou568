//
//  GoodsModel.m
//  Lg
//
//  Created by echo21 on 15/10/7.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel
-(void)setGoodsValue:(NSDictionary *)dic{
    self.goods_id = dic[@"goods_id"];
    self.goods_type_id = dic[@"goods_type_id"];
    self.goods_name = dic[@"goods_name"];
    self.goods_imgs = dic[@"goods_imgs"];
    self.goods_title = dic[@"goods_title"];
    self.goods_ad = dic[@"goods_ad"];
    
    self.goods_isnew = dic[@"goods_isnew"];
    self.goods_sales = dic[@"goods_sales"];
    self.goods_addtime = dic[@"goods_addtime"];
    self.goods_ishot = dic[@"goods_ishot"];
    self.goods_price = dic[@"goods_price"];
    self.goods_marke_price = dic[@"goods_marke_price"];
    
    self.goods_number = dic[@"goods_number"];
    self.goods_content = dic[@"goods_content"];
    self.goods_status = dic[@"goods_status"];
    self.shop_id = dic[@"shop_id"];
    self.city_id = dic[@"city_id"];
    self.contentShop = dic[@"contentShop"];
    
    self.goods_typename = dic[@"goods_typename"];
    self.goods_type_url = dic[@"goods_type_url"];
    self.goods_type_pid = dic[@"goods_type_pid"];
    self.goods_imgs_new = dic[@"goods_imgs_new"];
    self.share_title = dic[@"share_title"];
    self.share_img = dic[@"share_img"];
    
    
    self.share_url = dic[@"share_url"];
    self.share_content = dic[@"share_content"];
}


@end
