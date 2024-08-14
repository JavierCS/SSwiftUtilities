import Foundation

public enum SSUStringError: String, Error {
    case cantGetNumberFromCurrencyFormattedString
    case cantGetDateFromMonthYearBasedId
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
    
    /**
     Returns a `Date` from a `String` that represents a `MonthYearBasedId`.
     
     This functions takes the current `String` and validate if it is a valid `MonthYearBasedId` in order to return the `Date` for that id.
     
     __Usage Example__
     
     ```swift
     let stringDateId = "202410" // October 2024
     let date = try? stringDateId.dateFromMonthYearBasedId()
     ```
     
     - Returns: `Date` that represents month year based date for a `MonthYearBasedId`..
     - Throws: `SSUStringError`
     */
    func dateFromMonthYearBasedId() throws -> Date? {
        guard count == 6 else {
            throw SSUStringError.cantGetDateFromMonthYearBasedId
        }
        let formattedDate = "\(prefix(4))/\(suffix(2))"
        return Date.from(rawString: formattedDate, format: .yearSlashMonth)
    }
}
