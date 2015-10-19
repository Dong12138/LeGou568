//
//  TableViewController.h
//  Lg
//
//  Created by echo21 on 15/10/14.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TiaozhuanDelegate<NSObject>
-(void)callBack:(NSString *)info_link : (int)index;
@end
@interface TableViewController : UITableViewController
@property (nonatomic,assign) long aaaa;
@property (nonatomic,strong) NSString *type_link;
@property (nonatomic,strong) NSArray *listInfoArr;
@property (nonatomic,assign) int index;
@property (nonatomic,strong) id<TiaozhuanDelegate>delegeta;
-(void)tableViewReloadData;
@end
