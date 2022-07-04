//
//  Extensions+LG.swift
//  Fairytale Spin
//
//  Created by Nick M on 20.06.2022.
//

import Foundation

extension Int {
    func addSeparator(_ separator: String?) -> String {
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        formater.groupingSeparator = separator
        return "\(formater.string(from: NSNumber(value: self)) ?? "")"
    }
    
}
