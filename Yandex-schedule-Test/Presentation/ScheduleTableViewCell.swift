//
//  ScheduleTableViewCell.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 15.12.2023.
//

import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    static let reuseId = "ScheduleTableViewCell"
    
    // MARK: - UI Elements
    
    private let transportIconImageView: UIImageView = {
        let imageView = UIImageView()
        // Установите изображение для иконки транспорта (например, "bus_icon")
        imageView.image = UIImage(named: "bus_icon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let routeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transportTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toDepartureStationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fromDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fromTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fromDepartureStationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let travelTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateFormatter = AppDateFormatter.shared
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout

private extension ScheduleTableViewCell {
    func addSubviews() {
        addSubview(transportIconImageView)
        addSubview(routeLabel)
        addSubview(transportTypeLabel)
        addSubview(toDateLabel)
        addSubview(toTimeLabel)
        addSubview(toDepartureStationLabel)
        addSubview(fromDateLabel)
        addSubview(fromTimeLabel)
        addSubview(fromDepartureStationLabel)
        addSubview(travelTimeLabel)
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            transportIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            transportIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            transportIconImageView.widthAnchor.constraint(equalToConstant: 24),
            transportIconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            routeLabel.leadingAnchor.constraint(equalTo: transportIconImageView.trailingAnchor, constant: 8),
            routeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            routeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            transportTypeLabel.leadingAnchor.constraint(equalTo: transportIconImageView.trailingAnchor, constant: 8),
            transportTypeLabel.topAnchor.constraint(equalTo: routeLabel.bottomAnchor, constant: 4),
            transportTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            toDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            toDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            toTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            toTimeLabel.topAnchor.constraint(equalTo: toDateLabel.bottomAnchor, constant: 4),
            
            toDepartureStationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            toDepartureStationLabel.topAnchor.constraint(equalTo: toTimeLabel.bottomAnchor, constant: 4),
            
            travelTimeLabel.trailingAnchor.constraint(equalTo: toTimeLabel.leadingAnchor, constant: -8),
            travelTimeLabel.topAnchor.constraint(equalTo: toTimeLabel.topAnchor),
            
            fromDateLabel.trailingAnchor.constraint(equalTo: travelTimeLabel.leadingAnchor, constant: -8),
            fromDateLabel.topAnchor.constraint(equalTo: toDateLabel.topAnchor),
            
            fromTimeLabel.trailingAnchor.constraint(equalTo: travelTimeLabel.leadingAnchor, constant: -8),
            fromTimeLabel.topAnchor.constraint(equalTo: toTimeLabel.topAnchor),
            
            fromDepartureStationLabel.trailingAnchor.constraint(equalTo: travelTimeLabel.leadingAnchor, constant: -8),
            fromDepartureStationLabel.topAnchor.constraint(equalTo: toDepartureStationLabel.topAnchor),
        ])
    }
}

// MARK: - Helper methods

private extension ScheduleTableViewCell {
    private func formatTravelTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        
        if hours > 0 {
            if minutes > 0 {
                return String(format: "%d ч %d мин", hours, minutes)
            } else {
                return String(format: "%d ч", hours)
            }
        } else {
            return String(format: "%d мин", minutes)
        }
    }
}

extension ScheduleTableViewCell{
    func set(with segment:SimplifiedSegment){
        routeLabel.text = segment.title
        transportTypeLabel.text = segment.transportSubtype
        toDateLabel.text = "15 дек."
        toTimeLabel.text = "14:50"
        toDepartureStationLabel.text = segment.from
        fromDateLabel.text = "15 дек."
        fromTimeLabel.text = "16:50"
        fromDepartureStationLabel.text = segment.to
        travelTimeLabel.text = formatTravelTime(segment.duration)
        guard let arrivalFormattedDate = AppDateFormatter.shared.formatFullDate(segment.arrival),
              let arrivalFormattedTime = AppDateFormatter.shared.formatTime(segment.arrival),
              let departureFormattedDate = AppDateFormatter.shared.formatFullDate(segment.departure),
              let departureFormattedTime = AppDateFormatter.shared.formatTime(segment.departure)
        else { return }
        fromDateLabel.text = departureFormattedDate
        fromTimeLabel.text = departureFormattedTime
        toDateLabel.text = arrivalFormattedDate
        toTimeLabel.text = arrivalFormattedTime
    }
}
