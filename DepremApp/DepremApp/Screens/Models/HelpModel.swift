//
//  HelpModel.swift
//  DepremApp
//
//  Created by Onur Duyar on 18.06.2023.
//

import Foundation

struct Help: Decodable {
    let title: String?
    let image: String?
    let description: [String]?
}
