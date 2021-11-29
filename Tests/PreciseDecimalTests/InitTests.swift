import XCTest
import PreciseDecimal

final class InitTests: XCTestCase {
    func testIntegers() throws {
        try assertString("0", "0")
        try assertString("1", "1")
        try assertString("2", "2")
        try assertString("3", "3")
        try assertString("4", "4")
        try assertString("5", "5")
        try assertString("6", "6")
        try assertString("7", "7")
        try assertString("8", "8")
        try assertString("9", "9")
        try assertString("10", "10")
        try assertString("42", "42")
        try assertString("100", "100")
        try assertString("69420", "69420")

        assertLiteral("0", "0")
        assertLiteral("1", "1")
        assertLiteral("2", "2")
        assertLiteral("3", "3")
        assertLiteral("4", "4")
        assertLiteral("5", "5")
        assertLiteral("6", "6")
        assertLiteral("7", "7")
        assertLiteral("8", "8")
        assertLiteral("9", "9")
        assertLiteral("10", "10")
        assertLiteral("42", "42")
        assertLiteral("100", "100")
        assertLiteral("69420", "69420")
    }

    func testOneDecimal() throws {
        try assertString("0.0", "0")
        try assertString("0.2", "0.2")
        try assertString("0.5", "0.5")
        try assertString("0.7", "0.7")
        try assertString("1.0", "1")
        try assertString("1.2", "1.2")
        try assertString("1.5", "1.5")
        try assertString("420.6", "420.6")
        try assertString("42069.4", "42069.4")

        assertLiteral("0.0", "0")
        assertLiteral("0.2", "0.2")
        assertLiteral("0.5", "0.5")
        assertLiteral("0.7", "0.7")
        assertLiteral("1.0", "1")
        assertLiteral("1.2", "1.2")
        assertLiteral("1.5", "1.5")
        assertLiteral("420.6", "420.6")
        assertLiteral("42069.4", "42069.4")
    }

    func testTwoDecimals() throws {
        try assertString("0.00", "0")
        try assertString("0.25", "0.25")
        try assertString("0.50", "0.5")
        try assertString("0.75", "0.75")
        try assertString("1.00", "1")
        try assertString("1.25", "1.25")
        try assertString("1.50", "1.5")

        assertLiteral("0.00", "0")
        assertLiteral("0.25", "0.25")
        assertLiteral("0.50", "0.5")
        assertLiteral("0.75", "0.75")
        assertLiteral("1.00", "1")
        assertLiteral("1.25", "1.25")
        assertLiteral("1.50", "1.5")
    }

    func testThreeDecimals() throws {
        try assertString("1.111", "1.111")
        try assertString("2.222", "2.222")
        try assertString("3.133", "3.133")
        try assertString("3.333", "3.333")
        try assertString("69.420", "69.42")
        try assertString("69.421", "69.421")

        assertLiteral("1.111", "1.111")
        assertLiteral("2.222", "2.222")
        assertLiteral("3.133", "3.133")
        assertLiteral("3.333", "3.333")
        assertLiteral("69.420", "69.42")
        assertLiteral("69.421", "69.421")
    }

    func testInvalidInput() {
        XCTAssertNil(PreciseDecimal(string: "abc"))
    }
}

private extension InitTests {
    func assertString(_ sut: String, _ expected: String, line: UInt = #line) throws {
        let decimal = try XCTUnwrap(PreciseDecimal(string: sut)?.value)
        assertDecimal(
            decimal,
            expected,
            line: line
        )
    }

    func assertLiteral(_ preciseDecimal: PreciseDecimal, _ string: String, line: UInt = #line) {
        assertDecimal(
            preciseDecimal.value,
            string,
            line: line
        )
    }

    private func assertDecimal(_ decimal: Decimal, _ string: String, line: UInt = #line) {
        XCTAssertEqual(
            decimal,
            Decimal(string: string),
            line: line
        )
        XCTAssertEqual(
            decimal.description,
            string,
            line: line
        )
        XCTAssertEqual(
            Self.formatter.string(from: decimal as NSDecimalNumber),
            string,
            line: line
        )
    }

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false // no thousands separator
        formatter.alwaysShowsDecimalSeparator = false
        return formatter
    }()
}
