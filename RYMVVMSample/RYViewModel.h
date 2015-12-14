//
//  RYViewModel.h
//  RYMVVMSample
//
//  Created by SunYu on 15/12/14.
//  Copyright © 2015年 RyanStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RYModel.h"

@interface RYViewModel : NSObject
@property (nonatomic,strong,nullable)NSArray *items;
@property (nonatomic,strong,nullable)RACSubject *success;
@property (nonatomic,strong,nullable)RACSubject *failed;
@property (nonatomic,assign)BOOL isLoading;
- (void)loadItems;
@end
