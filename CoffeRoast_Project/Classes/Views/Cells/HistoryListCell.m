//
//  HistoryListCell.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/1/6.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "HistoryListCell.h"

static CGFloat const LabelWidth = 140;
static CGFloat const LabelHeight = 35;

@implementation HistoryListCell

- (id)initWithStyle:(UITableViewCellStyle)style  reuseIdentifier:(NSString *)reuseIdentifier cellType:(CellTypes)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.opaque = YES;
        self.backgroundColor = [UIColor clearColor];
        
        self.cellType = type;
        if(type == kCellPushType) {
            self.infoTitleBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"InfoTitle_bg.png"]];
            self.infoTitleBg.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) * 0.4, 200);
            [self addSubview:self.infoTitleBg];
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else {
            self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"FileNameBox.png"]];
            self.imageView.image = [UIImage imageNamed:@"hFileSign.png"];
            self.textLabel.textColor = [UIColor colorWithRed:0.4 green:0.14901961 blue:0.16470588 alpha:1];
            self.textLabel.font = [UIFont fontWithName:@"Futura-Medium" size:36];
            self.textLabel.adjustsFontSizeToFitWidth = YES;
             self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.isExpansion = NO;
        }
    }
    return self;
}

-(void) setCellLabelWithTitles:(NSArray*) titles
{
    int x = 0,y = 15;
    int i  = 0;
    if(self.valueLabels == nil) {
        self.valueLabels = [NSMutableArray array];
        for(NSString *title in titles) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, y,LabelWidth, LabelHeight)];
            label.text = title;
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithRed:0.11764706 green:0.18823529 blue:0.25882353 alpha:1];
            label.font = [UIFont fontWithName:@"Futura-Medium" size:20];
            label.adjustsFontSizeToFitWidth = YES;
            [self addSubview:label];
            
            UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(x + CGRectGetMaxX(label.frame),y,LabelWidth + 100, LabelHeight)];
            valueLabel.backgroundColor = [UIColor clearColor];
            valueLabel.textColor = [UIColor colorWithRed:0.4 green:0.14901961 blue:0.16470588 alpha:1];
            valueLabel.textAlignment = NSTextAlignmentLeft;
            valueLabel.font = [UIFont fontWithName:@"Futura-Medium" size:20];
            label.adjustsFontSizeToFitWidth = YES;
            [self addSubview:valueLabel];
            y += CGRectGetHeight(label.frame);
            [self.valueLabels addObject:valueLabel];
            i ++;
        }
    }
}

-(void) setTitleValue:(NSArray *)titleValues
{
    int i = 0;
    for(NSString *title in titleValues) {
        UILabel *label = [self.valueLabels objectAtIndex:i];
        label.text = title;
        i++;
    }
}


@end
