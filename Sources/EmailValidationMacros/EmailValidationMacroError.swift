enum EmailValidationMacroError: Error, CustomStringConvertible {
    case requiresStaticStringLiteral
    case malformedEmail
    
    var description: String {
        switch self {
        case .requiresStaticStringLiteral:
            "Requires a static string literal"
        case .malformedEmail:
            "The input email is malformed"
        }
    }
}
