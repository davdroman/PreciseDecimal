import Foundation

public struct PreciseDecimal {
    public var value: Decimal

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
    public init(precise value: Double) {
        guard let decimal = Self(string: String(value)) else {
            preconditionFailure("Failed to convert Double '\(value)' to Decimal")
        }
        self = decimal
    }
}
