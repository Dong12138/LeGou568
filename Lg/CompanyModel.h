//
//  CompanyModel.h
//  Lg
//
//  Created by echo21 on 15/9/26.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject
@property (nonatomic,strong) NSString *company_ad;
@property (nonatomic,strong) NSString *company_ico;
@property (nonatomic,assign) NSString *company_id;
@property (nonatomic,strong) NSString *company_name;
@property (nonatomic,strong) NSString *company_shortname;
@property (nonatomic,strong) NSString *company_url;
-(void)setCompanyModelWithDic:(NSDictionary *)dic;
@end
