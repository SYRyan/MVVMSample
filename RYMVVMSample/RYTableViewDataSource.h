//
//  RYTableViewDataSource.h
//  RYMVVMSample
//
//  Created by SunYu on 15/12/14.
//  Copyright © 2015年 RyanStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RYViewModel.h"
@interface RYTableViewDataSource : NSObject<UITableViewDataSource>
@property (nonatomic,strong,nullable)RYViewModel *viewModel;
@end
