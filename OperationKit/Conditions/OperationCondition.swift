//
//  OperationCondition.swift
//
//  Copyright © 2016. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public let OperationConditionKey = "_operationConditionKey"

public enum OperationErrorCode: Int {
    case conditionFailed = 1
    case executionFailed = 2
}

public protocol OperationCondition {
    
    /// The name of the condition. This is used in userInfo dictionaries of `.ConditionFailed`
    static var name: String { get }
    
    /// yes if two conditions can run at the same time
    static var isMutuallyExclusive: Bool { get }
    
    /// Returns the operation dependency for the given operation
    func dependency(for operation: Operation) -> Foundation.Operation?
    
    /// Evaluate the condition, to see if it has been satisfied or not.
    func evaluate(for operation: Operation, completion: @escaping (OperationConditionResult) -> Void)
}

public enum OperationConditionResult {
    case satisfied
    case failed(Error)
    
    var error: Error? {
        switch self {
        case .failed(let error):
            return error
            
        default:
            return nil
        }
    }
}
