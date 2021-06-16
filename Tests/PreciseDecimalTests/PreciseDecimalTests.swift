import XCTest
import PreciseDecimal

final class PreciseDecimalTests: XCTestCase {
    func testExample() throws {
        let json = """
        { "amount": 46.984765 }
        """.data(using: .utf8)!

        struct Price: Decodable, Encodable {
            var amount: PreciseDecimal?
        }

        let price = try JSONDecoder().decode(Price.self, from: json)
        print("Price  ", price.amount)

//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = 6
//        let string = formatter.string(for: price.amount)!
//        Decimal(string: string)

//        let something = try JSONEncoder().encode(Price(amount: Decimal(precise: 3.133)))
//        print(String.init(data: something, encoding: .utf8)!)
    }
}
