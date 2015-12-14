//
//  RYViewModel.m
//  RYMVVMSample
//
//  Created by SunYu on 15/12/14.
//  Copyright © 2015年 RyanStudio. All rights reserved.
//

#import "RYViewModel.h"
@interface RYViewModel()
@property (nonatomic,strong)dispatch_queue_t networkQueue;
@end

@implementation RYViewModel
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _success = [RACSubject subject];
        _failed = [RACSubject subject];
        _networkQueue = dispatch_queue_create("Ryan.SY", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

//loading data
- (void)loadItems
{
    self.isLoading = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), self.networkQueue, ^{
        BOOL fail = arc4random_uniform(10) == 9;
        if(fail)
        {
            self.items = nil;
            NSError *err = [NSError errorWithDomain:@"" code:0 userInfo:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.failed sendNext:err];
            });
        }
        else
        {
            NSMutableArray *array = @[].mutableCopy;
            NSInteger i = 0;
            do {
                RYModel *model = [[RYModel alloc] init];
                model.text = [NSString stringWithFormat:@"%ld",(long)arc4random_uniform(100)];
                [array addObject:model];
                i++;
            } while (i < 10);
            self.items = array;

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.success sendNext:array];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isLoading = NO;
        });
    });
}
@end
