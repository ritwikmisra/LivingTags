//
//  TMAnnotationView.m
//  CustomCallout
//
//  Created by Tarapada.


#import "TMAnnotationView.h"
//#import "AnnotationDropDownTableViewCell.h"
//#import "CallOutView.h"
#import "AppDelegate.h"

@interface TMAnnotationView (){
    UIButton *btnUserAnnClose;
    UIButton *btnAnnAddEdit;
    UIButton *btnAnnHome;
    UIButton *btnAnnLeftNotHome;
    UIButton *btnSubmit;
    UILabel *lblAnnUpNotHome;
    UILabel *lblHome;
    UILabel *lblNote;
    UITextView *txtNote;
    UITextField *txtDesc;
    NSMutableArray *arrDisplay;
    NSString *callOutViewType;
    BOOL isOpenCallOut;
    
}


@end

@implementation TMAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier
                           pinView:(UIImageView *)pinView

{
    
    
    NSAssert(pinView != nil, @"Pinview can not be nil");
    self = [super initWithAnnotation:annotation
                     reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.clipsToBounds = NO;
        self.pinView = pinView;
        self.pinView.userInteractionEnabled = YES;
             self.pinView.frame=CGRectMake(0, 0, 34, 38);
        [self addSubview:self.pinView];
        self.frame = [self calculateFrame];
        self.backgroundColor=[UIColor clearColor];
        [self positionSubviews];
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(handleCallOutViewChange:)
//                                                 name:@"callOutViewChanged"
//                                               object:nil];
    
    return self;
}
- (CGRect)calculateFrame {
    return self.pinView.bounds;
}

- (void)positionSubviews {
    if ([callOutViewType isEqualToString:@"ShowTitle"]) {
        CGRect frame = self.pinView.frame;//CGRectMake(0, 0, 200, 200);//
        frame.origin.y = -frame.size.height+20 ;
        frame.origin.x = (self.frame.size.width - frame.size.width) ;/// 2.0
       // self.calloutView.frame = frame;
        self.pinView.frame =frame;
    }
}

/*
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self)
        return nil;
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL isCallout = (CGRectContainsPoint(self.calloutView.frame, point));
    BOOL isPin = (CGRectContainsPoint(self.pinView.frame, point));
    return isCallout || isPin;
}
 */
///*

- (void)handleCallOutViewChange:(NSNotification *)note
{
    NSDictionary *theData = [note userInfo];
    isOpenCallOut=NO;
    if (theData != nil) {
        NSNumber *n = [theData objectForKey:@"isOpenCalloutView"];
        isOpenCallOut = [n boolValue];
        NSLog(@"isOpenCallOut: %d", isOpenCallOut);
    }
}
///*
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    //UIView* hitView;
    //if (isOpenCallOut) {
       UIView* hitView = [super hitTest:point withEvent:event];
        if (hitView != nil)
         {
            [self.superview bringSubviewToFront:self];
        }
    //}
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
        CGRect rect = self.bounds;
        BOOL isInside = CGRectContainsPoint(rect, point);
        if(!isInside)
        {
            for (UIView *view in self.subviews)
            {
                isInside = CGRectContainsPoint(view.frame, point);
                if(isInside)
                    break;
            }
        }
        return isInside;
}
//*/
@end
