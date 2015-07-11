//
//  DSVTableViewCell.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVTableViewCell.h"
#import "AFNetworking.h"

#define kImageLeftOffset 10
#define kImageSize 64

@implementation DSVTableViewCell

-(instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        self.myTextLabel = [[UILabel alloc] initWithFrame: CGRectMake(kImageLeftOffset * 2 + kImageSize, 5, 100, 60)];
        [self addSubview:self.myTextLabel];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Sets default initial image
    NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"png"];
    [self.myImageView setImage:[UIImage imageWithContentsOfFile:path]];
    [self updateWithImage:[UIImage imageWithContentsOfFile:path]];
}

- (void)updateWithImage:(UIImage*)image{
    [self.myImageView setImage:image];
    self.myImageView.frame = CGRectMake(kImageLeftOffset, 0, kImageSize, kImageSize);
    self.myImageView.center = CGPointMake(kImageLeftOffset + kImageSize/2, self.frame.size.height/2);
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
