//
//  LocationRequest.swift
//  RMApp
//
//  Created by Onur Duyar on 1.04.2023.
//

import Foundation
// https://api.orhanaydogdu.com.tr/deprem/kandilli/live
struct APIRequest: DataRequest {
    typealias Response = APIResponse
    
    var baseURL: String {
        "https://api.orhanaydogdu.com.tr"
    }
    var url: String{
        Endpoint.API.rawValue
    }
    var method: HTTPMethod {
        .get
    }
    func decode(_ data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
}
