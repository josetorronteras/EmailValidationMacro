import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

@main
struct EmailValidationPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        EmailValidationMacro.self,
    ]
}

/// Validates the provided email address and returns it if valid.
///
/// Example:
/// ```swift
/// // Example usage of the email validation macro
/// let validatedEmail = #email("foo@email.com")
/// print(validatedEmail) // Output: "foo@email.com"
/// ```
public struct EmailValidationMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression,
              let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
              segments.count == 1,
              case .stringSegment(let literalSegment)? = segments.first else {
            throw EmailValidationMacroError.requiresStaticStringLiteral
        }
        
        let email = literalSegment.content.text
        guard isValidEmail(email) else {
            throw EmailValidationMacroError.malformedEmail
        }
        
        return "\(argument)"
    }
}

/// Validates whether a given string is a valid email address.
///
/// - Parameter email: The string to validate as an email address.
/// - Returns: `true` if the string is a valid email address; otherwise, `false`.
///
/// - Note: This function uses a regular expression pattern to validate email addresses.
func isValidEmail(_ email: String) -> Bool {
    let emailRegex = #"^[\w\.-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*\.[a-zA-Z]{2,}$"#
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}
