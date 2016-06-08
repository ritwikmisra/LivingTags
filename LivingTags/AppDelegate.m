//
//  AppDelegate.m
//  LivingTags
//
//  Created by appsbeetech on 21/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

static NSString * const kClientID =@"254895372497-din6fimqr9gh31n616a6lmn2sf2uqord.apps.googleusercontent.com";


@interface AppDelegate ()<CLLocationManagerDelegate>
{
    @private
    Reachability *hostReachability;
    Reachability *internetReachability;
    Reachability *wifiReachability;

}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    //Change the host name here to change the server you want to monitor.
    NSString *remoteHostName = @"www.google.com";
    hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [hostReachability startNotifier];
    [self updateInterfaceWithReachability:hostReachability];
    internetReachability = [Reachability reachabilityForInternetConnection];
    [internetReachability startNotifier];
    [self updateInterfaceWithReachability:internetReachability];
    [GIDSignIn sharedInstance].clientID = kClientID;
    wifiReachability = [Reachability reachabilityForLocalWiFi];
    [wifiReachability startNotifier];
    [self updateInterfaceWithReachability:wifiReachability];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [self callLocationManager];
    return YES;
}

#pragma mark
#pragma mark CLLOCATION METHODS
#pragma mark

-(void)callLocationManager
{
    _locationManager=[[CLLocationManager alloc]init];
    _geoCoder=[[CLGeocoder alloc]init] ;
    _locationManager.delegate=self;
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest ;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [_locationManager stopUpdatingLocation];
    _location=newLocation;
    _center.latitude=_location.coordinate.latitude;
    _center.longitude=_location.coordinate.longitude;
    NSLog(@"%f,%f",_center.latitude,_center.longitude);
    NSLog(@"Resolving The Address");
    [_geoCoder reverseGeocodeLocation:_location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks:%@ error :%@",_placemark,error);
        if(error==nil && [placemarks  count]>0)
        {
            _placemark=[placemarks objectAtIndex:0] ;
            //            NSString *strAddress=[NSString stringWithFormat:@"%@ \n%@ \n%@",placemark.postalCode,placemark.administrativeArea,placemark.country];
            
            //NSLog(@"%@:%@:%@:%@:%@",strAddress,placemark.country,placemark.administrativeArea,placemark.subAdministrativeArea,placemark.subLocality) ;
            NSString *str1=[NSString stringWithFormat:@"%@,%@:%@",_placemark.subAdministrativeArea,_placemark.country,_placemark.administrativeArea];
            NSLog(@"%@",str1);
        }
        else
        {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}
#pragma mark
#pragma mark reachability helping methods
#pragma mark

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == hostReachability)
    {
        self.isRechable= [reachability connectionRequired];
    }
    
    if (reachability == internetReachability)
    {
        self.isRechable= [reachability connectionRequired];
    }
    
    if (reachability == wifiReachability)
    {
        self.isRechable= [reachability connectionRequired];
    }
    
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
            self.isRechable = NO;
            NSLog(@"Internet not rechable");
            break;
        }
        case ReachableViaWWAN:
        {
            self.isRechable=YES;
            NSLog(@"Internet rechable");
            break;
        }
        case ReachableViaWiFi:
        {
            self.isRechable=YES;
            NSLog(@"Internet rechable");
            break;
        }
    }
}
#pragma mark

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //set cookie accept policy
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (self.isFacebook==NO)
    {
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:sourceApplication
                                          annotation:annotation];
    }
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

#pragma mark
#pragma mark google delegates
#pragma mark

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "appsbee.com.LivingTags" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LivingTags" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LivingTags.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
