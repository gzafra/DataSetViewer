//
//  DSVTableViewCell.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVTableViewCell.h"
#import "AFNetworking.h"

#define kHorizontalOffset 10.0f
#define kVerticalOffset 4.0f
#define kImageSize 64.0f

@implementation DSVTableViewCell

-(instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        CGFloat leftOffset = kHorizontalOffset * 2 + kImageSize;
        self.myTextLabel = [[UILabel alloc] initWithFrame: CGRectMake(leftOffset,
                                                                      5,
                                                                      self.frame.size.width - leftOffset - kHorizontalOffset,
                                                                      self.frame.size.height - kVerticalOffset * 2)];
        UIFont *font = self.myTextLabel.font;
        self.myTextLabel.font = [UIFont fontWithName:font.fontName size:14.0f];
        self.myTextLabel.numberOfLines = 3;
        [self addSubview:self.myTextLabel];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Sets default initial image
    [self updateWithImage:[UIImage imageNamed:@"default.png"]];
}

- (void)updateWithImage:(UIImage*)image{
    [self.myImageView setImage:image];
    self.myImageView.frame = CGRectMake(kHorizontalOffset, 0, kImageSize, kImageSize);
    self.myImageView.center = CGPointMake(kHorizontalOffset + kImageSize/2, self.frame.size.height/2);
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
