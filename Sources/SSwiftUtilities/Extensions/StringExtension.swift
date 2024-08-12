import Foundation

public enum SSUStringError: String, Error {
    case cantGetNumberFromCurrencyFormattedString
}

public extension String {
    /**
     Returns a `NSNumber` from localized currency formatted `String`.
     
     This functions localize the current `String` using the `Locale` class and extract the amount number using the `NumberFormatter` class.
     
     __Usage Example__
     
     ```swift
     let mxnCurrencyString = "$10,000.00"
     let number = mxnCurrencyString.amount()
     ```
     
     - Returns: `NSNumber` that represents te numeric value for a currency formatted `String`.
     - Throws: `SSUStringError`
     */
    func amount() throws -> NSNumber {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        guard let number = formatter.number(from: self) else {
            throw SSUStringError.cantGetNumberFromCurrencyFormattedString
        }
        return number
    }
}
