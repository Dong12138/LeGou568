//
//  ShopDetailModel.h
//  Lg
//
//  Created by echo21 on 15/9/29.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDetailModel : NSObject
/**
 *店铺id
 */
@property (nonatomic,strong) NSString *company_id;
/**
 *会员id
 */
@property (nonatomic,strong) NSString *user_id;
/**
 *店铺名称
 */
@property (nonatomic,strong) NSString *company_name;
/**
 *店铺名称
 */
@property (nonatomic,strong) NSString *company_shortname;
/**
 *店铺申请时间
 */
@property (nonatomic,strong) NSString *company_applytime;
/**
 *店铺开通时间
 */
@property (nonatomic,strong) NSString *company_throughtime;
/**
 *店铺分类id
 */
@property (nonatomic,strong) NSString *company_type_id;
/**
 *店铺联系人
 */
@property (nonatomic,strong) NSString *company_contact;
/**
 *店铺电话
 */
@property (nonatomic,strong) NSString *company_tel;
/**
 *店铺介绍
 */
@property (nonatomic,strong) NSString *company_about;
/**
 *店铺展示图
 */
@property (nonatomic,strong) NSString *company_imgs;
/**
 *
 */
@property (nonatomic,strong) NSString *company_guide;
/**
 *店铺地址
 */
@property (nonatomic,strong) NSString *company_address;
/**
 *
 */
@property (nonatomic,strong) NSString *company_ad;
/**
 *店铺视频连接
 */
@property (nonatomic,strong) NSString *company_video;
/**
 *店铺等级
 */
@property (nonatomic,strong) NSString *company_level;
/**
 *店铺浏览量
 */
@property (nonatomic,strong) NSString *company_hits;
/**
 *店铺所在城市id
 */
@property (nonatomic,strong) NSString *city_id;
/**
 *店铺是否推荐
 *0 否  1是
 */
@property (nonatomic,strong) NSString *company_isrecommend;
/**
 *店铺排序
 */
@property (nonatomic,strong) NSString *company_listorder;
/**
 *是否开启评论
 *0  关闭
 *1   开启
 */
@property (nonatomic,strong) NSString *company_iscomment;
/**
 *店铺标志 logo
 */
@property (nonatomic,strong) NSString *company_ico;
/**
 *
 */
@property (nonatomic,strong) NSString *company_card;
/**
 *店铺产品
 */
@property (nonatomic,strong) NSArray *company_pro;
/**
 *店铺评论
 */
@property (nonatomic,strong) NSArray *company_comment;
/**
 *
 */
@property (nonatomic,strong) NSArray *company_imgs_new;
/**
 *分享标题
 */
@property (nonatomic,strong) NSString *share_title;
/**
 *
 */
@property (nonatomic,strong) NSString *share_img;
/**
 *分享图片
 */
@property (nonatomic,strong) NSString *share_url;
/**
 *分享内容
 */
@property (nonatomic,strong) NSString *share_content;

-(void)setDetailValue:(NSDictionary *)dic;
@end
