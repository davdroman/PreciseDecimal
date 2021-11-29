import PreciseDecimal
import XCTJSONKit

final class DecodingTests: XCTestCase {
    func test() throws {
        try XCTAssertJSONDecoding(JSON(raw: "1234567890.0123456789"), PreciseDecimal("1234567890.0123456789"))
        try XCTAssertJSONDecoding(
            JSON(raw: #"{ "decimal": 1234567890.0123456789 }"#),
            ["decimal": PreciseDecimal("1234567890.0123456789")]
        )
        try XCTAssertJSONDecoding(JSON(raw: #"[-5, 0, 1234567890.0123456789, 3.133, 4, 1000]"#), [
            PreciseDecimal("-5"),
            PreciseDecimal("0"),
            PreciseDecimal("1234567890.0123456789"),
            PreciseDecimal("3.133"),
            PreciseDecimal("4"),
            PreciseDecimal("1000"),
        ])
        XCTAssertThrowsError(try XCTAssertJSONDecoding(JSON(raw: #""NaN""#), PreciseDecimal?.none))
        XCTAssertThrowsError(try XCTAssertJSONDecoding(JSON(raw: ""), PreciseDecimal?.none))
    }
}

private extension DecodingTests {
    private struct DecodableModel: Decodable, Equatable {
        let decimal: PreciseDecimal
    }

    func assertDecodingSuccess(_ payload: Data, _ decimal: Decimal, line: UInt = #line) {
        XCTAssertEqual(
            try JSONDecoder().decode(PreciseDecimal.self, from: payload).value,
            decimal,
            line: line
        )
    }

    func assertDecodingFailure(_ payload: Data, line: UInt = #line) {
        XCTAssertThrowsError(
            try JSONDecoder().decode(PreciseDecimal.self, from: payload),
            line: line
        ) { error in
            switch error {
            case is DecodingError:
                break
            default:
                XCTFail("Unexpected error of type '\(type(of: error))' received", line: line)
            }
        }
    }
}
