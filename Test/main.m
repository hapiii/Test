//
//  main.m
//  Test
//
//  Created by 强王 on 2022/1/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
/*
 
 A multiplier of 0 or a nil second item together with a location for the first attribute creates an illegal constraint of a location equal to a constant. Location attributes must be specified in pairs.
 
 A multiplier of 0 or a nil second item together with a location for the first attribute creates an illegal constraint of a location equal to a constant. Location attributes must be specified in pairs.
 */
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
