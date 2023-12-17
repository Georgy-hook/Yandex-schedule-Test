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
    
    private lazy var  transportIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "myYellow")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var  routeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold14
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var transportTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyRegular12
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  toDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyRegular12
        label.textAlignment = .right
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  toTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold20
        label.textAlignment = .right
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  toDepartureStationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyRegular12
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  fromDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyRegular12
        label.textAlignment = .left
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  fromTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold20
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  fromDepartureStationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyRegular12
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  travelTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold14
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var routeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [routeLabel, transportTypeLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateStackView, timeStackView,stationStackView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fromDateLabel, toDateLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ fromTimeLabel, travelTimeLabel, toTimeLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fromDepartureStationLabel, toDepartureStationLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Variables
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
        addSubview(routeStackView)
        addSubview(transportIconImageView)
        addSubview(mainStackView)
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            transportIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            transportIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            transportIconImageView.widthAnchor.constraint(equalToConstant: 24),
            transportIconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            routeStackView.leadingAnchor.constraint(equalTo: transportIconImageView.trailingAnchor, constant: 8),
            routeStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            routeStackView.widthAnchor.constraint(equalToConstant: 90),
            routeStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mainStackView.leadingAnchor.constraint(equalTo: routeStackView.trailingAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
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
        toDepartureStationLabel.text = segment.to
        fromDepartureStationLabel.text = segment.from
        travelTimeLabel.text = formatTravelTime(segment.duration)
        switch segment.transportType{
        case .none:
            return
        case .plane:
            transportIconImageView.image = UIImage(named: "airplane_icon")
        case .train:
            transportIconImageView.image = UIImage(named: "train_icon")
        case .suburban:
            transportIconImageView.image = UIImage(named: "tram_icon")
        case .bus:
            transportIconImageView.image = UIImage(named: "bus_icon")
        }
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
