//
//  ProfileProtocolHandler.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/27.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "ProfileProtocolHandler.h"
#import "ProfileListEvent.h"
#import "EPPickerView.h"
#import "CoffeInfoModel.h"
#import "ALLModels.h"


@interface ProfileProtocolHandler ()
{
    NSDictionary *dict;
    UITextField *_textField;
}
@end

@implementation ProfileProtocolHandler

-(id) initWithProfileListEvent:(ProfileListEvent *)event
{
    self = [super init];
    if(self) {
        self.profileListEvent = event;
        self.profileListEvent.delegate = self;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CoffeInfos.plist" ofType:nil];
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return self;
}

-(void) profileTextField:(UITextField *)textField
{
    if(textField.tag == 2) {
        [self gradingListPickerOpen:textField];
    } else if(textField.tag == 5) {
        [self beanTypePickerOpen:textField];
    } else if(textField.tag == 6) {
        [self variPickerOpen:textField];
    } else if(textField.tag == 7) {
        [self countryPickerOpen:textField];
    } else if(textField.tag == 9) {
        [self processPickerOpen:textField];
    }
    NSLog(@"%ld",(long)textField.tag);
}

-(void) gradingListPickerOpen:(id)sender
{
    if(!self.epPickerView) {
        self.epPickerView = [EPPickerView newPickerView:self action:@selector(gradingListPickerDone:)];
        self.epPickerView.dataSource = [NSMutableArray arrayWithCapacity:[CoffeInfoModel getGradingListWithDict:dict].count];
        for (NSString *str in [CoffeInfoModel getGradingListWithDict:dict]) {
             [self.epPickerView.dataSource addObject:str];
        }
        [self.profileView addSubview:self.epPickerView];
        _textField = sender;
    }
}

-(void) gradingListPickerDone:(id)sender
{
    NSInteger row = [self.epPickerView.pickerView selectedRowInComponent:0];
    _textField.text = [CoffeInfoModel getGradingListWithDict:dict][self.epPickerView.dataSource[row]];
    self.epPickerView = nil;
}

-(void) countryPickerOpen:(id)sender
{
    if(!self.epPickerView) {
        self.epPickerView = [EPPickerView newPickerView:self action:@selector(countryPickerDone:)];
        self.epPickerView.dataSource = [NSMutableArray arrayWithCapacity:[CoffeInfoModel getCountryWithDict:dict].count];
        for (NSString *str in [CoffeInfoModel getCountryWithDict:dict]) {
            [self.epPickerView.dataSource addObject:str];
        }
        [self.profileView addSubview:self.epPickerView];
        _textField = sender;
    }
}

-(void) countryPickerDone:(id)sender
{
    NSInteger row = [self.epPickerView.pickerView selectedRowInComponent:0];
    _textField.text = self.epPickerView.dataSource[row];
    self.epPickerView = nil;
}

-(void) processPickerOpen:(id)sender
{
    if(!self.epPickerView) {
        self.epPickerView = [EPPickerView newPickerView:self action:@selector(processPickerDone:)];
        self.epPickerView.dataSource = [NSMutableArray arrayWithCapacity:[CoffeInfoModel getProcessingWithDict:dict].count];
        for (NSString *str in [CoffeInfoModel getProcessingWithDict:dict]) {
            [self.epPickerView.dataSource addObject:str];
        }
        [self.profileView addSubview:self.epPickerView];
        _textField = sender;
    }
}

-(void) processPickerDone:(id)sender
{
    NSInteger row = [self.epPickerView.pickerView selectedRowInComponent:0];
    _textField.text = [CoffeInfoModel getProcessingWithDict:dict][self.epPickerView.dataSource[row]];
    self.epPickerView = nil;
}

-(void) variPickerOpen:(id)sender
{
    if(!self.epPickerView) {
        self.epPickerView = [EPPickerView newPickerView:self action:@selector(variPickerDone:)];
        self.epPickerView.dataSource = [NSMutableArray arrayWithCapacity:[CoffeInfoModel getVarietyWithDict:dict].count];
        for (NSString *str in [CoffeInfoModel getVarietyWithDict:dict]) {
            [self.epPickerView.dataSource addObject:str];
        }
        [self.profileView addSubview:self.epPickerView];
        _textField = sender;
    }
}

-(void) variPickerDone:(id)sender
{
    NSInteger row = [self.epPickerView.pickerView selectedRowInComponent:0];
    _textField.text = self.epPickerView.dataSource[row];
    self.epPickerView = nil;
}

-(void) beanTypePickerOpen:(id)sender
{
    if(!self.epPickerView) {
        self.epPickerView = [EPPickerView newPickerView:self action:@selector(beanTypePickerDone:)];
        self.epPickerView.dataSource = [NSMutableArray arrayWithCapacity:[CoffeInfoModel getBeanTypeWithDict:dict].count];
        for (NSString *str in [CoffeInfoModel getBeanTypeWithDict:dict]) {
            [self.epPickerView.dataSource addObject:str];
        }
        [self.profileView addSubview:self.epPickerView];
        _textField = sender;
    }
}

-(void) beanTypePickerDone:(id)sender
{
    NSInteger row = [self.epPickerView.pickerView selectedRowInComponent:0];
    _textField.text = [CoffeInfoModel getBeanTypeWithDict:dict][self.epPickerView.dataSource[row]];
    self.epPickerView = nil;
}

@end
