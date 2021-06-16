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

extension Double {
    public init(precise value: Decimal) {
        guard let double = Self(exactly: value as NSNumber) else {
            preconditionFailure("Failed to convert Decimal '\(value)' to Double")
        }
        self = double
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

extension KeyedEncodingContainerProtocol {
    mutating func encode(_ value: Decimal, forKey key: Self.Key) throws {
        try encode(Double(precise: value), forKey: key)
    }

    mutating func encodeIfPresent(_ value: Decimal?, forKey key: Self.Key) throws {
        try encodeIfPresent(value.map(Double.init(precise:)), forKey: key)
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

extension UnkeyedEncodingContainer {
    mutating func encode(_ value: Decimal) throws {
        try encode(Double(precise: value))
    }
}

extension SingleValueDecodingContainer {
    func decode(_ type: Decimal.Type) throws -> Decimal {
        try Decimal(precise: decode(Double.self))
    }
}

extension SingleValueEncodingContainer {
    mutating func encode(_ value: Decimal) throws {
        try encode(Double(precise: value))
    }
}
