//
//  FindContentInfoModel.m
//  Lg
//
//  Created by echo21 on 15/10/13.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "FindContentInfoModel.h"

@implementation FindContentInfoModel
-(void)setFindContentValue:(NSDictionary *)dic{
   //self.info_id = [dic[@"info_id"] isEqual:[NSNull null]] ? @"":dic[@"info_id"];
    self.info_id = dic[@"info_id"];
    self.info_id = dic[@"info_id"];
    self.user_id = dic[@"user_id"];
    self.info_type_id = dic[@"info_type_id"];
    self.info_title = dic[@"info_title"];
    self.info_home_price = dic[@"info_home_price"];
    self.info_home_address = dic[@"info_home_address"];
    self.info_home_explain = dic[@"info_home_explain"];
    self.info_home_config = dic[@"info_home_config"];
    self.info_imgs = dic[@"info_imgs"];
    self.info_job_position = dic[@"info_job_position"];
    self.info_job_salary = dic[@"info_job_salary"];
    self.info_job_requirement = dic[@"info_job_requirement"];
    self.info_job_companyname = dic[@"info_job_companyname"];
    self.info_job_companyintro = dic[@"info_job_companyintro"];
    self.info_job_weal = dic[@"info_job_weal"];
    self.info_contact = dic[@"info_contact"];
    self.info_tel = dic[@"info_tel"];
    self.info_addtime = dic[@"info_addtime"];
    self.info_edittime = dic[@"info_edittime"];
    self.info_status = dic[@"info_status"];
    self.info_hits = dic[@"info_hits"];
    self.city_id = dic[@"city_id"];
    self.info_job_number = dic[@"info_job_number"];
    self.info_type_pid = dic[@"info_type_pid"];
    self.info_type_name = dic[@"info_type_name"];
    self.info_job_weal_new = dic[@"info_job_weal_new"];
    self.info_home_config_new = dic[@"info_home_config_new"];
    self.info_imgs_new = dic[@"info_imgs_new"];
    self.share_title = dic[@"share_title"];
    self.share_img = dic[@"share_img"];
    self.share_url = dic[@"share_url"];
    self.share_content = dic[@"share_content"];
}
@end
