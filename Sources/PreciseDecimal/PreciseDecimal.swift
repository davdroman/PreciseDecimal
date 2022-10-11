import Foundation

public struct PreciseDecimal {
    public var value: Decimal

    public init?(string: String) {
        guard let decimal = Decimal(string: string) else {
            return nil
        }
        self.value = decimal
    }

    public static func unsafe<Value>(_ value: Value) -> Self
    where Value: BinaryFloatingPoint & LosslessStringConvertible
    {
        guard let decimal = Self(string: String(value)) else {
            preconditionFailure("Failed to convert \(type(of: Value.self)) '\(value)' to Decimal")
        }
        return decimal
    }
}

extension PreciseDecimal: Hashable {}
