//
//  ViewController.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 13.12.2023.
//

import UIKit

protocol ViewControllerProtocol: UITextFieldDelegate, AnyObject{
    
}

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold17
        label.text = "Расписание пригородного и междугородного транспорта"
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var todayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сегодня", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.bodyRegular17
        button.backgroundColor = UIColor(named: "myLightGray")
        button.addBorder(to: .right, in: .lightGray, width: 1)
        button.addTarget(self, action: #selector(todayButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tomorrowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Завтра", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.bodyRegular17
        button.backgroundColor = UIColor(named: "myLightGray")
        button.addTarget(self, action: #selector(tomorrowButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var chooseDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Дата", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.bodyRegular17
        button.backgroundColor = UIColor(named: "myLightGray")
        button.addTarget(self, action: #selector(chooseDateButtonTapped), for: .touchUpInside)
        button.addBorder(to: .left, in: .lightGray, width: 1)
        return button
    }()
    
    private lazy var anyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Любой", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.bodyRegular17
        button.backgroundColor = UIColor(named: "myLightGray")
        button.addTarget(self, action: #selector(anyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var airplaneButton: UIButton = {
        let button = createTransportButton(imageName: "airplane_icon")
        return button
    }()
    
    private lazy var trainButton: UIButton = {
        let button = createTransportButton(imageName: "train_icon")
        return button
    }()
    
    private lazy var tramButton: UIButton = {
        let button = createTransportButton(imageName: "tram_icon")
        return button
    }()
    
    private lazy var busButton: UIButton = {
        let button = createTransportButton(imageName: "bus_icon")
        return button
    }()
    
    private lazy var transportStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [anyButton, airplaneButton, trainButton, tramButton, busButton])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var findButton: UIButton = {
        let button = UIButton()
        button.setTitle("Найти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.bodyRegular17
        button.backgroundColor = UIColor(named: "myYellow")
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(findButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let doubleTextField = DoubleTextField()
    private let scheduleTableView = ScheduleTableView()
    
    // MARK: - Variables
    private let scheduleService = ScheduleServiceImpl(networkClient: DefaultNetworkClient())
    private let cityService = CityServiceImpl(networkClient: DefaultNetworkClient())
    private var searchModel = SearchModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addSubviews()
        applyConstraints()
        

        
        cityService.loadCodeOfCity(name: "Коломна"){result in
            switch result{
            case .success(let city):
                print(city.items.first?.pointKey)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    // MARK: - Actions
    
    @objc private func todayButtonTapped() {
        reloadStackView()
        todayButton.backgroundColor = .gray
        todayButton.setTitleColor(.white, for: .normal)
        searchModel.date = Date()
    }
    
    @objc private func tomorrowButtonTapped() {
        reloadStackView()
        guard let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) else { return }
        tomorrowButton.backgroundColor = .gray
        tomorrowButton.setTitleColor(.white, for: .normal)
        searchModel.date = tomorrowDate
    }
    
    @objc private func chooseDateButtonTapped() {
        reloadStackView()
        chooseDateButton.backgroundColor = .gray
        chooseDateButton.setTitleColor(.white, for: .normal)
        showDatePicker()
    }
    
    @objc private func anyButtonTapped() {
        reloadTransportStackView()
        anyButton.backgroundColor = .gray
        anyButton.setTitleColor(.white, for: .normal)
        searchModel.transportType = .none
    }
    
    @objc private func transportButtonTapped(_ sender: UIButton) {
        reloadTransportStackView()
        
        switch sender {
        case airplaneButton:
            airplaneButton.backgroundColor = .gray
            searchModel.transportType = .plane
        case trainButton:
            trainButton.backgroundColor = .gray
            searchModel.transportType = .train
        case tramButton:
            tramButton.backgroundColor = .gray
            searchModel.transportType = .suburban
        case busButton:
            busButton.backgroundColor = .gray
            searchModel.transportType = .bus
        default:
            break
        }
    }
    
    @objc private func findButtonTapped() {
        guard let from = searchModel.from,
              let to = searchModel.to,
              let transportType = searchModel.transportType,
              let date = searchModel.date 
        else{ return }
        
        
        scheduleService.loadSchedule(from: from, to: to, transportTypes: transportType.rawValue, date: date){ result in
            switch result{
            case .success(let schedule):
                self.scheduleTableView.set(with: schedule)
            case .failure(let error):
                print(error)
            }
        }
    }
}


// MARK: - Layout
extension ViewController {
    private func configureUI() {
        view.backgroundColor = .white
        
        doubleTextField.delegate = self
        doubleTextField.setupDelegates()
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(doubleTextField)
        view.addSubview(stackView)
        view.addSubview(transportStackView)
        view.addSubview(findButton)
        view.addSubview(scheduleTableView)
        stackView.addArrangedSubview(todayButton)
        stackView.addArrangedSubview(tomorrowButton)
        stackView.addArrangedSubview(chooseDateButton)
        transportStackView.addArrangedSubview(anyButton)
        transportStackView.addArrangedSubview(airplaneButton)
        transportStackView.addArrangedSubview(trainButton)
        transportStackView.addArrangedSubview(tramButton)
        transportStackView.addArrangedSubview(busButton)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            doubleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            doubleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doubleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: doubleTextField.bottomAnchor, constant: 10),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            transportStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            transportStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            transportStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            transportStackView.heightAnchor.constraint(equalToConstant: 50),
            findButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            findButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            findButton.topAnchor.constraint(equalTo: transportStackView.bottomAnchor, constant: 10),
            findButton.heightAnchor.constraint(equalToConstant: 50),
            scheduleTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scheduleTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scheduleTableView.topAnchor.constraint(equalTo: findButton.bottomAnchor, constant: 8),
            scheduleTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createTransportButton(imageName: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "myLightGray")
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = .black
        button.addTarget(self, action: #selector(transportButtonTapped(_:)), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }
}

// MARK: - Helper Methods
extension ViewController {
    private func showDatePicker() {
        // Implement date picker presentation logic here
    }
    
    private func reloadStackView(){
        todayButton.backgroundColor = UIColor(named: "myLightGray")
        todayButton.setTitleColor(.black, for: .normal)
        tomorrowButton.backgroundColor = UIColor(named: "myLightGray")
        tomorrowButton.setTitleColor(.black, for: .normal)
        chooseDateButton.backgroundColor = UIColor(named: "myLightGray")
        chooseDateButton.setTitleColor(.black, for: .normal)
    }
    
    private func reloadTransportStackView() {
        anyButton.setTitleColor(.black, for: .normal)
        anyButton.backgroundColor = UIColor(named: "myLightGray")
        airplaneButton.backgroundColor = UIColor(named: "myLightGray")
        trainButton.backgroundColor = UIColor(named: "myLightGray")
        tramButton.backgroundColor = UIColor(named: "myLightGray")
        busButton.backgroundColor = UIColor(named: "myLightGray")
    }
}

extension ViewController:ViewControllerProtocol{
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cityName = textField.text else { return }
        if textField.tag == 0{
            cityService.loadCodeOfCity(name: cityName){result in
                switch result{
                case .success(let city):
                    self.searchModel.from = city.items.first?.pointKey ?? ""
                case .failure(let error):
                    print(error)
                }
            }
        } else{
            cityService.loadCodeOfCity(name: cityName){result in
                switch result{
                case .success(let city):
                    self.searchModel.to = city.items.first?.pointKey ?? ""
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
