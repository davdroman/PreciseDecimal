// Playground generated with 🏟 Arena (https://github.com/finestructure/arena)
// ℹ️ If running the playground fails with an error "no such module ..."
//    go to Product -> Build to re-trigger building the SPM package.
// ℹ️ Please restart Xcode if autocomplete is not working.

import Foundation
import PreciseDecimal

// MARK: - Foundation -

let badDecimalA = Decimal(3.133)
let badDecimalB: Decimal = 3.133
let badDecimalC = NSDecimalNumber(value: 3.133).decimalValue
let badDecimalD = try JSONDecoder().decode(LossyPrice.self, from: json()).amount

let goodDecimalA = Decimal(string: "3.133")
let goodDecimalB = Decimal(sign: .plus, exponent: -3, significand: 3133)

// MARK: - PreciseDecimal -

let goodDecimalC = PreciseDecimal(3.133)
let goodDecimalD: PreciseDecimal = 3.133
let goodDecimalE = try JSONDecoder().decode(PrecisePrice.self, from: json()).amount

// MARK: - Playground Helpers -

struct LossyPrice: Decodable {
    let amount: Decimal
}

struct PrecisePrice: Decodable {
    let amount: PreciseDecimal
}

func json() -> Data { #"{ "amount": 3.133 }"#.data(using: .utf8)! }

extension PreciseDecimal: CustomStringConvertible {
    public var description: String { value.description }
}
