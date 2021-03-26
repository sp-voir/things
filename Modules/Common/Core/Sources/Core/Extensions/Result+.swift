//
//  File.swift
//  
//
//  Created by Sergey Pugach on 22.02.21.
//

import Foundation

extension Result where Success == Void {
    public static var success: Result<Success, Failure> {
        return .success(())
    }
}
