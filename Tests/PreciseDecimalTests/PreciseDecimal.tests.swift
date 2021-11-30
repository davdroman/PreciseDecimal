import PreciseDecimal
import XCTest

final class PreciseDecimalTests: XCTestCase {
    func testInit() throws {
        try assert("-", "0")
        try assert("+", "0")
        try assert("-NaN", "0")
        try assert("+NaN", "0")
        try assert("-abc", "0")
        try assert("+abc", "0")
        
        try assert("0")
        try assert("1")
        try assert("2")
        try assert("3")
        try assert("9")
        try assert("10")
        try assert("42")
        try assert("100")
        try assert("69420")

        try assert("0.0")
        try assert("0.2")
        try assert("0.5")
        try assert("0.7")
        try assert("1.0")
        try assert("1.2")
        try assert("1.5")
        try assert("420.6")
        try assert("42069.4")

        try assert("0.00")
        try assert("0.25")
        try assert("0.50")
        try assert("0.75")
        try assert("1.00")
        try assert("1.25")
        try assert("1.50")

        try assert("1.111")
        try assert("2.222")
        try assert("3.133")
        try assert("3.333")
        try assert("69.420")
        try assert("69.421")

        try assert("1234567890.0123456789")

        try assertNil("")
        try assertNil("abc")
        try assertNil("NaN")
    }
}

private extension PreciseDecimalTests {
    func assert(_ sut: StringLiteralType, _ expected: String, line: UInt = #line) throws {
        let normalSUT = try XCTUnwrap(PreciseDecimal(string: sut))
        let literalSUT = PreciseDecimal(stringLiteral: sut)
        XCTAssertEqual(normalSUT.value, Decimal(string: sut), line: line)
        XCTAssertEqual(literalSUT.value, Decimal(string: sut), line: line)
    }

    func assert(_ sut: StringLiteralType, line: UInt = #line) throws {
        try assert(sut, sut, line: line)
    }

    func assertNil(_ sut: StringLiteralType, line: UInt = #line) throws {
        XCTAssertNil(PreciseDecimal(string: sut), line: line)
    }
}
