import Foundation
import UIKit.UIColor

public enum SSUUIColorError: String, Error {
    case cantGetRGBComponents
    case cantGetColorData
    case corruptedColorData
    case cantGetColorDictionaryData
}

public extension UIColor {
    /**
     Serialize a `UIKit` color into `Data`.
     
     This function takes a color, obtaints its RGB components and serializes it into a `Data` instance using the `JSONEncoder` class.
     
     __Usage Example:__
     
     ```swift
     let redColorData = try? UIColor.red.data()
     ```
     
     - Returns: Serialized color `Data`.
     - Throws: `SSUUIColorError`
     */
    func data() throws -> Data {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            throw SSUUIColorError.cantGetRGBComponents
        }
        let colorComponents = [red, green, blue, alpha]
        return try JSONEncoder().encode(colorComponents)
    }
    
    /**
     Obtains a `UIKit` color from `Data`.
     
     This functions takes a `Data` instance and decodes it using the `JSONDecoder` class.
     
     __Usage Example:__
     
     ```swift
     guard let greenColorData = try? UIColor.green.data() else { return }
     let greenUIKitColor = try? UIColor.fromData(greenColorData)
     ```
     
     - Parameters:
        - data: `Data` serialized using the `JSONEncoder` class.
     - Returns: `UIColor` created using the serialized color components at `Data`.
     - Throws: `SSUUIColorError`
     */
    static func fromData(_ data: Data?) throws -> UIColor {
        guard let colorData = data else { throw SSUUIColorError.cantGetColorData }
        let colorComponents = try JSONDecoder().decode([CGFloat].self, from: colorData)
        guard colorComponents.count == 4 else { throw SSUUIColorError.corruptedColorData }
        return UIColor(red: colorComponents[0],
                       green: colorComponents[1],
                       blue: colorComponents[2],
                       alpha: colorComponents[3])
    }
    
    /**
     Creates a `UIColor` from a `Dictionary`
     
     This functions read all RGB color components froma `Dictionary` of type `[String: Any]` in order to return a `UIColor` instance.
     
     - Important: Your `[String: Any]` dictionary must have all the RGB color components as keys with a Float associated value.
     
     __Usage Example:__
     
     ```swift
     let colorComponents = [
        "red": 10.0,
        "green": 139.0,
        "blue": 200.0
     ]
     
     let uiColor = try? UIColor.fromDictionary(colorComponents)
     ```
     
     - Parameters:
        - dict: `[String: Any]?` that contains all the RGB color components.
     - Returns: `UIColor` using the dictionary RGB components.
     - Throws: `SSUUIColorError`
     */
    static func fromDictionary(_ dict: [String: Any]?) throws -> UIColor {
        guard let dictionary = dict,
              let red = dictionary.float(for: "red"),
              let green = dictionary.float(for: "green"),
              let blue = dictionary.float(for: "blue") else { throw SSUUIColorError.cantGetColorDictionaryData }
        return UIColor(red: CGFloat(red) / 255.0,
                       green: CGFloat(green) / 255.0,
                       blue: CGFloat(blue) / 255.0,
                       alpha: 1.0)
    }
}
