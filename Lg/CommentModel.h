//
//  CommentModel.h
//  Lg
//  店铺评论
//  Created by echo21 on 15/9/29.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property(nonatomic,strong) NSString *comment_id;
@property(nonatomic,strong) NSString *user_id;
@property(nonatomic,strong) NSString *company_id;
@property(nonatomic,strong) NSString *comment_content;
@property(nonatomic,strong) NSString *comment_addtime;
@property(nonatomic,strong) NSString *user_name;
-(void)setCommentModelValue:(NSDictionary *)dic;
@end
