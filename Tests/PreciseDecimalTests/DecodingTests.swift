import XCTest
import PreciseDecimal

final class DecodingTests: XCTestCase {
    func testDecoding() {
        assertDecodingSuccess(payload("3.133"), Decimal(precise: 3.133))
        assertDecodingFailure(invalidPayload())
        assertDecodingFailure(nullPayload())
        assertDecodingFailure(missingPayload())
    }

    func testOptionalDecoding() {
        assertOptionalDecodingSuccess(payload("3.133"), Decimal(precise: 3.133))
        assertOptionalDecodingFailure(invalidPayload())
        assertOptionalDecodingSuccess(nullPayload(), nil)
        assertOptionalDecodingSuccess(missingPayload(), nil)
    }
}

private extension DecodingTests {
    private struct DecodableModel: Decodable {
        let decimal: PreciseDecimal
    }

    func assertDecodingSuccess(_ payload: Data, _ decimal: Decimal, line: UInt = #line) {
        XCTAssertEqual(
            try JSONDecoder().decode(DecodableModel.self, from: payload).decimal.value,
            decimal,
            line: line
        )
    }

    func assertDecodingFailure(_ payload: Data, line: UInt = #line) {
        XCTAssertThrowsError(
            try JSONDecoder().decode(DecodableModel.self, from: payload),
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

private extension DecodingTests {
    private struct OptionalDecodableModel: Decodable {
        let decimal: PreciseDecimal?
    }

    func assertOptionalDecodingSuccess(_ payload: Data, _ decimal: Decimal?, line: UInt = #line) {
        XCTAssertEqual(
            try JSONDecoder().decode(OptionalDecodableModel.self, from: payload).decimal?.value,
            decimal,
            line: line
        )
    }

    func assertOptionalDecodingFailure(_ payload: Data, line: UInt = #line) {
        XCTAssertThrowsError(
            try JSONDecoder().decode(OptionalDecodableModel.self, from: payload),
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

private extension DecodingTests {
    func payload(_ value: String) -> Data {
        Data("{ \"decimal\": \(value) }".utf8)
    }

    func invalidPayload() -> Data {
        Data(#"{ "decimal": "abc" }"#.utf8)
    }

    func nullPayload() -> Data {
        Data(#"{ "decimal": null }"#.utf8)
    }

    func missingPayload() -> Data {
        Data("{}".utf8)
    }
}
