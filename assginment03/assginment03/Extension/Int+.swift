//
//  Int+.swift
//  assginment03
//
//  Created by JIN on 11/13/25.
//

import UIKit

extension Int {
    func formattedWithComma() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
