import XCTest
import PreciseDecimal

final class InitTests: XCTestCase {
    func testIntegers() {
        assertInteger(0, "0")
        assertInteger(1, "1")
        assertInteger(2, "2")
        assertInteger(3, "3")
        assertInteger(4, "4")
        assertInteger(5, "5")
        assertInteger(6, "6")
        assertInteger(7, "7")
        assertInteger(8, "8")
        assertInteger(9, "9")
        assertInteger(10, "10")
        assertInteger(42, "42")
        assertInteger(100, "100")
        assertInteger(69420, "69420")

        assertLiteral(0, "0")
        assertLiteral(1, "1")
        assertLiteral(2, "2")
        assertLiteral(3, "3")
        assertLiteral(4, "4")
        assertLiteral(5, "5")
        assertLiteral(6, "6")
        assertLiteral(7, "7")
        assertLiteral(8, "8")
        assertLiteral(9, "9")
        assertLiteral(10, "10")
        assertLiteral(42, "42")
        assertLiteral(100, "100")
        assertLiteral(69420, "69420")
    }

    func testOneDecimal() {
        assertDouble(0.0, "0")
        assertDouble(0.2, "0.2")
        assertDouble(0.5, "0.5")
        assertDouble(0.7, "0.7")
        assertDouble(1.0, "1")
        assertDouble(1.2, "1.2")
        assertDouble(1.5, "1.5")
        assertDouble(420.6, "420.6")
        assertDouble(42069.4, "42069.4")

        assertLiteral(0.0, "0")
        assertLiteral(0.2, "0.2")
        assertLiteral(0.5, "0.5")
        assertLiteral(0.7, "0.7")
        assertLiteral(1.0, "1")
        assertLiteral(1.2, "1.2")
        assertLiteral(1.5, "1.5")
        assertLiteral(420.6, "420.6")
        assertLiteral(42069.4, "42069.4")
    }

    func testTwoDecimals() {
        assertDouble(0.00, "0")
        assertDouble(0.25, "0.25")
        assertDouble(0.50, "0.5")
        assertDouble(0.75, "0.75")
        assertDouble(1.00, "1")
        assertDouble(1.25, "1.25")
        assertDouble(1.50, "1.5")

        assertLiteral(0.00, "0")
        assertLiteral(0.25, "0.25")
        assertLiteral(0.50, "0.5")
        assertLiteral(0.75, "0.75")
        assertLiteral(1.00, "1")
        assertLiteral(1.25, "1.25")
        assertLiteral(1.50, "1.5")
    }

    func testThreeDecimals() {
        assertDouble(1.111, "1.111")
        assertDouble(2.222, "2.222")
        assertDouble(3.133, "3.133")
        assertDouble(3.333, "3.333")
        assertDouble(69.420, "69.42")
        assertDouble(69.421, "69.421")

        assertLiteral(1.111, "1.111")
        assertLiteral(2.222, "2.222")
        assertLiteral(3.133, "3.133")
        assertLiteral(3.333, "3.333")
        assertLiteral(69.420, "69.42")
        assertLiteral(69.421, "69.421")
    }
}

private extension InitTests {
    func assertInteger<I: FixedWidthInteger>(_ integer: I, _ string: String, line: UInt = #line) {
        assertDecimal(
            PreciseDecimal(integer).value,
            string,
            line: line
        )
        assertDecimal(
            Decimal(precise: integer),
            string,
            line: line
        )
    }

    func assertDouble(_ double: Double, _ string: String, line: UInt = #line) {
        assertDecimal(
            PreciseDecimal(double).value,
            string,
            line: line
        )
        assertDecimal(
            Decimal(precise: double),
            string,
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
            Self.formatter.string(for: decimal),
            string,
            line: line
        )
    }

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.numberStyle = .decimal
        formatter.hasThousandSeparators = false
        formatter.alwaysShowsDecimalSeparator = false
        return formatter
    }()
}
