//
//  HHHomeController.m
//  校园助手
//
//  Created by hjl on 16/5/8.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHHomeController.h"
#import "HHFirstScrollView.h"
#import <AFNetworking.h>
#import "HHWeather.h"
#import "HHWeatherView.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "HHNews.h"
#import "HHNewsController.h"

@interface HHHomeController ()
/** weather */
@property (nonatomic, strong) HHWeather *weather;
/** infoMutableArray */
@property (nonatomic, strong) NSMutableArray *infoMutableArray;
/** 页码 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation HHHomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 50, 0);
    self.view.backgroundColor = HHBackgroundColor;
    self.tableView.rowHeight = 64;
    [self loadWeather];
    [self setupRefresh];
}

- (void)setupHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HHWidth, scrollHeight + 60)];
    
    HHWeatherView *weatherView = [[NSBundle mainBundle] loadNibNamed:@"HHWeatherView" owner:nil options:nil].lastObject;
    weatherView.frame = CGRectMake(0, 0, HHWidth, 60);
    weatherView.weather = self.weather;
    //HHLog(@"%@", self.weather);
    //HHLog(@"%@", weatherView.weather);
    [headerView addSubview:weatherView];
    
    HHFirstScrollView *firstView = [[HHFirstScrollView alloc]initWithFrame:CGRectMake(0, -4, HHWidth, scrollHeight)];
    [headerView addSubview:firstView];

    self.tableView.tableHeaderView = headerView;
    [self.tableView reloadData];
}

- (void)loadWeather {
    NSString *strUrl = @"https://api.heweather.com/x3/weather";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"cityid"] = @"CN101181101";
    parameters[@"key"] = @"7476de8316004c598e40b96d0e4c4131";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:strUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //HHLog(@"%@", responseObject);
        
        NSMutableArray *array = responseObject[@"HeWeather data service 3.0"];
        //HHLog(@"%@", array);
        NSMutableDictionary *md = array.lastObject;
        //HHLog(@"%@", md[@"basic"][@"update"][@"loc"]);
        
        HHWeather *weather = [[HHWeather alloc] init];
        
        /** 数据更新的当地时间 basic / update / loc */
        weather.loc = md[@"basic"][@"update"][@"loc"];
        //HHLog(@"%@", weather.loc);
        /** 当前温度(摄氏度) now / tmp */
        weather.tmp = md[@"now"][@"tmp"];
        //HHLog(@"%@", weather.tmp);

        /** 天气描述 now / cond / txt*/
        weather.condtxt = md[@"now"][@"cond"][@"txt"];
        //HHLog(@"%@", weather.condtxt);

        /** 天气代码 now / cond / code    用来获取天气图标 */
        //http://files.heweather.com/cond_icon/100.png
        weather.code = [NSString stringWithFormat:@"http://files.heweather.com/cond_icon/%@.png", md[@"now"][@"cond"][@"code"]];
        //HHLog(@"%@", weather.code);
        
        self.weather = weather;
        [self setupHeaderView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HHLog(@"%@", error);
    }];
}

- (void)setupRefresh {
    // 创建下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 回调时结束刷新
        [self.tableView.mj_header endRefreshing];
        // 加载更多数据
        [self loadMoreNews];
    }];
    
    // 开始下拉刷新
    [self.tableView.mj_header beginRefreshing];
    
    // 创建上拉加载更多控件
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        // 回调时结束刷新
        [self.tableView.mj_footer endRefreshing];
        // 加载更多数据
        [self getNewNews];
    }];
}

- (void)loadMoreNews{
    self.page = 0;
    // 全部活动
    _infoMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
    BmobQuery *query = [BmobQuery queryWithClassName:@"news"];
    [query orderByDescending:@"updatedAt"];
    query.limit = 10;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            //NSLog(@"---> %@", obj);
            HHNews *news    = [[HHNews alloc] init];
            if ([obj objectForKey:@"publisher"]) {
                news.publisher    = [obj objectForKey:@"publisher"];
            }
            if ([obj objectForKey:@"title"]) {
                news.title    = [obj objectForKey:@"title"];
            }
            if ([obj objectForKey:@"author"]) {
                news.author  = [obj objectForKey:@"author"];
            }
            if ([obj objectForKey:@"publishTime"]) {
                news.publishTime = [obj objectForKey:@"publishTime"];
            }
            if ([obj objectForKey:@"content"]) {
                news.content = [obj objectForKey:@"content"];
            }
            [self.infoMutableArray addObject:news];
        }
        [self.tableView reloadData];
        //[self.tableView.mj_header endRefreshing];
    }];

}

- (void)getNewNews{
    self.page ++;
    //_infoMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
    BmobQuery *query = [BmobQuery queryWithClassName:@"news"];
    [query orderByDescending:@"updatedAt"];
    query.limit = 10;
    query.skip = 10 * (self.page);//跳过20条数据
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            //NSLog(@"---> %@", obj);
            HHNews *news    = [[HHNews alloc] init];
            if ([obj objectForKey:@"publisher"]) {
                news.publisher    = [obj objectForKey:@"publisher"];
            }
            if ([obj objectForKey:@"title"]) {
                news.title    = [obj objectForKey:@"title"];
            }
            if ([obj objectForKey:@"author"]) {
                news.author  = [obj objectForKey:@"author"];
            }
            if ([obj objectForKey:@"publishTime"]) {
                news.publishTime = [obj objectForKey:@"publishTime"];
            }
            if ([obj objectForKey:@"content"]) {
                news.content = [obj objectForKey:@"content"];
            }
            [self.infoMutableArray addObject:news];
        }
        [self.tableView reloadData];
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    HHNews *news = self.infoMutableArray[indexPath.row];
    cell.textLabel.text = news.title;
    cell.detailTextLabel.text = news.content;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"校内新闻";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HHNewsController *nvc = [[HHNewsController alloc] init];
    HHNews *news = self.infoMutableArray[indexPath.row];
    nvc.news = news;
    [self.navigationController pushViewController:nvc animated:YES];
}

@end
