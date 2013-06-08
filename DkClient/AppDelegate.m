//
//  AppDelegate.m
//  DkClient
//
//  Created by wangxq on 13-4-28.
//  Copyright (c) 2013年 wangxq. All rights reserved.
//

#import "AppDelegate.h"
#import "RestKit.h"
#import "ConContractInfo.h"
#import "Todo.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //begin add rk
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    //let AFNetworking manage the activity indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // Initialize HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    //we want to work with JSON-Data
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    // Initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // Setup our object mappings
    RKObjectMapping *contractMapping = [RKObjectMapping mappingForClass:[ConContractInfo class]];
    [contractMapping addAttributeMappingsFromDictionary:@{
     @"contract_no" : @"contract_no",
     @"balance"     : @"balance"
     }];
    
    //for todo mappings
    RKObjectMapping *todoMapping = [RKObjectMapping mappingForClass:[Todo class]];
    [todoMapping addAttributeMappingsFromDictionary:@{
     @"name"           : @"name",
     @"process_id"     : @"process_id",
     @"project_name"   : @"project_name",
     @"customer_name"  : @"customer_name"
     }];


    // Update date format so that we can parse Twitter dates properly
    // Wed Sep 29 15:31:08 +0000 2010
    //[RKObjectMapping addDefaultDateFormatterForString:@"E MMM d HH:mm:ss Z y" inTimeZone:nil];
    
    // Register our mappings with the provider using a response descriptor
    RKResponseDescriptor *contractResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:contractMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:@"contract"
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    RKResponseDescriptor *todoResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:todoMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:@"to_do_list"
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:contractResponseDescriptor];
    [objectManager addResponseDescriptor:todoResponseDescriptor];

    //end add rk
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
