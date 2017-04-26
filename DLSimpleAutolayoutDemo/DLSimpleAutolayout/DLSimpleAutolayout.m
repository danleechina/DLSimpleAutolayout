//
//  DLSimpleAutolayout.m
//  DLSimpleAutolayoutDemo
//
//  Created by Dan.Lee on 2017/4/26.
//  Copyright © 2017年 Dan Lee. All rights reserved.
//

#import "DLSimpleAutolayout.h"


static NSInteger DLSimpleLayoutNotSetAttribute = -10;
static NSInteger DLSimpleLayoutNotSetRelation = -10;

@interface DLSimpleViewAttribute()

@property (nonatomic, weak) id item;
@property (nonatomic, assign) NSLayoutAttribute attribute;

@property (nonatomic, weak) id firstItem;
@property (nonatomic, assign) NSLayoutAttribute firstAttribute;
@property (nullable, nonatomic, weak) id secondItem;
@property (nonatomic, assign) NSLayoutAttribute secondAttribute;
@property (nonatomic, assign) NSLayoutRelation relation;
@property (nonatomic, assign) CGFloat multiplier;
@property (nonatomic, assign) CGFloat constant;
- (instancetype)initWithView:(UIView *)view attribute:(NSLayoutAttribute)attr;


@end

@implementation DLSimpleViewAttribute

- (instancetype)initWithView:(UIView *)view attribute:(NSLayoutAttribute)attr {
    self = [super init];
    if (self) {
        _item = view;
        _attribute = attr;
        
        _firstItem = view;
        _firstAttribute = attr;
        
        _secondItem = nil;
        _secondAttribute = DLSimpleLayoutNotSetAttribute;
        _relation = DLSimpleLayoutNotSetRelation;
        _multiplier = 1;
        _constant = 0;
    }
    return self;
}

- (DLSimpleViewAttribute *(^)(id))equalTo {
    return ^id(id view){
        [self customSelfWith:view];
        self.relation = NSLayoutRelationEqual;
        return self;
    };
}

- (DLSimpleViewAttribute *(^)(id))lessThanOrEqualTo {
    return ^id(id view){
        [self customSelfWith:view];
        self.relation = NSLayoutRelationLessThanOrEqual;
        return self;
    };
}

- (DLSimpleViewAttribute *(^)(id))greaterThanOrEqualTo {
    return ^id(id view){
        [self customSelfWith:view];
        self.relation = NSLayoutRelationGreaterThanOrEqual;
        return self;
    };
}

- (DLSimpleViewAttribute *(^)(CGFloat))multipliedBy {
    return ^id(CGFloat mult){
        self.multiplier *= mult;
        return self;
    };
}

- (DLSimpleViewAttribute *(^)(CGFloat))offset {
    return ^id(CGFloat constant){
        self.constant += constant;
        return self;
    };
}

// TODO: maybe some bugs
- (NSLayoutConstraint * (^)())install {
    return ^id(){
        ((UIView *)self.firstItem).translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constaraint = [NSLayoutConstraint constraintWithItem:self.firstItem
                                                                       attribute:self.firstAttribute
                                                                       relatedBy:self.relation
                                                                          toItem:self.secondItem
                                                                       attribute:self.secondAttribute
                                                                      multiplier:self.multiplier
                                                                        constant:self.constant];
        if (self.secondItem == nil) {
            [self.firstItem addConstraint:constaraint];
        } else {
            UIView *closestCommonSuperview = [self dl_ClosestCommonSuperview:self.firstItem view2:self.secondItem];
            [closestCommonSuperview addConstraint:constaraint];
        }
        return constaraint;
    };
}

- (UIView *)dl_ClosestCommonSuperview:(UIView *)view1 view2:(UIView *)view2 {
    UIView *closestCommonSuperview = nil;
    
    UIView *secondViewSuperview = view1;
    while (!closestCommonSuperview && secondViewSuperview) {
        UIView *firstViewSuperview = view2;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

- (void)customSelfWith:(id)view {
    if ([view isKindOfClass:[DLSimpleViewAttribute class]]) {
        DLSimpleViewAttribute *secondAttribute = (DLSimpleViewAttribute *)view;
        self.secondItem = secondAttribute.item;
        self.secondAttribute = secondAttribute.attribute;
    } else if ([view isKindOfClass:[NSNumber class]]) {
        self.constant = [((NSNumber *)view) floatValue];
        self.secondAttribute = NSLayoutAttributeNotAnAttribute;
    } else {
        self.secondItem = view;
        self.secondAttribute = self.firstAttribute;
    }
}

@end


@implementation UIView (DLSimpleAutoLayout)

- (DLSimpleViewAttribute *)dl_left {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeLeft];
}

- (DLSimpleViewAttribute *)dl_top {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeTop];
}

- (DLSimpleViewAttribute *)dl_right {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeRight];
}

- (DLSimpleViewAttribute *)dl_bottom {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeBottom];
}

- (DLSimpleViewAttribute *)dl_leading {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeLeading];
}

- (DLSimpleViewAttribute *)dl_trailing {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeTrailing];
}

- (DLSimpleViewAttribute *)dl_width {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeWidth];
}

- (DLSimpleViewAttribute *)dl_height {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeHeight];
}

- (DLSimpleViewAttribute *)dl_centerX {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeCenterX];
}

- (DLSimpleViewAttribute *)dl_centerY {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeCenterY];
}

- (DLSimpleViewAttribute *)dl_baseline {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeBaseline];
}

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (DLSimpleViewAttribute *)dl_leftMargin {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeLeftMargin];
}

- (DLSimpleViewAttribute *)dl_rightMargin {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeRightMargin];
}

- (DLSimpleViewAttribute *)dl_topMargin {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeTopMargin];
}

- (DLSimpleViewAttribute *)dl_bottomMargin {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeBottomMargin];
}

- (DLSimpleViewAttribute *)dl_leadingMargin {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeLeadingMargin];
}

- (DLSimpleViewAttribute *)dl_trailingMargin {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeTrailingMargin];
}

- (DLSimpleViewAttribute *)dl_centerXWithinMargins {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeCenterXWithinMargins];
}

- (DLSimpleViewAttribute *)dl_centerYWithinMargins {
    return [[DLSimpleViewAttribute alloc] initWithView:self attribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif
@end

@implementation NSArray (DLSimpleAutoLayout)

- (NSArray<NSLayoutConstraint *> * (^)())dl_constraint_install {
    return ^NSArray<NSLayoutConstraint *> *() {
        NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:self.count];
        for (DLSimpleViewAttribute *item in self) {
            if ([item isKindOfClass:[DLSimpleViewAttribute class]]) {
                [resultArray addObject:item.install()];
            }
        }
        return resultArray.copy;
    };
}

@end



