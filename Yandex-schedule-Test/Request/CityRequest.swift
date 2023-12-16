//
//  CityRequest.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 16.12.2023.
//

import Foundation

struct CityRequest: NetworkRequest {
    
    var name:String
    
    var endpoint: URL? {
        URL(string: "https://suggests.rasp.yandex.net/all_suggests?format=new&part=\(name)")
    }
    
    
}
