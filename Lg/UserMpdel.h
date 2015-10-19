//
//  UserMpdel.h
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMpdel : NSObject<NSCoding>
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSDictionary *userinfo;
@property (nonatomic,strong) NSString *content;
-(void)setUserValue:(NSDictionary *)dic;
@end
