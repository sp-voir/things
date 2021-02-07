//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

public struct UnwrappingError<T>: Error {
    public let type: T.Type
    public let function: String
    public let file: String
    public let line: Int
    
    @usableFromInline
    init(
        _ type: T.Type,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        self.type = type
        self.function = function
        self.file = file
        self.line = line
    }
    
    @inlinable
    public var localizedDescription: String {
        "Could not unwrap value of type \(type)."
    }
    
    @inlinable
    public var debugDescription: String {
        localizedDescription
            .appending("\n{")
            .appending("\n    function: \(function)")
            .appending("\n    file: \(file),")
            .appending("\n    line: \(line)")
            .appending("\n}")
    }
}
