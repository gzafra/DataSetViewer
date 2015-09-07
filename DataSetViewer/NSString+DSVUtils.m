//
//  NSString+DSVUtils.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 11/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "NSString+DSVUtils.h"

@implementation NSString (DSVUtils)

- (NSString*)stringByRemovingHtmlTags{
    NSRange r;
    NSString *aux = self;
    while ((r = [aux rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        aux = [aux stringByReplacingCharactersInRange:r withString:@""];
    return aux;
}

- (NSString*)stringByRemovingQuotes{
    return [self stringByReplacingOccurrencesOfString:@"\"" withString:@""];
}

@end
