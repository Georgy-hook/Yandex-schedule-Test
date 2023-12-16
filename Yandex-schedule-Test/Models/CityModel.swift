//
//  CityModel.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 16.12.2023.
//

import Foundation

// MARK: - CityModel
struct CityModel: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let objID: Int
    let objType, fullTitle, title, slug: String
    let settlement, region, country, popularTitle: String
    let stationType, pointKey: String

    enum CodingKeys: String, CodingKey {
        case objID = "objId"
        case objType
        case fullTitle = "full_title"
        case title, slug, settlement, region, country
        case popularTitle = "popular_title"
        case stationType = "station_type"
        case pointKey = "point_key"
    }
}
