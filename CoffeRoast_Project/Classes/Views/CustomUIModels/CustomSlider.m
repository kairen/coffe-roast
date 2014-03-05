//
//  CustomSlider.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/31.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "CustomSlider.h"

@implementation CustomSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMaximumTrackTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [self setThumbTintColor:[UIColor colorWithRed:0.07 green:0.16 blue:0.25 alpha:1.0]];
        [self setMinimumValue:0];
        [self setValue:0 animated:YES];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorRef shadowColor = [UIColor lightGrayColor].CGColor;
	CGContextSetShadowWithColor(context, CGSizeMake(0,-1), 2, shadowColor);
    
    CGRect textFrame = CGRectMake(-25,35,40,40);
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentRight;
    
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:14],
                                  NSParagraphStyleAttributeName: paragraphStyle };
    NSString *text = [NSString stringWithFormat:@"%d",(int)self.minimumValue];
    [text drawInRect:textFrame withAttributes:attributes];
    
    textFrame = CGRectMake(CGRectGetMaxX(self.frame) - 50, 35, 40, 40);
    text = [NSString stringWithFormat:@"%d",(int)self.maximumValue];
    [text drawInRect:textFrame withAttributes:attributes];
    CGContextRestoreGState(context);
}


@end
