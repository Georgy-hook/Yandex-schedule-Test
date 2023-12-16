//
//  ScheduleService.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 16.12.2023.
//

import Foundation

typealias ScheduleCompletion = (Result<[SimplifiedSegment], Error>) -> Void

protocol ScheduleService {
    func loadSchedule(from: String, to: String, transportTypes: String, date: Date, completion: @escaping ScheduleCompletion)
}

final class ScheduleServiceImpl: ScheduleService {
    private let networkClient: NetworkClient
    private let dateFormatter: AppDateFormatter
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
        self.dateFormatter = AppDateFormatter.shared
    }
    
    func loadSchedule(from: String, to: String, transportTypes: String, date: Date, completion: @escaping ScheduleCompletion) {
        let formattedDate = dateFormatter.formatDate(date)
        let request = ScheduleRequest(from: from, to: to, transportTypes: transportTypes, date: formattedDate)
        
        networkClient.send(request: request, type: ScheduleModel.self, completionQueue: .main) { result in
            switch result {
            case .success(let schedule):
                let simplifiedSegments = schedule.segments?.map { self.convertToSimplySegment(segment: $0) } ?? []
                completion(.success(simplifiedSegments))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func convertToSimplySegment(segment: Segment) -> SimplifiedSegment {
        return SimplifiedSegment(
            transportType: segment.thread.transportType ?? .none,
            title: segment.thread.title,
            from: segment.from.title ?? "",
            to: segment.to.title ?? "",
            departure: segment.departure ?? "",
            arrival: segment.arrival ?? "",
            duration: segment.duration,
            transportSubtype: segment.thread.transportSubtype.title ?? ""
        )
    }
}
