//
//  ViewController.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 13.12.2023.
//

import UIKit

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
    // MARK: - Variables
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addSubviews()
        applyConstraints()
    }
    
    // MARK: - Actions
    
    @objc private func todayButtonTapped() {
        reloadStackView()
        todayButton.backgroundColor = .gray
        todayButton.setTitleColor(.white, for: .normal)
    }
    
    @objc private func tomorrowButtonTapped() {
        reloadStackView()
        tomorrowButton.backgroundColor = .gray
        tomorrowButton.setTitleColor(.white, for: .normal)
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
    }

    @objc private func transportButtonTapped(_ sender: UIButton) {
        reloadTransportStackView()

        switch sender {
        case airplaneButton:
            airplaneButton.backgroundColor = .gray
        case trainButton:
            trainButton.backgroundColor = .gray
        case tramButton:
            tramButton.backgroundColor = .gray
        case busButton:
            busButton.backgroundColor = .gray
        default:
            break
        }

        // Логика для кнопок с иконками транспорта
    }
    
    @objc private func findButtonTapped() {
        // Логика для кнопки "Найти"
    }
}


// MARK: - Layout
extension ViewController {
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(doubleTextField)
        view.addSubview(stackView)
        view.addSubview(transportStackView)
        view.addSubview(findButton)
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
        ])
    }
    
    private func createTransportButton(imageName: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "myLightGray")
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
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
