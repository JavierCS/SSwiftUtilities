//
//  DoubleExtension.swift
//  PFM
//
//  Created by Javier Cruz Santiago on 21/07/24.
//

import Foundation

public enum SSUDoubleError: String, Error {
    case cantLocalizeForCurrencyFormat
}

public extension Double {
    /**
     Returns a localized currency formatted string.
     
     This functions takes a `Double` value and returns that value localized and formatted using a localized currency style.
     
     __Usage Example:__
     
     ```swift
     let doubleAmount: Double = 250.0
     let currencyFormattedAmount = try? dobuleAmount.currencyFormat()
     // currencyFormattedAmount = Optional("$250.00")
     ```
     
     - Returns: `String` that represent the current value
     - Throws: `SSUDoubleError`
     */
    func currencyFormat() throws -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        guard let formatted = formatter.string(from: self as NSNumber) else {
            throw SSUDoubleError.cantLocalizeForCurrencyFormat
        }
        return formatted
    }
}
