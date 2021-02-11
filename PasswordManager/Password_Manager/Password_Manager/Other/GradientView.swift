//
//  GradientView.swift
//  Password_Manager
//
//  Created by Yashika on 1/11/20.
//  Copyright © 2020 Yashika. All rights reserved.
//

import UIKit

class GradientView: UIView {
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
    }
}

