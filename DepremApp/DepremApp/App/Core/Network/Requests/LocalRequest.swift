//
//  LocalRequest.swift
//  DepremApp
//
//  Created by Onur Duyar on 18.06.2023.
//

import Foundation

struct LocalRequest: DataRequest {
    typealias Response = [Help]
    
    var baseURL: String {
        ""
    }
    var url: String {
        guard let fileURL = Bundle.main.url(forResource: "helpdata", withExtension: "json") else {
            fatalError(ErrorResponse.fileNotFound.rawValue)
        }
        return fileURL.absoluteString
    }
    var method: HTTPMethod {
        .get
    }
    func decode(_ data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
}
