//
//  ViewController.m
//  RYMVVMSample
//
//  Created by SunYu on 15/12/14.
//  Copyright © 2015年 RyanStudio. All rights reserved.
//

#import "ViewController.h"
#import "RYTableViewDataSource.h"
#import "RYViewModel.h"

@interface ViewController ()
@property (nonatomic,strong) RYTableViewDataSource *dataSource;
@property (nonatomic,strong) RYViewModel *viewModel;
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureViews];

    [self loadItems];
    
    @weakify(self);
    [self.viewModel.success subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    [self.viewModel.failed subscribeNext:^(id x) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Load Fail!!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show]; 
    }];
    
    [RACObserve(self.viewModel, isLoading) subscribeNext:^(id x) {
        @strongify(self);
        if([x boolValue])
        {
            self.title = @"Loading...";
            self.navigationItem.rightBarButtonItem.customView = self.loadingView;
            [self.loadingView startAnimating];
        }
        else
        {
            self.title = @"Demo";
            self.navigationItem.rightBarButtonItem.customView = nil;
            [self.loadingView stopAnimating];
        }
    }];
}

- (void)configureViews
{
    self.tableView.dataSource = (self.dataSource = [RYTableViewDataSource new]);
    self.dataSource.viewModel = (self.viewModel = [RYViewModel new]);

    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadingView.frame = CGRectMake(0, 0, 20, 20);
    [self.view addSubview:self.loadingView];
}

- (void)loadItems
{
    [self refreshData:nil];
}

- (IBAction)refreshData:(id)sender
{
    [self.viewModel loadItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
