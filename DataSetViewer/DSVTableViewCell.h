//
//  DSVTableViewCell.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSVTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *myTextLabel;
@property (nonatomic, weak) IBOutlet UIImageView *myImageView;

- (void)updateWithImage:(UIImage*)image;

@end
