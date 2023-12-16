//
//  ScheduleRequest.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 16.12.2023.
//

import Foundation

struct ScheduleRequest: NetworkRequest {
    
    var from: String
    var to: String
    var transportTypes: String
    var date:String
    
    var endpoint: URL? {
        URL(string: "https://api.rasp.yandex.net/v3.0/search/?apikey=68ce2f69-57d3-43ef-af4b-ce0a9a1d280f&format=json&from=\(from)&to=\(to)&lang=ru_RU&date=\(date)&transport_types=\(transportTypes)")
    }
}

