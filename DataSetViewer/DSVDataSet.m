//
//  DSVDataSet.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVDataSet.h"

@implementation DSVDataSet

- (instancetype)initWithTitle:(NSString*)title imageUrl:(NSString*)url description:(NSString*)description{
    if (self = [super init]) {
        _title = title;
        _imageUrl = url;
        _additionalDescription = description;
    }
    return self;
}

@end
