//
//  EarthQuake.swift
//  Deprem
//
//  Created by Onur Duyar on 30.04.2023.
//

import Foundation

// MARK: - Result
struct EarthQuake: Decodable, Equatable {
    let id, earthquakeID: String?
    let provider: Provider?
    let title, date: String?
    let mag, depth: Double?
    let geojson: Geojson?
    let locationProperties: LocationProperties?
    let rev: String?
    let dateTime: String?
    let createdAt: Int?
    let locationTz: LocationTz?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case earthquakeID = "earthquake_id"
        case provider, title, date, mag, depth, geojson
        case locationProperties = "location_properties"
        case rev
        case dateTime = "date_time"
        case createdAt = "created_at"
        case locationTz = "location_tz"
    }
    static func == (lhs: EarthQuake, rhs: EarthQuake) -> Bool {
        return lhs.earthquakeID == rhs.earthquakeID
      }
}
// MARK: - Geojson
struct Geojson: Decodable {
    let type: TypeEnum?
    let coordinates: [Double]?
}

enum TypeEnum: String, Codable {
    case point = "Point"
}

// MARK: - LocationProperties
struct LocationProperties: Decodable {
    let closestCity, epiCenter: ClosestCity?
    let closestCities: [ClosestCity]?
    let airports: [Airport]?
}

// MARK: - Airport
struct Airport: Decodable {
    let distance: Double?
    let name, code: String?
    let coordinates: Geojson?
}

// MARK: - ClosestCity
struct ClosestCity: Decodable {
    let name: String?
    let cityCode: Int?
    let distance: Double?
    let population: Int?
}
