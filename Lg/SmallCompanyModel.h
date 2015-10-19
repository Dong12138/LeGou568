//
//  SmallCompanyModel.h
//  Lg
//
//  Created by echo21 on 15/9/29.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmallCompanyModel : NSObject
@property (nonatomic,strong) NSString *company_id;
@property (nonatomic,strong) NSString *company_name;
@property (nonatomic,strong) NSString *company_shortname;
@property (nonatomic,strong) NSString *company_ico;
@property (nonatomic,strong) NSString *company_url;
-(void)setSmallCompanyValue:(NSDictionary *)dic;
@end
