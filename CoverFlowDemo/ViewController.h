//
//  ViewController.h
//  CoverFlowDemo
//
//  Created by lx on 2018/1/6.
//  Copyright © 2018年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface ViewController : UIViewController<iCarouselDataSource,iCarouselDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) iCarousel *myCarousel;


@end

