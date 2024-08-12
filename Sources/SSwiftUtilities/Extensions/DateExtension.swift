import Foundation

public enum SSUDateError: String, Error {
    case cantGetMonth
    case cantGetYear
}

public enum DateFormat: String {
    case short = "MMMM dd"
}

public extension Date {
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
