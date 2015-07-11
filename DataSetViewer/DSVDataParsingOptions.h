//
//  DSVDataParsingOptions.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 11/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DSVDataParsingOptionsLinesFirst,
    DSVDataParsingOptionsLinesAll
} DSVDataParsingOptionsLinesMode;

typedef enum : NSUInteger {
    DSVDataParsingOptionsComponentsFirst,
    DSVDataParsingOptionsComponentsAll
} DSVDataParsingOptionsComponentsMode;

@interface DSVDataParsingOptions : NSObject

@property (nonatomic, assign) DSVDataParsingOptionsComponentsMode componentsMode;
@property (nonatomic, assign) DSVDataParsingOptionsLinesMode linesMode;

@end
