import Foundation

public enum SSUDateError: String, Error {
    case cantGetMonth
    case cantGetYear
}

public enum DateFormat: String {
    case short = "MMMM dd"
    case yearSlashMonth = "yyyy/MM"
}

public extension Date {
    static func from(rawString: String, format: DateFormat) -> Date? {
        return from(rawString: rawString, format: format.rawValue)
    }
    
    static func from(rawString: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.date(from: rawString)
    }
    
    func string(withFormat format: DateFormat) -> String {
        return string(withFormat: format.rawValue)
    }
    
    func string(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func monthYearBasedId() throws -> String {
        let components = Calendar.current.dateComponents([.month, .year], from: self)
        guard let month = components.month else { throw SSUDateError.cantGetMonth }
        let twoDigitsMonth = try month.twoDigitString()
        guard let year = components.year else { throw SSUDateError.cantGetYear }
        return "\(year)\(twoDigitsMonth)"
    }
}
