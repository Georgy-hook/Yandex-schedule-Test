//
//  ScheduleModel.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 16.12.2023.
//

import Foundation

// MARK: - ScheduleModel
struct ScheduleModel:Codable {
    let segments: [Segment]?
}

// MARK: - Segment
struct Segment: Codable {
    let thread: Thread
    let stops: String
    let from, to: SegmentFrom
    let departurePlatform, arrivalPlatform: String
    let departureTerminal, arrivalTerminal: String?
    let duration: Int
    let hasTransfers: Bool
    let departure, arrival: String?
    let startDate: String

    enum CodingKeys: String, CodingKey {
        case thread, stops, from, to
        case departurePlatform = "departure_platform"
        case arrivalPlatform = "arrival_platform"
        case departureTerminal = "departure_terminal"
        case arrivalTerminal = "arrival_terminal"
        case duration
        case hasTransfers = "has_transfers"
        case departure, arrival
        case startDate = "start_date"
    }
}

// MARK: - SegmentFrom
struct SegmentFrom:Codable  {
    let type: String?
    let title: String?
    let shortTitle: String?
    let popularTitle: String?
    let code: String?
    let stationType: String?
    let stationTypeName: String?
    let transportType: TransportType?
}

// MARK: - Thread
struct Thread: Codable {
    let number, title, shortTitle: String
    let expressType: String?
    let transportType: TransportType?
    let carrier: Carrier?
    let uid: String
    let vehicle: String?
    let transportSubtype: TransportSubtype
    let threadMethodLink: String

    enum CodingKeys: String, CodingKey {
        case number, title
        case shortTitle = "short_title"
        case expressType = "express_type"
        case transportType = "transport_type"
        case carrier, uid, vehicle
        case transportSubtype = "transport_subtype"
        case threadMethodLink = "thread_method_link"
    }
}

// MARK: - Carrier
struct Carrier: Codable {
    let code: Int
    let title: String
    let codes: Codes?
    let address: String?
    let url: String
    let email: String?
    let contacts, phone: String
    let logo, logoSVG: String?

    enum CodingKeys: String, CodingKey {
        case code, title, codes, address, url, email, contacts, phone, logo
        case logoSVG = "logo_svg"
    }
}


// MARK: - TransportSubtype
struct TransportSubtype: Codable {
    let title, code, color: String?
}

// MARK: - Codes
struct Codes: Codable {
    let sirena, iata, icao: String?
}

// MARK: - TransportType
enum TransportType: String, Codable {
    case none = ""
    case plane
    case train
    case suburban
    case bus
}

// MARK: - SimplifiedSegment
struct SimplifiedSegment: Codable {
    let transportType: TransportType
    let title:String
    let from: String
    let to: String
    let departure: String
    let arrival: String
    let duration: Int
    let transportSubtype: String
}
