//
//  FindTypeModel.m
//  Lg
//
//  Created by echo21 on 15/10/10.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "FindTypeModel.h"

@implementation FindTypeModel
-(void)setFindtypeValue:(NSDictionary *)dic{
    self.info_type_id = dic[@"info_type_id"];
    self.info_type_pid = dic[@"info_type_pid"];
    self.info_type_name = dic[@"info_type_name"];
    self.info_type_ico = dic[@"info_type_ico"];
    self.small_infp_type = dic[@"small_infp_type"];
    self.listinfo = dic[@"listinfo"];
}
@end
