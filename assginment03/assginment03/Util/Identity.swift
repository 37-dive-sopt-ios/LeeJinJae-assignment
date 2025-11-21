//
//  CellIdentifier.swift
//  baemin03
//
//  Created by JIN on 11/11/25.
//

import UIKit

protocol Identity {
    static var identifier: String { get }
}

extension Identity {
    static var identifier: String {
        return String(describing: self)
    }
}
