import Foundation

public struct PreciseDecimal {
    public var value: Decimal

    public init<I: FixedWidthInteger>(_ value: I) {
        self.value = Decimal(precise: value)
    }

    public init(_ value: Double) {
        self.value = Decimal(precise: value)
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

extension PreciseDecimal: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(try container.decode(Double.self))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
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

extension NumberFormatter {
    public func string(from preciseDecimal: PreciseDecimal) -> String {
        string(from: preciseDecimal.value)
    }

    public func string(from decimal: Decimal) -> String {
        guard let string = string(from: decimal as NSDecimalNumber) else {
            preconditionFailure("Failed to format Decimal '\(decimal)'")
        }
        return string
    }
}
