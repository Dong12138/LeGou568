//
//  CompanyModel.m
//  Lg
//
//  Created by echo21 on 15/9/26.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "CompanyModel.h"

@implementation CompanyModel
-(void)setCompanyModelWithDic:(NSDictionary *)dic{
    self.company_ad = dic[@"company_ad"];
    
    self.company_ico = dic[@"company_ico"];
    self.company_id = dic[@"company_id"];
    self.company_name = dic[@"company_name"];
    self.company_shortname = dic[@"company_shortname"];
    self.company_url = dic[@"company_url"];
}
@end
