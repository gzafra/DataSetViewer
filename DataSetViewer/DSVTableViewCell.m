//
//  DSVTableViewCell.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVTableViewCell.h"
#import "AFNetworking.h"

@implementation DSVTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    }
    
    return self;
}

- (void)awakeFromNib {
    // Sets default initial image
    NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"png"];
    [self.imageView setImage:[UIImage imageWithContentsOfFile:path]];
    
    // Asynchronously load the image from the url
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://lorempixel.com/200/200/people/"]];
    [urlRequest setCachePolicy: NSURLRequestReturnCacheDataElseLoad];

    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    
    __weak __typeof(self) weakSelf = self;
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf.imageView setImage:responseObject];
        weakSelf.imageView.frame = CGRectMake(0, 0, 64, 64);
        weakSelf.imageView.center = CGPointMake(10 + weakSelf.imageView.frame.size.width/2, weakSelf.frame.size.height/2);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error loading image");
    }];
    [requestOperation start];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
