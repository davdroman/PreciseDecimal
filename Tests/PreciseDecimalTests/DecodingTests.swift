import XCTest
import PreciseDecimal

final class DecodingTests: XCTestCase {
    func testDecoding() throws {
        try assertDecodingSuccess(validPayload(), PreciseDecimal("3.133"))
        try assertDecodingFailure(invalidPayload())
        try assertDecodingFailure(nullPayload())
        try assertDecodingFailure(missingPayload())
    }

    func testOptionalDecoding() throws {
        try assertOptionalDecodingSuccess(validPayload(), PreciseDecimal("3.133"))
        try assertOptionalDecodingFailure(invalidPayload())
        try assertOptionalDecodingSuccess(nullPayload(), nil)
        try assertOptionalDecodingSuccess(missingPayload(), nil)
    }
}

private extension DecodingTests {
    private struct DecodableModel: Decodable {
        let decimal: PreciseDecimal
    }

    func assertDecodingSuccess(_ payload: Data, _ decimal: PreciseDecimal, line: UInt = #line) throws {
        try XCTAssertEqual(
            JSONDecoder().decode(DecodableModel.self, from: payload).decimal,
            decimal,
            line: line
        )
    }

    func assertDecodingFailure(_ payload: Data, line: UInt = #line) throws {
        try XCTAssertThrowsError(
            JSONDecoder().decode(DecodableModel.self, from: payload),
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

    func assertOptionalDecodingSuccess(_ payload: Data, _ decimal: PreciseDecimal?, line: UInt = #line) throws {
        try XCTAssertEqual(
            JSONDecoder().decode(OptionalDecodableModel.self, from: payload).decimal,
            decimal,
            line: line
        )
    }

    func assertOptionalDecodingFailure(_ payload: Data, line: UInt = #line) throws {
        try XCTAssertThrowsError(
            JSONDecoder().decode(OptionalDecodableModel.self, from: payload),
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
    func validPayload(line: UInt = #line) throws -> Data {
        try payload(#"{ "decimal": "3.133" }"#, line: line)
    }

    func invalidPayload(line: UInt = #line) throws -> Data {
        try payload(#"{ "decimal": "abc" }"#, line: line)
    }

    func nullPayload(line: UInt = #line) throws -> Data {
        try payload(#"{ "decimal": null }"#, line: line)
    }

    func missingPayload(line: UInt = #line) throws -> Data {
        try payload("{}", line: line)
    }

    private func payload(_ rawValue: String, line: UInt = #line) throws -> Data {
        try XCTUnwrap(Data(rawValue.utf8), line: line)
    }
}
