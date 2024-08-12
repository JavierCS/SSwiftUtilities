//
//  IntExtension.swift
//  PFM
//
//  Created by Javier Cruz Santiago on 06/08/24.
//

import Foundation

public enum SSUIntError: String, Error {
    case tooLongValue
}

public extension Int {
    /**
     Returns a two digits string for `Int` values between 0-99.
     
     If the current value is between 0 and 9, this functions returns the numeric string value adding a zero.
     
     __Usage Example:__
     
     ```swift
     let twoDigitFive = try? Int(5).twoDigitString()
     // twoDigitFive = Optional("05")
     ```
     - Returns: Two digits `String` for the current `Int` value.
     - Throws: `SSUIntError`
     */
    func twoDigitString() throws -> String {
        guard self < 100, self >= 0 else { throw SSUIntError.tooLongValue }
        return self < 10 ? "0\(self)" : "\(self)"
    }
}
