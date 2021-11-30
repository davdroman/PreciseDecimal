import Foundation

extension PreciseDecimal: LosslessStringConvertible {
    public init?(_ description: String) {
        self.init(string: description)
    }

    public var description: String {
        NSDecimalNumber(decimal: value).stringValue
    }
}
