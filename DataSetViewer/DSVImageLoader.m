//
//  DSVImageLoader.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 04/09/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVImageLoader.h"
#import "AFNetworking.h"

@interface DSVImageLoader()

@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;
@property (nonatomic, strong) NSURL*imageUrl;
@end

@implementation DSVImageLoader

- (instancetype)initWithUrl:(NSURL*)imageUrl{
    if (self = [super init]) {
        _imageUrl = imageUrl;
    }
    return self;
}

- (void)loadImageForSender:(DSVTableViewCell*)sender{
    if (self.state == DSVImageLoaderStateNotLoaded) {
        self.state = DSVImageLoaderStateLoading;
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:self.imageUrl];
        [urlRequest setCachePolicy: NSURLRequestReturnCacheDataElseLoad];
        
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
        
        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        
        self.requestOperation = requestOperation;
        
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [sender updateWithImage:(UIImage*)responseObject];
            self.state = DSVImageLoaderStateLoaded;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error loading image with URL: %@",self.imageUrl);
            self.state = DSVImageLoaderStateNotLoaded;
        }];
        [requestOperation start];
    }
}

- (void)cancelRequest{
    if (self.state == DSVImageLoaderStateLoading) {
        [self.requestOperation cancel];
        self.requestOperation = nil;
    }
}

@end
