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
