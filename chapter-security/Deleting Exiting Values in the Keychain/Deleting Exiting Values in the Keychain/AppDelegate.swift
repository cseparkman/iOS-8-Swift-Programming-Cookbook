//
//  AppDelegate.swift
//  Deleting Exiting Values in the Keychain
//
//  Created by Vandad Nahavandipoor on 7/7/14.
//  Copyright (c) 2014 Pixolity Ltd. All rights reserved.
//
//  These example codes are written for O'Reilly's iOS 8 Swift Programming Cookbook
//  If you use these solutions in your apps, you can give attribution to
//  Vandad Nahavandipoor for his work. Feel free to visit my blog
//  at http://vandadnp.wordpress.com for daily tips and tricks in Swift
//  and Objective-C and various other programming languages.
//  
//  You can purchase "iOS 8 Swift Programming Cookbook" from
//  the following URL:
//  http://shop.oreilly.com/product/0636920034254.do
//
//  If you have any questions, you can contact me directly
//  at vandad.np@gmail.com
//  Similarly, if you find an error in these sample codes, simply
//  report them to O'Reilly at the following URL:
//  http://www.oreilly.com/catalog/errata.csp?isbn=0636920034254

import UIKit
import Security

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
  var window: UIWindow?

  func application(application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
      
      let keyToSearchFor = "Full Name"
      let service = NSBundle.mainBundle().bundleIdentifier!
      
      let query = [
        kSecClass as NSString :
      kSecClassGenericPassword as NSString,
        
        kSecAttrService as NSString : service,
        kSecAttrAccount as NSString : keyToSearchFor,
        ] as NSDictionary
      
      
      var result: Unmanaged<AnyObject>? = nil
      let foundExisting = Int(SecItemCopyMatching(query, &result))
      
      if foundExisting == errSecSuccess{
        
        let deleted = Int(SecItemDelete(query))
        if deleted == errSecSuccess{
          println("Successfully deleted the item")
        } else {
          println("Failed to delete the item")
        }
        
      } else {
        println("Error happened with code: \(foundExisting)")
      }
    
    return true
  }
  
}

