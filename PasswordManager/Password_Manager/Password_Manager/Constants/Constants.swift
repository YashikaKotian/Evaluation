//
//  Constants.swift
//  Password_Manager
//
//  Created by Yashika on 1/11/20.
//  Copyright © 2020 Yashika. All rights reserved.
//

import Foundation
import UIKit
enum Storyboard: String {
    
    case main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func instantiateVC<T: UIViewController>(_ objectClass: T.Type) -> T {
        let sb = self.instance
        
        let className = String(describing: objectClass.self)//String.getStringOfClass(objectClass: objectClass)
        return sb.instantiateViewController(withIdentifier: className) as! T
    }
}
