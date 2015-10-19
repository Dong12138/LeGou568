//
//  ShopDetailModel.m
//  Lg
//
//  Created by echo21 on 15/9/29.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "ShopDetailModel.h"

@implementation ShopDetailModel
-(void)setDetailValue:(NSDictionary *)dic{
    self.company_id = dic[@"company_id"];
    self.user_id = dic[@"user_id"];
    self.company_name = dic[@"company_name"];
    self.company_shortname = dic[@"company_shortname"];
    self.company_applytime = dic[@"company_applytime"];
    self.company_throughtime = dic[@"company_throughtime"];
    self.company_type_id = dic[@"company_type_id"];
    self.company_contact = dic[@"company_contact"];
    self.company_about = dic[@"company_about"];
    self.company_imgs = dic[@"company_imgs"];
    self.company_guide = dic[@"company_guide"];
    self.company_address = dic[@"company_address"];
    self.company_video = dic[@"company_video"];
    self.company_level = dic[@"company_level"];
    self.company_hits = dic[@"company_hits"];
    //self.city_id = dic[@"city_id"];
    self.company_isrecommend = dic[@"company_isrecommend"];
    self.company_listorder = dic[@"company_listorder"];
    self.company_iscomment = dic[@"company_iscomment"];
    self.company_card = dic[@"company_card"];
    self.company_pro = dic[@"company_pro"];
    self.company_ico = dic[@"company_ico"];
    self.company_comment = dic[@"company_comment"];
    self.company_imgs_new = dic[@"company_imgs_new"];
    self.share_title = dic[@"share_title"];
    self.share_img = dic[@"share_img"];
    self.share_url = dic[@"share_url"];
    self.share_content = dic[@"share_content"];
    self.company_tel = dic[@"company_tel"];
}
@end
