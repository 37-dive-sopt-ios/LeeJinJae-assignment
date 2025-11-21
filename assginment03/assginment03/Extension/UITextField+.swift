//
//  UITextField.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 10/27/25.
//

import Foundation
import UIKit

extension UITextField {
    
    func addPadding(left: CGFloat = 0, right: CGFloat = 0) {
        if left > 0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        
        if right > 0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
        
    }
        func addHorizontalPadding() {
            
            let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 16,height: self.frame.height))
            self.leftView = leftPadding
            self.leftViewMode = ViewMode.always
            
            let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: 16,height: self.frame.height))
            self.rightView = rightPadding
            self.rightViewMode = ViewMode.always
            
        }
        
        func addLeftPadding() {
            
            let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 16,height: self.frame.height))
            self.leftView = leftPadding
            self.leftViewMode = ViewMode.always
            
        }
        
        func addRightPadding() {
            
            let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: 16,height: self.frame.height))
            self.rightView = rightPadding
            self.rightViewMode = ViewMode.always
        }
    
}
