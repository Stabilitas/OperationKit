//
//  StringResponseSerializer.swift
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

public struct StringResponseSerializer: ResponseSerializer {
    
    private var encoding: String.Encoding
    
    // MARK: Initialization
    
    init(encoding: String.Encoding) {
        self.encoding = encoding
    }
    
    // MARK: ResponseSerializer
    
    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data) -> Result<String> {
        guard let response = response, emptyResponseCodes.contains(response.statusCode) == false else { return .success("") }
        
        guard data.count > 0 else {
            return .failure(OperationKitError.inputDataNilOrZeroLength)
        }
        
        guard let stringResponse = String(data: data, encoding: encoding) else {
            return .failure(OperationKitError.stringSerializationFailed(encoding: encoding))
        }
        
        return .success(stringResponse)
    }
}
