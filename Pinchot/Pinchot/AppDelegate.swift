//
//  AppDelegate.swift
//  Pinchot
//
//  Created by Andrew Shepard on 10/21/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Find the nav controller in the view controller stack
        // and set ourselves as the delegate
        let navController = self.window!.rootViewController as UINavigationController
        navController.delegate = self
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // This is called whenever during all navigation operations
        
        // Only return a custom animator for two view controller types
        if let mainViewController = fromVC as? ViewController {
            let animator = ShowImageAnimator()
            animator.origin = mainViewController.origin
            
            return animator
        }
        else if let imageViewController = fromVC as? ImageViewController {
            let animator = HideImageAnimator()
            animator.origin = imageViewController.reverseOrigin
            
            return animator
        }
        
        // All other types use default transition
        return nil
    }
}

