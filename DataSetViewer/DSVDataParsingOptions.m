//
//  DSVDataParsingOptions.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 11/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVDataParsingOptions.h"

@implementation DSVDataParsingOptions

- (instancetype)initWithLinesMode:(DSVDataParsingOptionsLinesMode)linesMode
                   componentsMode:(DSVDataParsingOptionsComponentsMode)componentsMode{
    if (self = [super init]) {
        _linesMode = linesMode;
        _componentsMode = componentsMode;
    }
    return self;
}

@end
