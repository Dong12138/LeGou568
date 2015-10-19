//
//  CompanyTypeModel.m
//  Lg
//
//  Created by echo21 on 15/9/26.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "CompanyTypeModel.h"

@implementation CompanyTypeModel
-(void)setCompanyTypeModel:(NSDictionary *)dic{
    self.add_company = dic[@"add_company"];
    self.company_type_ico = dic[@"company_type_ico"];
    self.company_type_id = [dic[@"company_type_id"] integerValue];
    self.company_type_name = dic[@"company_type_name"];
    self.company_type_url = dic[@"company_type_url"];
    self.small_company_type = dic[@"small_company_type"];
}
@end
