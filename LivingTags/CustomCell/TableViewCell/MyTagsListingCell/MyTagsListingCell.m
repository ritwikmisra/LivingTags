//
//  MyTagsListingCell.m
//  LivingTags
//
//  Created by appsbeetech on 05/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "MyTagsListingCell.h"

@implementation MyTagsListingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnEdit.layer.cornerRadius=10.0f;
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
    self.panRecognizer.delegate = self;
    [self.myForegroundContentView addGestureRecognizer:self.panRecognizer];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark
#pragma mark - UIGestureRecognizerDelegate & Methods
#pragma mark


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)panThisCell:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartPoint = [recognizer translationInView:self.myForegroundContentView];
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
            NSLog(@"Pan Began at %@", NSStringFromCGPoint(self.panStartPoint));
            break;
            
        case UIGestureRecognizerStateChanged: {
            CGPoint currentPoint = [recognizer translationInView:self.myForegroundContentView];
            CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
            BOOL panningLeft = NO;
            
            if (currentPoint.x < self.panStartPoint.x)
            {  //1
                panningLeft = YES;
            }
            
            if (self.startingRightLayoutConstraintConstant == -8)
            { //2
                //The cell was closed and is now opening
                if (!panningLeft)
                {
                    CGFloat constant = MAX(-deltaX, 0); //3
                    NSLog(@"Right->UIGestureRecognizerStateChanged: Constant: %f",constant);
                    if (constant == 0)
                    { //4
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
                    }
                    else
                    { //5
                        self.contentViewRightConstraint.constant = constant;
                    }
                }
                else
                {
                    CGFloat constant = MIN(-deltaX, [self buttonTotalWidth]); //6
                    if (constant == [self buttonTotalWidth])
                    { //7
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];
                    }
                    else
                    { //8
                        self.contentViewRightConstraint.constant = constant;
                    }
                }
            }
            else
            {
                //The cell was at least partially open.
                CGFloat adjustment = self.startingRightLayoutConstraintConstant - deltaX; //1
                if (!panningLeft)
                {
                    CGFloat constant = MAX(adjustment,0); //2
                    NSLog(@"Left->UIGestureRecognizerStateChanged: Constant: %f",constant);
                    if (constant == 0)
                    { //3
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
                    } else
                    { //4
                        self.contentViewRightConstraint.constant = constant;
                    }
                }
                else
                {
                    CGFloat constant = MIN(adjustment, [self buttonTotalWidth]); //5
                    if (constant == [self buttonTotalWidth])
                    { //6
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];
                    }
                    else
                    { //7
                        self.contentViewRightConstraint.constant = constant;
                    }
                }
            }
            
            self.contentViewLeftConstraint.constant = -self.contentViewRightConstraint.constant-16; //8
            NSLog(@"Set contentViewLeftConstraint constant %f",self.contentViewLeftConstraint.constant);
        }
            break;
            
            /*case UIGestureRecognizerStateChanged: {
             CGPoint currentPoint = [recognizer translationInView:self.myConteView];
             CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
             NSLog(@"Pan Moved %f", deltaX);
             }
             break;*/
        case UIGestureRecognizerStateEnded:
            NSLog(@"Pan Ended");
            if (self.startingRightLayoutConstraintConstant == -8)
            { //1
                //Cell was opening
                CGFloat halfOfButtonOne = CGRectGetWidth(self.deleteTextBtn.frame) / 2; //2
                if (self.contentViewRightConstraint.constant >= halfOfButtonOne) { //3
                    //Open all the way
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    //Re-close
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
            }
            else
            {
                //Cell was closing
                CGFloat buttonOnePlusHalfOfButton2 = CGRectGetWidth(self.vwDeleteButton.frame) + (CGRectGetWidth(self.vwDeleteButton.frame) / 2); //4
                if (self.contentViewRightConstraint.constant >= buttonOnePlusHalfOfButton2) { //5
                    //Re-open all the way
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    //Close
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
            }
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"Pan Cancelled");
            if (self.startingRightLayoutConstraintConstant == -8)
            {
                //Cell was closed - reset everything to 0
                [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
            } else {
                //Cell was open - reset to the open state
                [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
            }
            break;
        default:
            break;
    }
}

#pragma mark
#pragma mark - Change Constraints Methods
#pragma mark

- (CGFloat)buttonTotalWidth
{
    //return CGRectGetWidth(self.frame) - CGRectGetMinX(self.changeTextBtn.frame)-8;
    //return self.changeTextBtn.frame.size.width*2-9;
    return self.vwDeleteButton.frame.size.width-9;

}

- (void)updateConstraintsIfNeeded:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    float duration = 0;
    if (animated) {
        duration = 0.1;
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:completion];
}

- (void)resetConstraintContstantsToZero:(BOOL)animated notifyDelegateDidClose:(BOOL)notifyDelegate {
    //TODO: Notify delegate.
    
    if (self.startingRightLayoutConstraintConstant == -8 &&
        self.contentViewRightConstraint.constant == -8) {
        //Already all the way closed, no bounce necessary
        return;
    }
    
    self.contentViewRightConstraint.constant = -kBounceValue;
    self.contentViewLeftConstraint.constant = kBounceValue;
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        self.contentViewRightConstraint.constant = -8;
        self.contentViewLeftConstraint.constant = -8;
        
        NSLog(@"reset Method: Left Constant: %f",self.contentViewLeftConstraint.constant);
        NSLog(@"reset Method: Right Constant: %f",self.contentViewRightConstraint.constant);
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        }];
    }];
}

- (void)setConstraintsToShowAllButtons:(BOOL)animated notifyDelegateDidOpen:(BOOL)notifyDelegate
{
    //TODO: Notify delegate.
    //1
    if (self.startingRightLayoutConstraintConstant == [self buttonTotalWidth] && self.contentViewRightConstraint.constant == [self buttonTotalWidth])
    {
        return;
    }
    //2
    self.contentViewLeftConstraint.constant = -[self buttonTotalWidth] - kBounceValue;
    self.contentViewRightConstraint.constant = [self buttonTotalWidth] + kBounceValue;
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        //3
        self.contentViewLeftConstraint.constant = -[self buttonTotalWidth];
        self.contentViewRightConstraint.constant = +[self buttonTotalWidth];
        
        NSLog(@"setConstraints: Left Constant: %f",self.contentViewLeftConstraint.constant);
        NSLog(@"setConstraints: Right Constant: %f",self.contentViewRightConstraint.constant);
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            //4
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        }];
    }];
}

#pragma mark
#pragma mark - IBActions Methods
#pragma mark

- (IBAction)buttonClicked:(id)sender
{
    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(deleteTags:)])
    {
        [self.delegate deleteTags:sender];
    }
}


@end
