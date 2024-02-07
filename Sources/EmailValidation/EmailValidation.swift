// The Swift Programming Language
// https://docs.swift.org/swift-book

/// Macro that Validates the provided email address.
///
/// - Parameters:
///   - email: The email address to validate.
/// - Returns: The validated email address if valid.
///
/// Example:
/// ```swift
/// // Example usage of the email validation macro
/// let validatedEmail = #email("foo@email.com")
/// print(validatedEmail) // Output: "foo@email.com"
/// ```
@freestanding(expression)
public macro email(_ email: String) -> String =
    #externalMacro(module: "EmailValidationMacros", type: "EmailValidationMacro")
