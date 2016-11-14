//
//  CategoryCell.m
//  Radio
//
//  Created by Planet1107 on 2/9/12.
//

#import "CategoryCell.h"

@implementation CategoryCell

@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        titleLabel = [[UILabel alloc] init];
        [titleLabel setTextColor:[UIColor blackColor]];
       

        
        
        titleLabel.textAlignment =NSTextAlignmentCenter;
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont fontWithName:@"Verdana" size:15]];

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

//    self.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-normal-no-speaker"]] autorelease];
//    self.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-selected-no-speaker"]] autorelease];
//    
    self.selectedBackgroundView.backgroundColor = [UIColor yellowColor];
   
   
    self.titleLabel.frame = CGRectMake(15, 10, 201, 21);
    self.detailTextLabel.frame = CGRectMake(85, 32, 200, 21);
    
    self.detailTextLabel.textColor = [UIColor blueColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
