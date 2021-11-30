import PreciseDecimal
import XCTest

final class PreciseDecimalDescriptionTests: XCTestCase {
    func testDescription() {
        XCTAssertEqual(String("00000" as PreciseDecimal), "0")
        XCTAssertEqual(String("00003.13300" as PreciseDecimal), "3.133")
        XCTAssertEqual(String("-00003.1330000" as PreciseDecimal), "-3.133")
        XCTAssertEqual(String("00001234567890.01234567890000" as PreciseDecimal), "1234567890.0123456789")
        XCTAssertEqual(String("-00001234567890.01234567890000" as PreciseDecimal), "-1234567890.0123456789")
    }
}
