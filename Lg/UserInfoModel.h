//
//  UserInfoModel.h
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
/**
 *会员id
 */
@property (nonatomic,strong) NSString *user_id;
/**
 *会员编号
 */
@property (nonatomic,strong) NSString *user_num;
/**
 *会员姓名
 */
@property (nonatomic,strong) NSString *user_name;
/**
 *密码
 */
@property (nonatomic,strong) NSString *user_password;
/**
 *会员状态
 */
@property (nonatomic,strong) NSString *user_status;
/**
 *会员积分
 */
@property (nonatomic,strong) NSString *user_integral;
/**
 *QQ
 */
@property (nonatomic,strong) NSString *user_qq;
/**
 *会员性别
 *男    女
 */
@property (nonatomic,strong) NSString *user_sex;
/**
 *会员生日
 *格式  1970-01-01
 */
@property (nonatomic,strong) NSString *user_birthday;
/**
 *邮箱
 */
@property (nonatomic,strong) NSString *user_mail;
/**
 *手机号
 */
@property (nonatomic,strong) NSString *user_phone;
/**
 *地址
 */
@property (nonatomic,strong) NSString *user_address;
/**
 *备用手机
 */
@property (nonatomic,strong) NSString *user_phone2;
/**
 *备用地址
 */
@property (nonatomic,strong) NSString *user_address2;
/**
 *会员注册时间
 */
@property (nonatomic,strong) NSString *user_addtime;
/**
 *Vip等级
 */
@property (nonatomic,strong) NSString *vip;
/**
 *距下一级别差多少分
 */
@property (nonatomic,strong) NSString *next_integral;
/**
 *我的账单
 *打开网址即可
 */
@property (nonatomic,strong) NSString *mybill;
/**
 *vip内容
 */
@property (nonatomic,strong) NSString *vip_content;
-(void)setUserInfoValue:(NSDictionary *)dic;
@end
