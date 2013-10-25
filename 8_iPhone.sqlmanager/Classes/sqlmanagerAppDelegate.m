//
//  sqlmanagerAppDelegate.m
//  sqlmanager
//
//  Created by HoChul Shin on 10. 5. 1..
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "sqlmanagerAppDelegate.h"
#import "sqlmanagerViewController.h"

@implementation sqlmanagerAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
