//
//  sqlmanagerAppDelegate.h
//  sqlmanager
//
//  Created by HoChul Shin on 10. 5. 1..
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class sqlmanagerViewController;

@interface sqlmanagerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    sqlmanagerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet sqlmanagerViewController *viewController;

@end

