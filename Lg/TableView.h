//
//  TableView.h
//  Lg
//
//  Created by echo21 on 15/10/9.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FenLeiDelegate <NSObject>
-(void)reloadCollectionView:(NSString *)url;
@end
@interface TableView : UIView
@property (nonatomic,strong) NSArray *listType;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) id<FenLeiDelegate>delegate;
@end
