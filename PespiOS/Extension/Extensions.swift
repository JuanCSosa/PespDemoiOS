//
//  Extensions.swift
//  PespiOS
//
//  Created by JuanSosa on 9/27/19.
//  Copyright © 2019 JuanSosa. All rights reserved.
//

import UIKit

extension UIView {
    func setShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 5
    }
}
