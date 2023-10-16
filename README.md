# PreciseDecimal

![CI status](https://github.com/davdroman/PreciseDecimal/workflows/CI/badge.svg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdavdroman%2FPreciseDecimal%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/davdroman/PreciseDecimal)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdavdroman%2FPreciseDecimal%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/davdroman/PreciseDecimal)

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

## FAQ

### Is this solution bullet-proof?

No.

`PreciseDecimal` falls short for very high precision numbers. Case in point:

```swift
let a = PreciseDecimal(  1234567890.0123456789 )
let b = Decimal(string: "1234567890.0123456789")!
print(a) // 1234567890.0123458
print(b) // 1234567890.0123456789
```

So if you're going to be dealing with **more than 6 decimal places, this library is not for you**. Instead, the best solution as it currently stands is to represent decimals as strings, especially when it comes to JSON serialization.

It's up to Apple and only Apple to introduce real `Decimal` literals into the language, as well as fixing the JSON serialization mechanisms in Foundation.

### Why not make it a `@propertyWrapper`?

Because it's very easy to forget to annotate properties, especially since there aren't any compiler checks or tests to ensure the slight change in behavior it provides, leading to sneaky bugs down the road.

### Why doesn't it have [x] feature?

In order to keep the library's scope and implementation as lightweight as possible, optimistic for a painless obsolescence once Apple fixes `Decimal`.

Do feel free to [suggest otherwise](https://github.com/davdroman/PreciseDecimal/issues/new) if I missed a vital part of functionality that should *definitely* be in this library.

### Will Apple ever fix this?

I don't know.

However, you're [not alone](https://forums.swift.org/t/how-to-initialize-decimal/53630) in your discontent. Here are two relevant issues you can **upvote** to improve the chances for Apple to see them:

- [SR-920](https://bugs.swift.org/browse/SR-920)
- [SR-7054](https://bugs.swift.org/browse/SR-7054)
