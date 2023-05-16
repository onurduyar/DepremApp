//
//  APIResponse.swift
//  Deprem
//
//  Created by Onur Duyar on 14.04.2023.
//

import Foundation

struct APIResponse: Decodable{
    
    let status: Bool?
    let httpStatus, serverloadms: Int?
    let desc: String?
    let metadata: Metadata?
    let result: [EarthQuake]?
}
// MARK: - Metadata
struct Metadata: Decodable {
    let dateStarts, dateEnds: String?
    let total: Int?
    
    enum CodingKeys: String, CodingKey {
        case dateStarts = "date_starts"
        case dateEnds = "date_ends"
        case total
    }
}

enum LocationTz: String, Decodable {
    case europeIstanbul = "Europe/Istanbul"
}

enum Provider: String, Decodable {
    case kandilli = "kandilli"
}
