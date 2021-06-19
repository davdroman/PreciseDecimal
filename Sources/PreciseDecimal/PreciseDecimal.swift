import Foundation

public typealias PreciseDecimal = Decimal

extension Decimal {
    public init(precise value: Double) {
        guard let decimal = Self(string: String(value)) else {
            preconditionFailure("Failed to convert Double '\(value)' to Decimal")
        }
        self = decimal
    }
}

extension KeyedDecodingContainerProtocol {
    public func decode(_ type: Decimal.Type, forKey key: Self.Key) throws -> Decimal {
        try Decimal(precise: decode(Double.self, forKey: key))
    }

    public func decodeIfPresent(_ type: Decimal.Type, forKey key: Self.Key) throws -> Decimal? {
        try decodeIfPresent(Double.self, forKey: key).map(Decimal.init(precise:))
    }
}

extension UnkeyedDecodingContainer {
    mutating func decode(_ type: Decimal.Type) throws -> Decimal {
        try Decimal(precise: decode(Double.self))
    }

    mutating func decodeIfPresent(_ type: Decimal.Type) throws -> Decimal? {
        try decodeIfPresent(Double.self).map(Decimal.init(precise:))
    }
}

extension SingleValueDecodingContainer {
    func decode(_ type: Decimal.Type) throws -> Decimal {
        try Decimal(precise: decode(Double.self))
    }
}
