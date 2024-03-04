//
//  BirthdayViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 28.02.2024.
//

import UIKit
import Combine

class BirthdayViewController: UIViewController {
    private var registerViewModel: RegisterViewModel
    private var cancellables = Set<AnyCancellable>()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.setValue(UIColor.white, forKey: "textColor")

        var maxDateComponents = DateComponents()
        maxDateComponents.year = 2018
        maxDateComponents.month = 12
        maxDateComponents.day = 31
        maxDateComponents.hour = 23
        maxDateComponents.minute = 59

        if let maxDate = Calendar.current.date(from: maxDateComponents) {
            datePicker.maximumDate = maxDate
        }

        var minDateComponents = DateComponents()
        minDateComponents.year = 1960
        minDateComponents.month = 12
        minDateComponents.day = 31
        minDateComponents.hour = 23
        minDateComponents.minute = 59

        if let minDate = Calendar.current.date(from: minDateComponents) {
            datePicker.minimumDate = minDate
        }

        return datePicker
    }()

    private lazy var nextButton: UIButton = {
        var buttonConfig = UIButton.Configuration.filled()

        buttonConfig.baseBackgroundColor = .primary100

        let buttonFont = UIFont(name: Fonts.ralewayBold.rawValue, size: 16) ?? .systemFont(ofSize: 16)

        let attributedTitle = NSAttributedString(string: "Next", attributes: [
            .font: buttonFont,
            .foregroundColor: UIColor.white
        ])

        buttonConfig.attributedTitle = AttributedString(attributedTitle)

        let button = UIButton(configuration: buttonConfig)

        return button
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 24

        return stackView
    }()

    init(registerViewModel: RegisterViewModel) {
        self.registerViewModel = registerViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        setupUI()
        setupLayout()
        setupFiledsSubscriptions()
        setupValidationsSubscriptions()
    }
}

// MARK: - Setup Layout && UI
private extension BirthdayViewController {
    func setupLayout() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(datePicker)
        contentStackView.addArrangedSubview(nextButton)

        self.view.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(
                equalTo: self.view.topAnchor),
            contentStackView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor, constant: 20.0),
            contentStackView.bottomAnchor.constraint(
                lessThanOrEqualTo: self.view.bottomAnchor),
            contentStackView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor, constant: -20.0),

            nextButton.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    func setupUI() {
        nextButton.isEnabled = false
    }
}

// MARK: - NextViewController Protocol
extension BirthdayViewController: NextViewController {
    public func setNextButtonAction(action: UIAction) {
        self.nextButton.addAction(action, for: .touchUpInside)
    }
}

// MARK: - Setup Layout && UI
private extension BirthdayViewController {
    func setupFiledsSubscriptions() {
        datePicker
            .publisher(for: \.date)
            .debounce(for: 0.4, scheduler: DispatchQueue.main)
            .sink { [weak self] date in
                guard let self else { return }
                registerViewModel.setDate(date)
            }
            .store(in: &cancellables)
    }

    func setupValidationsSubscriptions() {
        let isCorrectDate = registerViewModel.getIsCorrectDate()

        isCorrectDate
            .dropFirst()
            .sink { [weak self] isCorrect in
                guard let self else { return }
                nextButton.isEnabled = isCorrect
            }
            .store(in: &cancellables)
    }
}
