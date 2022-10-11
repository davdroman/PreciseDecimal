import Foundation

//extension PreciseDecimal: Codable {
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        let rawValue = try container.decode(String.self)
//        guard let _self = Self(string: rawValue) else {
//            throw DecodingError.dataCorruptedError(
//                in: container,
//                debugDescription: "Invalid PreciseDecimal JSON string value: \(rawValue)"
//            )
//        }
//        self = _self
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encode(String(self))
//    }
//}
