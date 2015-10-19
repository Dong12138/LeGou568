//
//  FindTypeModel.h
//  Lg
//
//  Created by echo21 on 15/10/10.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindTypeModel : NSObject
@property (nonatomic,strong) NSString *info_type_id;
@property (nonatomic,strong) NSString *info_type_pid;
@property (nonatomic,strong) NSString *info_type_name;
@property (nonatomic,strong) NSString *info_type_ico;
@property (nonatomic,strong) NSArray *small_infp_type;
@property (nonatomic,strong) NSArray *listinfo;
-(void)setFindtypeValue:(NSDictionary *)dic;
@end
