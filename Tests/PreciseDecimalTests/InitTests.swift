import XCTest
import PreciseDecimal

final class InitTests: XCTestCase {
    func testIntegers() {
        assert(0, "0")
        assert(1, "1")
        assert(2, "2")
        assert(3, "3")
        assert(4, "4")
        assert(5, "5")
        assert(6, "6")
        assert(7, "7")
        assert(8, "8")
        assert(9, "9")
        assert(10, "10")
        assert(42, "42")
        assert(100, "100")
        assert(69420, "69420")

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
        assert(0.0, "0")
        assert(0.2, "0.2")
        assert(0.5, "0.5")
        assert(0.7, "0.7")
        assert(1.0, "1")
        assert(1.2, "1.2")
        assert(1.5, "1.5")
        assert(420.6, "420.6")
        assert(42069.4, "42069.4")

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
        assert(0.00, "0")
        assert(0.25, "0.25")
        assert(0.50, "0.5")
        assert(0.75, "0.75")
        assert(1.00, "1")
        assert(1.25, "1.25")
        assert(1.50, "1.5")

        assertLiteral(0.00, "0")
        assertLiteral(0.25, "0.25")
        assertLiteral(0.50, "0.5")
        assertLiteral(0.75, "0.75")
        assertLiteral(1.00, "1")
        assertLiteral(1.25, "1.25")
        assertLiteral(1.50, "1.5")
    }

    func testThreeDecimals() {
        assert(1.111, "1.111")
        assert(2.222, "2.222")
        assert(3.133, "3.133")
        assert(3.333, "3.333")
        assert(69.420, "69.42")
        assert(69.421, "69.421")

        assertLiteral(1.111, "1.111")
        assertLiteral(2.222, "2.222")
        assertLiteral(3.133, "3.133")
        assertLiteral(3.333, "3.333")
        assertLiteral(69.420, "69.42")
        assertLiteral(69.421, "69.421")
    }
}

private extension InitTests {
    func assertLiteral(_ preciseDecimal: PreciseDecimal, _ string: String, line: UInt = #line) {
        assertDecimal(
            preciseDecimal.value,
            string,
            line: line
        )
    }

    func assert(_ rawValue: Double, _ string: String, line: UInt = #line) {
        assertDecimal(
            PreciseDecimal(rawValue).value,
            string,
            line: line
        )
        assertDecimal(
            Decimal(precise: rawValue),
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
