//
//  DetailViewController.h
//  DkClient
//
//  Created by wangxq on 13-4-28.
//  Copyright (c) 2013年 wangxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
