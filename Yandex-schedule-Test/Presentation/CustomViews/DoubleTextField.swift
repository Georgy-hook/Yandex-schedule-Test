//
//  DoubleTextField.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 14.12.2023.
//

import UIKit

class DoubleTextField: UIView {
    
    // MARK: - UI Elements
    private let fromTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Откуда"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let toTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Куда"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "DoubleArrows"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.cornerRadius = 5
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        addSubview(fromTextField)
        addSubview(separatorView)
        addSubview(toTextField)
        addSubview(imageView)

        NSLayoutConstraint.activate([
            fromTextField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            fromTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            fromTextField.heightAnchor.constraint(equalToConstant: 30),

            separatorView.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 10),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            separatorView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),

            toTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            toTextField.heightAnchor.constraint(equalToConstant: 30),
            toTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            toTextField.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
            toTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}
