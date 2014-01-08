//
//  LandscapeEventDetailView.m
//  Classes
//
//  Created by Marcel Ruegenberg on 19.11.09.
//  Copyright 2009 Dustlab. All rights reserved.
//

#import "KRInfoView.h"

#define MAX_WIDTH 400
#define TOP_BOTTOM_MARGIN 5
#define LEFT_RIGHT_MARGIN 15
#define SHADOWSIZE 3
#define SHADOWBLUR 5
#define HOOK_SIZE 8

@interface KRInfoView ()

@property (nonatomic,readonly) UILabel *infoLabel;
@property (nonatomic,strong) CAShapeLayer *triangleLayer;
@end

@implementation KRInfoView

+(id) defaultKRInfoView
{
    return [[self alloc]init];
}

-(id) init
{
    self = [super initWithFrame:CGRectZero];
	if(self) {
        self.backgroundColor = [UIColor blackColor];
        self.layer.cornerRadius = 5.0;
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -2);
        self.layer.shadowOpacity = 10.0;
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        _infoLabel.shadowColor = [UIColor lightGrayColor];
        _infoLabel.shadowOffset = CGSizeMake(0, 1);
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_infoLabel];
        self.triangleLayer = [CAShapeLayer layer];
		 self.triangleLayer.fillColor = [UIColor blackColor].CGColor;
		 self.triangleLayer.lineWidth = 5.0;
		 self.triangleLayer.strokeEnd = 1.0;
        self.triangleLayer.strokeColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:self.triangleLayer];
	}
	return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    [self sizeToFit];
    [self recalculateFrame];
    
    [_infoLabel sizeToFit];
    _infoLabel.frame = CGRectMake(self.bounds.origin.x + 7, self.bounds.origin.y + 2, _infoLabel.frame.size.width, _infoLabel.frame.size.height);
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(CGRectGetMidX(_infoLabel.frame), CGRectGetMaxY(_infoLabel.frame) + 20)];
    [trianglePath addLineToPoint:CGPointMake(CGRectGetMidX(_infoLabel.frame) - 10, CGRectGetMaxY(_infoLabel.frame)+ 10)];
    [trianglePath addLineToPoint:CGPointMake(CGRectGetMidX(_infoLabel.frame) + 10, CGRectGetMaxY(_infoLabel.frame) + 10)];
    [trianglePath closePath];
    self.triangleLayer.path = trianglePath.CGPath;
}

-(CGSize) sizeThatFits:(CGSize)size
{
    CGSize s = [_infoLabel.text sizeWithAttributes:@{NSFontAttributeName:_infoLabel.font}];
    s.height += 15;
    s.height += SHADOWSIZE;
    
    s.width += 2 * SHADOWSIZE + 7;
    s.width = MAX(s.width, HOOK_SIZE * 2 + 2 * SHADOWSIZE + 10);
    
    return s;
}

-(void) recalculateFrame
{
    CGRect theFrame = self.frame;
    theFrame.size.width = MIN(MAX_WIDTH, theFrame.size.width);
    
    CGRect theRect = self.frame; theRect.origin = CGPointZero;
    theFrame.origin.y = self.tapPoint.y - 20 - theFrame.size.height + 2 * SHADOWSIZE + 1;
    theFrame.origin.x = round(self.tapPoint.x - ((theFrame.size.width - 2 * SHADOWSIZE)) / 2.0);
    self.frame = theFrame;
}

-(void) setText:(NSString *)text
{
    _text = text;
    _infoLabel.text = _text;
}

@end
