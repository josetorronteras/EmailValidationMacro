# Email Validation Macro

[![CodeFactor](https://www.codefactor.io/repository/github/josetorronteras/emailvalidationmacro/badge)](https://www.codefactor.io/repository/github/josetorronteras/emailvalidationmacro)
[![testing](https://github.com/josetorronteras/EmailValidationMacro/actions/workflows/testing.yml/badge.svg)](https://github.com/josetorronteras/EmailValidationMacro/actions/workflows/testing.yml)

Email Validation Macro is a Swift macro framework for validating email addresses.


* [Basic Usage](#basic-usage)
* [Installation](#installation)

## Basic Usage

```swift
// Create and validate an email address
let validEmail = #email("foo@email.com")

let invalidEmail = #email("foo@.com") // ❌
```

## Installation

### Swift Package Manager

Add the following line to the dependencies in `Package.swift`:

```swift
.package(
    url: "https://github.com/josetorronteras/EmailValidationMacro",
    from: "1.0.0"
),
```

Then add `EmailValidationMacro` to your target's dependencies:

```swift
.product(
    name: "EmailValidation",
    package: "EmailValidationMacro"
),
```

### Xcode

Go to `File > Add Package Dependencies...` and paste the repo's URL:

```
https://github.com/josetorronteras/EmailValidationMacro
```

## License

This library is relased under the MIT license. See [LICENSE](LICENSE) for details.