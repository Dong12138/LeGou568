//
//  SmallCompanyModel.m
//  Lg
//
//  Created by echo21 on 15/9/29.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "SmallCompanyModel.h"

@implementation SmallCompanyModel
-(void)setSmallCompanyValue:(NSDictionary *)dic{
    self.company_id = dic[@"company_id"];
    self.company_name = dic[@"company_name"];
    self.company_shortname = dic[@"company_shortname"];
    self.company_ico = dic[@"company_ico"];
    self.company_url = dic[@"company_url"];
}
@end
