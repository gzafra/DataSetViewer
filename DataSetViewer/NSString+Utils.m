//
//  NSString+Utils.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 11/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

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
