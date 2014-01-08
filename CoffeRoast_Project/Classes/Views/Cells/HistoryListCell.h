//
//  HistoryListCell.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/1/6.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CellTypes) {
    kCellDefaultType = 0,
    kCellPushType
};

@interface HistoryListCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CellTypes)type;
-(void) setCellLabelWithTitles:(NSArray*)titles;
-(void) setTitleValue:(NSArray *)titleValues;

@property(nonatomic, strong) UIImageView *infoTitleBg;
@property(nonatomic, strong) NSMutableArray *valueLabels;

@property(nonatomic) CellTypes cellType;
@property(nonatomic) BOOL isExpansion;
@end
