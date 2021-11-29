import Foundation

public struct PreciseDecimal {
    public var value: Decimal

    public init?(string: String) {
        guard let decimal = Decimal(string: string) else {
            return nil
        }
        self.value = decimal
    }
}

extension PreciseDecimal: Hashable {}

extension PreciseDecimal: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        guard let _self = Self(string: value) else {
            fatalError("Invalid PreciseDecimal string literal: \(value)")
        }
        self = _self
    }
}

extension PreciseDecimal: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let _self = Self(string: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid PreciseDecimal JSON string value: \(rawValue)"
            )
        }
        self = _self
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(String(self))
    }
}

extension PreciseDecimal: LosslessStringConvertible {
    public init?(_ description: String) {
        self.init(string: description)
    }

    public var description: String {
        NSDecimalNumber(decimal: value).stringValue
    }
}
