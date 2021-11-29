import Foundation

public struct PreciseDecimal {
    public var value: Decimal

    public init<I: FixedWidthInteger>(_ value: I) {
        self.value = Decimal(precise: value)
    }

    public init(_ value: Double) {
        self.value = Decimal(precise: value)
    }

    public init?(string: String) {
        guard let value = Decimal(string: string) else {
            return nil
        }
        self.value = value
    }
}

extension PreciseDecimal: Hashable {}

extension PreciseDecimal: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(Double(value))
    }
}

extension PreciseDecimal: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)
    }
}

extension PreciseDecimal: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        guard let _self = Self.init(string: value) else {
            fatalError("Invalid PreciseLiteral literal value: \(value)")
        }
        self = _self
    }
}

extension PreciseDecimal: CustomDebugStringConvertible {
    public var debugDescription: String { value.description }
}

extension Decimal {
    public init<I: FixedWidthInteger>(precise value: I) {
        guard let decimal = Self(string: String(value)) else {
            preconditionFailure("Failed to convert FixedWidthInteger '\(value)' to Decimal")
        }
        self = decimal
    }

    public init(precise value: Double) {
        guard let decimal = Self(string: String(value)) else {
            preconditionFailure("Failed to convert Double '\(value)' to Decimal")
        }
        self = decimal
    }
}
