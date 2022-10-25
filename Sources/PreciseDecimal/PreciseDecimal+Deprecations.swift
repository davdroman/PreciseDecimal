import Foundation

extension PreciseDecimal {
    @available(*, deprecated, message: "PreciseDecimal.init(_:) is deprecated and has been made explicitly unsafe. Use PreciseDecimal.unsafe(_:) instead.")
    public init<I: FixedWidthInteger>(_ value: I) {
        self.value = Decimal(precise: value)
    }

    @available(*, deprecated, message: "PreciseDecimal.init(_:) loses precision past the 6th decimal place, so it is deprecated and has been made explicitly unsafe. Use PreciseDecimal.unsafe(_:) instead.")
    public init(_ value: Double) {
        self.value = Decimal(precise: value)
    }
}

extension PreciseDecimal: ExpressibleByIntegerLiteral {
    @available(*, deprecated, message: "Initialization via integer literals is deprecated and has been made explicitly unsafe. Use PreciseDecimal.unsafe(_:) instead.")
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(Double(value))
    }
}

@available(*, unavailable, message: "Initialization via floating-point literals loses precision past the 6th decimal place, so it is directly unavailable and has been made explicitly unsafe. Use string literals instead or, if you must, use StrictDecimal.unsafe(_:).")
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
    @available(*, unavailable, message: "PreciseDecimal.init(precise:) loses precision past the 6th decimal place, so it is deprecated and has been made explicitly unsafe. Use PreciseDecimal.unsafe(_:) instead.")
    public init<I: FixedWidthInteger>(precise value: I) {
        guard let decimal = Self(string: String(value)) else {
            preconditionFailure("Failed to convert FixedWidthInteger '\(value)' to Decimal")
        }
        self = decimal
    }

    @available(*, unavailable, message: "PreciseDecimal.init(precise:) loses precision past the 6th decimal place, so it is deprecated and has been made explicitly unsafe. Use PreciseDecimal.unsafe(_:) instead.")


    @available(*, unavailable, message: "Initialization via floating-point literals loses precision past the 6th decimal place, so it is directly unavailable and has been made explicitly unsafe. Use StrictDecimal.unsafe(_:) instead.")
    public init(precise value: Double) {
        guard let decimal = Self(string: String(value)) else {
            preconditionFailure("Failed to convert Double '\(value)' to Decimal")
        }
        self = decimal
    }
}

