//
//  UIAlertView+Blocks.m
//
//  Created by Sylvain Guillope on 12-06-04.
//  Copyright (c) 2012 Sylvain Guillope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Blocks) <UIAlertViewDelegate>


/** Set the block to be called the alert view will be dismissed.
 
 @param block The block to be called.
 */
- (void)setOnWillDismiss:(void (^)(NSUInteger buttonIndex))block;

/** Set the block to be called after the alert view is dismissed.
 
 @param block The block to be called.
 */
- (void)setOnDidDismiss:(void (^)(NSUInteger buttonIndex))block;

@end
