//
//  HHLoginController.h
//  图书馆
//
//  Created by hjl on 16/4/24.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HHLoginControllerBlock)();

@interface HHLoginController : UIViewController

/** block */
@property (nonatomic, strong) HHLoginControllerBlock block;

@end
