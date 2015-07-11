//
//  DSVDataSet.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVDataSet.h"
#import "NSString+Utils.h"


@implementation DSVDataSet

- (instancetype)initWithTitle:(NSString*)title imageUrl:(NSString*)url description:(NSString*)description{
    if (self = [super init]) {
        self.title = title;
        _imageUrl = url;
        self.additionalDescription = description;
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = [[title stringByRemovingHtmlTags] stringByRemovingQuotes];
    }
}

- (void)setAdditionalDescription:(NSString *)additionalDescription{
    if (_additionalDescription != additionalDescription) {
        _additionalDescription = [additionalDescription stringByRemovingHtmlTags];
    }
}

- (BOOL)isEqual:(DSVDataSet*)data{
    if ([data.title isEqualToString:self.title]) {
        return YES;
    }
    return NO;
}

#pragma mark - Serialization

-(void)encodeWithCoder:(NSCoder *)encoder{
    //Encode the properties of the object
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [encoder encodeObject:self.additionalDescription forKey:@"description"];
    [encoder encodeObject:self.image forKey:@"image"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]){
        //decode the properties
        self.title = [decoder decodeObjectForKey:@"title"];
        self.imageUrl = [decoder decodeObjectForKey:@"imagleUrl"];
        self.additionalDescription = [decoder decodeObjectForKey:@"description"];
        self.image = [decoder decodeObjectForKey:@"image"];
    }
    return self;
}

@end
