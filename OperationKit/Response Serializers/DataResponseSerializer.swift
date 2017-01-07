//
//  DataResponseSerializer.swift
//  OperationKit
//
//  Created by Jorge Orjuela on 1/7/17.
//  Copyright © 2017 Chessclub. All rights reserved.
//

import Foundation

public struct DataResponseSerializer: ResponseSerializer {

    // MARK: ResponseSerializer
    
    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data) -> Result<Data> {
        guard let response = response, emptyResponseCodes.contains(response.statusCode) else { return .success(data) }
        
        guard data.count > 0 else {
            return .failure(SerializationFailure.inputDataNilOrZeroLength)
        }
        
        return .success(data)
    }
}
