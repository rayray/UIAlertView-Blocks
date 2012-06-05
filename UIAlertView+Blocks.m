//
//  UIAlertView+Blocks.m
//
//  Created by Sylvain Guillope on 12-06-04.
//  Copyright (c) 2012 Sylvain Guillope. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>


static char AlertViewOriginalDelegateKey;
static char AlertViewWillDismissBlock;
static char AlertViewDidDismissBlock;

@implementation UIAlertView (Blocks)


///--------------------------------------------------
/// Private Methods (Delegate)
///--------------------------------------------------
#pragma mark - Private Methods (Delegate)

- (void)_switchDelegate
{
  static BOOL delegateSwitched = NO;
  if (YES == delegateSwitched)
  {
    return;
  }
  
  // We save a reference to the original delegate and set ourself as the
  // delegate to receive the delegate callbacks
  objc_setAssociatedObject(self, &AlertViewOriginalDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
  [self setDelegate:self];
  delegateSwitched = YES;
}

- (id)_originalDelegate
{
  return objc_getAssociatedObject(self, &AlertViewOriginalDelegateKey);
}



///--------------------------------------------------
/// Blocks Management
///--------------------------------------------------
#pragma mark - Blocks Management

- (void)setOnWillDismiss:(void (^)(NSUInteger buttonIndex))block
{
  [self _switchDelegate];
  objc_setAssociatedObject(self, &AlertViewWillDismissBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setOnDidDismiss:(void (^)(NSUInteger buttonIndex))block
{
  [self _switchDelegate];
  objc_setAssociatedObject(self, &AlertViewDidDismissBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



///--------------------------------------------------
/// Alert View Delegate
///--------------------------------------------------
#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
  void (^block)(NSUInteger buttonIndex) = objc_getAssociatedObject(self, &AlertViewWillDismissBlock);
  
  if (nil != block)
  {
    block(buttonIndex);
    objc_setAssociatedObject(self, &AlertViewWillDismissBlock, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
  }
  
  id delegate = [self _originalDelegate];
  if (YES == [delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)])
  {
    [delegate alertView:alertView willDismissWithButtonIndex:buttonIndex];
  }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
  void (^block)(NSUInteger buttonIndex) = objc_getAssociatedObject(self, &AlertViewDidDismissBlock);
  
  if (nil != block)
  {
    block(buttonIndex);
    objc_setAssociatedObject(self, &AlertViewDidDismissBlock, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
  }
  
  id delegate = [self _originalDelegate];
  if (YES == [delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)])
  {
    [delegate alertView:alertView didDismissWithButtonIndex:buttonIndex];
  }
}

@end
