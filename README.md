# PreciseDecimal

![CI status](https://github.com/davdroman/PreciseDecimal/workflows/CI/badge.svg)

## Introduction

Swift has long suffered a problem with its `Decimal` type: [unapparent loss of precision](https://bugs.swift.org/browse/SR-8409).

This happens with all common ways of initializing:

```swift
let badDecimal = Decimal(3.133) // 3.132999999999999488
```

```swift
let badDecimal: Decimal = 3.133 // 3.132999999999999488
```

But not these ones:

```swift
let goodDecimal = Decimal(string: "3.133") // 3.133
```

```swift
let goodDecimal = Decimal(sign: .plus, exponent: -3, significand: 3133) // 3.133
```

Furthermore, this also applies to [JSON decoding](https://bugs.swift.org/browse/SR-7054) since it uses `NSJSONSerialization` under the hood, which is presumed to parse decimal numbers as `Double` and then initializing a `Decimal` via its lossy `Double` initializer as exemplified above. A common workaround for this is to receive sensitive `Decimal` values as strings and parsing into `Decimal` with the working string initializer, however oftentimes the format of a JSON payload is out of one's control.

This is something that Apple will most likely fix at some point. In the meantime, PreciseDecimal has your back.

## Usage

This library declares a lightweight `PreciseDecimal` type as a wrapper around `Decimal`, with precise `init` and `Decodable` implementations.

```swift
let goodDecimal = PreciseDecimal(3.133) // 3.133
```

```swift
let goodDecimal: PreciseDecimal = 3.133 // 3.133
```

```swift
struct Price: Decodable {
    let amount: PreciseDecimal
}

let json = #"{ "amount": 3.133 }"#.data(using: .utf8)!
let goodDecimal = try JSONDecoder().decode(Price.self, from: json).amount // 3.133
```

## Try it out!

PreciseDecimal supports [Arena](https://github.com/finestructure/Arena) to effortlessly take it for a spin in a playground before you decide to add it to your codebase.

Simply [install Arena](https://github.com/finestructure/Arena#how-to-install-arena) and run `arena davdroman/PreciseDecimal --platform macos` in your terminal.

## FAQ

### Why isn't it also a `@propertyWrapper`?

`Decimal`s are often relied upon to accurately represent monetary values in financial applications. Given this delicate use case, I decided the most responsible way to expose this API is as a first-class struct only, to be used wherever a `Decimal` type may be declared. This strict way of offering the library ensures no loss of precision leaks through one's codebase by otherwise forgetting to annotate a `Decimal` property with `@PreciseDecimal`.

### Why doesn't it have [insert here] feature?

In order to keep the library's scope and implementation as lightweight as possible, optimistic for a painless obsolescence once Apple fixes `Decimal`.

Do feel free to [suggest otherwise](https://github.com/davdroman/PreciseDecimal/issues/new) if I missed a vital part of functionality that should *definitely* be in this library.
