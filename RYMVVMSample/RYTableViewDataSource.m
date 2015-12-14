//
//  RYTableViewDataSource.m
//  RYMVVMSample
//
//  Created by SunYu on 15/12/14.
//  Copyright © 2015年 RyanStudio. All rights reserved.
//

#import "RYTableViewDataSource.h"

@implementation RYTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.items.count;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"RYCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid forIndexPath:indexPath];
    RYModel *model = self.viewModel.items[indexPath.row];
    cell.textLabel.text = model.text;
    return cell;
}

@end
