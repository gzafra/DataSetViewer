//
//  DSVTableViewCell.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVTableViewCell.h"
#import "AFNetworking.h"
#import "UIImage+DSVResizable.h"
#import "GlobalDefinitions.h"

#define kHorizontalOffset 10.0f
#define kVerticalOffset 4.0f

@implementation DSVTableViewCell

-(instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        CGFloat leftOffset = kHorizontalOffset * 2 + kThumbnailImageSize;
        self.myTextLabel = [[UILabel alloc] initWithFrame: CGRectMake(leftOffset,
                                                                      5,
                                                                      self.frame.size.width - leftOffset - kHorizontalOffset,
                                                                      self.frame.size.height - kVerticalOffset * 2)];
        UIFont *font = self.myTextLabel.font;
        self.myTextLabel.font = [UIFont fontWithName:font.fontName size:14.0f];
        self.myTextLabel.numberOfLines = 3;
        [self addSubview:self.myTextLabel];
        
        self.myCellId = [self newUUID];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Sets default initial image
    [self updateWithImage:[UIImage imageNamed:@"default.png"]];
}

- (void)updateWithImage:(UIImage*)image{
    if (MAX(image.size.width, image.size.height) > kThumbnailImageSize) {
        [self.myImageView setImage:[image imageScaledToSize:CGSizeMake(kThumbnailImageSize, kThumbnailImageSize)]];
    }else{
        [self.myImageView setImage:image];
    }
    [self.myImageView setImage:image];
    self.myImageView.frame = CGRectMake(kHorizontalOffset, 0, kThumbnailImageSize, kThumbnailImageSize);
    self.myImageView.center = CGPointMake(kHorizontalOffset + kThumbnailImageSize/2, self.frame.size.height/2);
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
                         
- (NSString *)newUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge_transfer NSString *)uuidStringRef;
}

@end
