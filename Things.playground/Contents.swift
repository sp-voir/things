
//import Core
import Foundation
import PlaygroundSupport

//@dynamicMemberLookup
struct ValidationResult<Failure> where Failure: Swift.Error {
    var isValid: Bool
    var error: Failure?
}

@propertyWrapper
public struct Validation<Value, Failure>: Equatable where Value: Equatable, Failure: Swift.Error {
    
    public typealias ValidationResult = Result<Void, Failure>
    public typealias Rule = (Value) -> (ValidationResult)
    
    public var projectedValue: ValidationResult {
        rule(wrappedValue)
    }
    
    public var wrappedValue: Value {
        get { value }
        set { value = newValue }
    }
    
    private var value: Value
    private let rule: Rule
    
    public init(wrappedValue: Value, rule: @escaping Rule) {
        self.value = wrappedValue
        self.rule = rule
        self.wrappedValue = wrappedValue
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}

public enum PasswordError: Swift.Error {
    case short, noDigits, noCharacters, noUppercaseLetters, empty
}

extension Validation where Value == String, Failure == PasswordError {

    static var password: Rule {
        { value in
            guard !value.isEmpty else { return .failure(.empty) }
            
            guard !CharacterSet.letters.intersection(CharacterSet(charactersIn: value)).isEmpty else { return .failure(.noCharacters) }
            guard !CharacterSet.uppercaseLetters.intersection(CharacterSet(charactersIn: value)).isEmpty else { return .failure(.noUppercaseLetters) }
            
            guard !CharacterSet.decimalDigits.intersection(CharacterSet(charactersIn: value)).isEmpty else { return .failure(.noDigits) }
            
            guard value.count > 8 else { return .failure(.short) }
            
            return .success(())
        }
    }
}

enum PositiveError: Swift.Error {
    case negative, zero
}

protocol Validatable {
    associatedtype Value: Equatable
    associatedtype Failure: Swift.Error
    
    static var validation: (Value) -> Result<Void, Failure> { get }
}

struct PositiveValidation: Validatable {
    typealias Value = Int
    typealias Failure = PositiveError
    
    static var validation: (Value) -> Result<Void, Failure> {
        { value in
            guard value != 0 else { return .failure(.zero) }
            guard value > 0 else { return .failure(.negative) }
            return .success(())
        }
    }
}

struct State: Equatable {
    @Validation<String, PasswordError>(rule: Validation.password) var email: String = "fgSh43" //short pass
    @Validation<Int, PositiveError>(rule: PositiveValidation.validation) var numbers: Int = 1
}

var state = State()
print(state.$email)
state.email = "dfgdfgfdgdfdfg" //no uppercased
print(state.$email)

print(state.$numbers)
state.numbers = -10
print(state.$numbers)
