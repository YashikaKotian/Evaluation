//
//  ScreenMAnager.swift
//  Password_Manager
//
//  Created by Yashika on 1/11/20.
//  Copyright © 2020 Yashika. All rights reserved.
//

import UIKit

class ScreenManger: NSObject {

class func loadHomeScreen() {
    UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    guard let window = appDelegate.window else { return }
    let homeVC = HomeViewController.instance
    let navigationController = UINavigationController(rootViewController: homeVC)
    navigationController.isNavigationBarHidden = true
    navigationController.navigationBar.isHidden = true
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
}
}
