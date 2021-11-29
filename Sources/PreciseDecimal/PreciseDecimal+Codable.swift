import Foundation

extension PreciseDecimal: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard let value = Self.value(in: container) else {
            throw DecodingError.valueNotFound(
                Decimal.self,
                .init(
                    codingPath: container.codingPath,
                    debugDescription: "Missing value for PreciseDecimal JSON decoding",
                    underlyingError: nil
                )
            )
        }
        guard let decimal = try Self.decimal(from: value, in: container) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unexpected value for PreciseDecimal JSON value: \(value)"
            )
        }
        self.value = decimal
    }

    private static func value(in container: SingleValueDecodingContainer) -> Any? {
        guard let storage = Mirror(reflecting: container).children.first?.value else {
            return nil
        }
        let storageMirror = Mirror(reflecting: storage)

        #if os(Linux) && compiler(>=5.5)
        guard let valueEnum = storageMirror.children.dropFirst(2).first?.value else {
            return nil
        }
        let value = Mirror(reflecting: valueEnum).children.first?.value
        #else
        guard let valuesArray = storageMirror.children.first?.value as? [Any] else {
            return nil
        }
        let value = valuesArray.first(where: { $0 is NSNumber || $0 is String })
        #endif

        return value
    }

    private static func decimal(from value: Any, in container: SingleValueDecodingContainer) throws -> Decimal? {
        switch value {
        case let value as String:
            return Decimal(string: value)
        case let value as NSDecimalNumber:
            return value.decimalValue
        case let value as NSNumber:
            return Decimal(string: value.stringValue)
        default:
            let type = Swift.type(of: value)
            throw DecodingError.typeMismatch(
                type,
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unexpected type for PreciseDecimal JSON value: \(type)",
                    underlyingError: nil
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
