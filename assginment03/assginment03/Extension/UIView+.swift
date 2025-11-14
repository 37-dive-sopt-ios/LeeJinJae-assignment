//
//  UIView.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 10/26/25.
//

import Foundation
import UIKit


extension UIView {
    
    func addSubviews(_ views: UIView...) {
         views.forEach { self.addSubview($0) }
     }
}
