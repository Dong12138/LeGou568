//
//  FindContentInfoModel.h
//  Lg
//
//  Created by echo21 on 15/10/13.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindContentInfoModel : NSObject
@property (nonatomic,strong) NSString *info_id;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *info_type_id;
@property (nonatomic,strong) NSString *info_title;
@property (nonatomic,strong) NSString *info_home_price;
@property (nonatomic,strong) NSString *info_home_address;
@property (nonatomic,strong) NSString *info_home_explain;
@property (nonatomic,strong) NSArray *info_home_config;

@property (nonatomic,strong) NSString *info_imgs;
@property (nonatomic,strong) NSString *info_job_position;
@property (nonatomic,strong) NSString *info_job_salary;
@property (nonatomic,strong) NSString *info_job_requirement;
@property (nonatomic,strong) NSString *info_job_companyname;
@property (nonatomic,strong) NSString *info_job_companyintro;
@property (nonatomic,strong) NSArray *info_job_weal;

@property (nonatomic,strong) NSString *info_contact;
@property (nonatomic,strong) NSString *info_tel;
@property (nonatomic,strong) NSString *info_addtime;
@property (nonatomic,strong) NSString *info_edittime;
@property (nonatomic,strong) NSString *info_status;
@property (nonatomic,strong) NSString *info_hits;
@property (nonatomic,strong) NSString *city_id;
@property (nonatomic,strong) NSString *info_job_number;

@property (nonatomic,strong) NSString *info_type_pid;
@property (nonatomic,strong) NSString *info_type_name;
@property (nonatomic,strong) NSArray *info_job_weal_new;
@property (nonatomic,strong) NSArray *info_home_config_new;
@property (nonatomic,strong) NSArray *info_imgs_new;
@property (nonatomic,strong) NSString *share_title;
@property (nonatomic,strong) NSString *share_img;
@property (nonatomic,strong) NSString *share_url;
@property (nonatomic,strong) NSString *share_content;
-(void)setFindContentValue:(NSDictionary *)dic;
@end
