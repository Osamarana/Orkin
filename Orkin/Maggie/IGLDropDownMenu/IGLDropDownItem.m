//
//  IGLDropDownItem.m
//  IGLDropDownMenuDemo
//
//  Created by Galvin Li on 8/30/14.
//  Copyright (c) 2014 Galvin Li. All rights reserved.
//

#import "IGLDropDownItem.h"

@interface IGLDropDownItem ()

@property (nonatomic, strong) UIView *customView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation IGLDropDownItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCustomView:(UIView *)customView
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self addSubview:customView];
        customView.userInteractionEnabled = NO;
        self.customView = customView;
    }
    return self;
}

- (void)commonInit
{
    _paddingLeft = 10;
    _showBackgroundShadow = YES;
    _backgroundColor = [UIColor clearColor];
    [self initView];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (self.customView) {
        [self.customView setFrame:self.bounds];
    } else {
        [self.bgView setFrame:self.bounds];
        [self updateLayout];
    }
    
}

- (void)initView
{
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 275, 50)];
    bgImg.image = [UIImage imageNamed:@"textboxbg.png"];
    [self addSubview:bgImg];
    
    self.bgView = [[UIView alloc] init];
    self.bgView.userInteractionEnabled = NO;
    self.bgView.layer.shouldRasterize = YES;
    [self.bgView setFrame:self.bounds];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor clearColor];
    
    
    self.showBackgroundShadow = _showBackgroundShadow;

    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.iconImageView];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.numberOfLines = 1;
    self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:21.0f];
    self.textLabel.textColor = [UIColor blackColor];
    [self addSubview:self.textLabel];
    
    
    
    [self updateLayout];
    
}

- (void)setIconImage:(UIImage *)iconImage
{
    _iconImage = iconImage;
    [self.iconImageView setImage:self.iconImage];
    
    [self updateLayout];
}

- (void)setShowBackgroundShadow:(BOOL)showBackgroundShadow
{
    _showBackgroundShadow = showBackgroundShadow;
    if (self.showBackgroundShadow) {
        self.bgView.layer.shadowColor = [UIColor grayColor].CGColor;
        self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
        self.bgView.layer.shadowOpacity = 0.2;
    } else {
        self.bgView.layer.shadowOpacity = 0.0;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    self.bgView.backgroundColor = self.backgroundColor;
}

- (void)updateLayout
{
    
    CGFloat selfWidth = CGRectGetWidth(self.bounds);
    CGFloat selfHeight = CGRectGetHeight(self.bounds);
    
    [self.iconImageView setFrame:CGRectMake(self.paddingLeft, 0, selfHeight, selfHeight)];
    if (self.iconImage) {
        [self.textLabel setFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+8, 0, selfWidth - CGRectGetMaxX(self.iconImageView.frame), selfHeight)];
    } else {
        [self.textLabel setFrame:CGRectMake(self.paddingLeft, 0, selfWidth, selfHeight)];
    }
}

- (void)setPaddingLeft:(CGFloat)paddingLeft
{
    _paddingLeft = paddingLeft;
    
    [self updateLayout];
}

- (void)setObject:(id)object
{
    _object = object;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textLabel.text = self.text;
}

- (id)copyWithZone:(NSZone *)zone
{
    IGLDropDownItem *itemCopy;
    if (_customView) {
        itemCopy = [[IGLDropDownItem alloc] initWithCustomView:_customView];
    } else {
        itemCopy = [[IGLDropDownItem alloc] init];
        itemCopy.iconImage = _iconImage;
        itemCopy.text = _text;
        itemCopy.paddingLeft = _paddingLeft;
        itemCopy.showBackgroundShadow = _showBackgroundShadow;
        itemCopy.backgroundColor = [UIColor clearColor];
    }
    
    itemCopy.index = _index;
    itemCopy.object = _object;

    
    return itemCopy;
}

@end
