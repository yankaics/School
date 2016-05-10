//
//  HHActivityListController.m
//  校园助手
//
//  Created by hjl on 16/5/8.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHActivityListController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "HHActivityCell.h"
#import "HHActivity.h"
#import "HHActivityController.h"
#import "HHNavigationController.h"
@interface HHActivityListController ()
/** infoMutableArray */
@property (nonatomic, strong) NSMutableArray *infoMutableArray;
/** 页码 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation HHActivityListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    
    [self setupRefresh];
    //[self getNewTweet];
}

- (void)setupTable {
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HHActivityCell" bundle:nil] forCellReuseIdentifier:@"HHActivityCell"];
    self.view.backgroundColor = HHBackgroundColor;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 180;
}

- (void)setupRefresh {
    // 创建下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewTweet)];
    
    // 开始下拉刷新
    [self.tableView.mj_header beginRefreshing];
    
    // 创建上拉加载更多控件
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        // 回调时结束刷新
        [self.tableView.mj_footer endRefreshing];
        // 加载更多数据
        [self loadMoreTweet];
    }];
    // 开始上拉加载更多
    //[self.tableView.mj_footer beginRefreshing];
}

- (void) getNewTweet{
    self.page = 0;
    // 全部活动
    _infoMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
    BmobQuery *query = [BmobQuery queryWithClassName:@"Activity"];
    [query orderByDescending:@"updatedAt"];
    query.limit = 10;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            //NSLog(@"---> %@", obj);
            HHActivity *activity    = [[HHActivity alloc] init];
            if ([obj objectForKey:@"publisher"]) {
                activity.publisher    = [obj objectForKey:@"publisher"];
            }
            if ([obj objectForKey:@"title"]) {
                activity.title    = [obj objectForKey:@"title"];
            }
            if ([obj objectForKey:@"unit"]) {
                activity.unit  = [obj objectForKey:@"unit"];
            }
            if ([obj objectForKey:@"time"]) {
                activity.time = [obj objectForKey:@"time"];
            }
            if ([obj objectForKey:@"content"]) {
                activity.content = [obj objectForKey:@"content"];
            }
            if ([obj objectForKey:@"picture"]) {
                activity.picture = [obj objectForKey:@"picture"];
            }
            if ([obj objectForKey:@"site"]) {
                activity.site    = [obj objectForKey:@"site"];
            }
            //HHLog(@"---> %@", activity);
            [self.infoMutableArray addObject:activity];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void) loadMoreTweet{
    self.page ++;
    //_infoMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
    BmobQuery *query = [BmobQuery queryWithClassName:@"tweets"];
    [query orderByDescending:@"updatedAt"];
    query.limit = 10;
    query.skip = 10 * (self.page);//跳过20条数据
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            //NSLog(@"---> %@", obj);
            HHActivity *activity    = [[HHActivity alloc] init];
            if ([obj objectForKey:@"publisher"]) {
                activity.publisher    = [obj objectForKey:@"publisher"];
            }
            if ([obj objectForKey:@"unit"]) {
                activity.unit  = [obj objectForKey:@"unit"];
            }
            if ([obj objectForKey:@"time"]) {
                activity.time = [obj objectForKey:@"time"];
            }
            if ([obj objectForKey:@"content"]) {
                activity.content = [obj objectForKey:@"content"];
            }
            if ([obj objectForKey:@"picture"]) {
                activity.picture = [obj objectForKey:@"picture"];
            }
            if ([obj objectForKey:@"site"]) {
                activity.site    = [obj objectForKey:@"site"];
            }
            HHLog(@"---> %@", activity);
            [self.infoMutableArray addObject:activity];
        }
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHActivityCell"];
    
    HHActivity *activity = self.infoMutableArray[indexPath.row];
    cell.activity = activity;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HHActivityController *ac = [[HHActivityController alloc] init];
    HHActivity *activity = self.infoMutableArray[indexPath.row];
    ac.activity = activity;
    [self.navigationController pushViewController:ac animated:YES];
}
@end
