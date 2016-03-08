//
//  MJDIYAutoFooter.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJRefreshAutoFooter.h"

@protocol MJRefreshButtonCickDelegate <NSObject>

- (void)MJRefreshButtonCick;

@end
@interface MJDIYAutoFooter : MJRefreshAutoFooter
@property (nonatomic,assign) id <MJRefreshButtonCickDelegate> delegate;
@property (strong, nonatomic) UILabel *label;
@property (strong,nonatomic) UIButton *button;

@end
