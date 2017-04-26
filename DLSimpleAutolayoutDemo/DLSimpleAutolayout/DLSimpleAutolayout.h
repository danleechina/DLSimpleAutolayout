//
//  DLSimpleAutolayout.h
//  DLSimpleAutolayoutDemo
//
//  Created by Dan.Lee on 2017/4/26.
//  Copyright © 2017年 Dan Lee. All rights reserved.
//

@import UIKit;

@interface DLSimpleViewAttribute : NSObject

@property (nonatomic, strong, readonly) DLSimpleViewAttribute *(^equalTo)(id view);
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *(^lessThanOrEqualTo)(id view);
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *(^greaterThanOrEqualTo)(id view);
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *(^multipliedBy)(CGFloat multipier);
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *(^offset)(CGFloat offset);
@property (nonatomic, strong, readonly) NSLayoutConstraint *(^install)();

@end


@interface UIView (DLSimpleAutoLayout)

@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_left;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_top;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_right;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_bottom;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_leading;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_trailing;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_width;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_height;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_centerX;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_centerY;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_baseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_leftMargin;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_rightMargin;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_topMargin;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_bottomMargin;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_leadingMargin;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_trailingMargin;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_centerXWithinMargins;
@property (nonatomic, strong, readonly) DLSimpleViewAttribute *dl_centerYWithinMargins;

#endif
@end

@interface NSArray (DLSimpleAutoLayout)

@property (nonatomic, strong, readonly) NSArray<NSLayoutConstraint *> * (^dl_constraint_install)();

@end

