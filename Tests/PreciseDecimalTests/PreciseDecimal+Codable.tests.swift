import PreciseDecimal
import XCTJSONKit

//final class PreciseDecimalCodableTests: XCTestCase {
//    func testEncoding() throws {
//        try XCTAssertJSONEncoding("0" as PreciseDecimal, .string("0"))
//        try XCTAssertJSONEncoding("3.133" as PreciseDecimal, .string("3.133"))
//        try XCTAssertJSONEncoding("-3.133" as PreciseDecimal, .string("-3.133"))
//        try XCTAssertJSONEncoding("1234567890.0123456789" as PreciseDecimal, .string("1234567890.0123456789"))
//        try XCTAssertJSONEncoding("-1234567890.0123456789" as PreciseDecimal, .string("-1234567890.0123456789"))
//    }
//
//    func testDecoding() throws {
//        try XCTAssertJSONDecoding(.string("3.133"), PreciseDecimal(string: "3.133"))
//        XCTAssertThrowsError(try XCTAssertJSONDecoding(.number(try XCTUnwrap(Decimal(string: "3.133"))), "3.133" as PreciseDecimal))
//        XCTAssertThrowsError(try XCTAssertJSONDecoding(.null, "3.133" as PreciseDecimal))
//        XCTAssertThrowsError(try XCTAssertJSONDecoding(.raw("{}"), "3.133" as PreciseDecimal))
//    }
//}
