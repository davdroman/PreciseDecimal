import Foundation

extension PreciseDecimal: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        guard let _self = Self(string: value) else {
            fatalError("Invalid PreciseDecimal string literal: \(value)")
        }
        self = _self
    }
}
