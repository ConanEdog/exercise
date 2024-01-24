//
//  Double + Extension.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/24.
//

import Foundation

extension Double {
    func toCurrencyString() -> String {
        print(self)
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: self as NSNumber)!
    }
}
