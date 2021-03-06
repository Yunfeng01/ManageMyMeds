//
//  PNBar.h
//  PNChartDemo
//
//  Created by Yunfeng Zhao on 2013-11-20.
//  Copyright (c) 2013 MLearningG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PNBar : UIView

@property (nonatomic) float grade;

@property (nonatomic,strong) CAShapeLayer * chartLine;

@property (nonatomic, strong) UIColor * barColor;

@end
