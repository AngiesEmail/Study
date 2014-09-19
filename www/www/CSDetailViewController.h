//
//  CSDetailViewController.h
//  www
//
//  Created by playcrab on 19/9/14.
//  Copyright (c) 2014年 playcrab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
