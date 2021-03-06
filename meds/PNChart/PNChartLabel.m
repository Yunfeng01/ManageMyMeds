//
//  PNChartLabel.m
//  PNChart
//
//  Created by Yunfeng Zhao on 2013-11-20.
//  Copyright (c) 2013 MLearningG. All rights reserved.
//

#import "PNChartLabel.h"
#import "PNColor.h"

@implementation PNChartLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setLineBreakMode:NSLineBreakByWordWrapping];
        [self setMinimumScaleFactor:11.0f];
        [self setNumberOfLines:0];
        [self setFont:[UIFont boldSystemFontOfSize:11.0f]];
        [self setTextColor: PNDeepGrey];
        self.backgroundColor = [UIColor clearColor];
        [self setTextAlignment:NSTextAlignmentLeft];
        self.userInteractionEnabled = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
