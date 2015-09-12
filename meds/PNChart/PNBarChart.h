//
//  PNBarChart.h
//  PNChartDemo
//
//  Created by Yunfeng Zhao on 2013-11-20.
//  Copyright (c) 2013 MLearningG. All rights reserved.
//

#import <UIKit/UIKit.h>

#define chartMargin     10
#define xLabelMargin    15
#define yLabelMargin    15
#define yLabelHeight    11

@interface PNBarChart : UIView

/**
 * This method will call and troke the line in animation
 */

-(void)strokeChart;

@property (strong, nonatomic) NSArray * xLabels;

@property (strong, nonatomic) NSArray * yLabels;

@property (strong, nonatomic) NSArray * yValues;

@property (nonatomic) CGFloat xLabelWidth;

@property (nonatomic) int yValueMax;



@property (nonatomic, strong) UIColor * strokeColor;


@end
