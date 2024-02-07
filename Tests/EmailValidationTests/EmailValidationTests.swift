import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(EmailValidationMacros)
import EmailValidationMacros

let testMacros: [String: Macro.Type] = [
    "email": EmailValidationMacro.self,
]
#endif

final class EmailValidationTests: XCTestCase {
    
    func testValidEmail() throws {
    #if canImport(EmailValidationMacros)
        assertMacroExpansion(
            """
            #email("foo@email.com")
            """,
            expandedSource:
            """
            "foo@email.com"
            """,
            macros: testMacros
        )
    #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
    }
    
    func testInvalidEmailMalformed() throws {
    #if canImport(EmailValidationMacros)
        assertMacroExpansion(
            """
            #email("invalid-email")
            """,
            expandedSource:
            """
            #email("invalid-email")
            """,
            diagnostics: [
                DiagnosticSpec(message: "The input email is malformed", line: 1, column: 1)
            ],
            macros: testMacros
        )
    #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
    }
    
    func testInvalidEmailStaticStringLiteral() throws {
    #if canImport(EmailValidationMacros)
        assertMacroExpansion(
            #"""
            #email("\(randomString(length: 2))@email.com")
            """#,
            expandedSource:
            #"""
            #email("\(randomString(length: 2))@email.com")
            """#,
            diagnostics: [
                DiagnosticSpec(message: "Requires a static string literal", line: 1, column: 1)
            ],
            macros: testMacros
        )
    #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
    }
}
