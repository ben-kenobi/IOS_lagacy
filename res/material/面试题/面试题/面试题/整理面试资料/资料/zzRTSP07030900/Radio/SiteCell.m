//
//  SiteCell.m
//  Radio
//
//  Created by Planet1107 on 2/8/12.
//

#import "SiteCell.h"

@implementation SiteCell

@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleLabel = [[UILabel alloc] init];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont fontWithName:@"Verdana" size:15]];
        self.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-normal-no-speaker"]] autorelease];
        self.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-selected"]] autorelease];
        self.imageView.image = [UIImage imageNamed:@"ylCellSmall"];
        
        [self.contentView addSubview:titleLabel];
    }
    return self;
}

- (void)dealloc {
    [titleLabel release];
    [super dealloc];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    titleLabel.frame = CGRectMake(50, 10, 201, 21);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
