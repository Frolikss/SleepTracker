//
//  ViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 10.02.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        return progressView
    }()

    private let steps: [NextViewController] = {
        let emailStep = EmailViewController()
        let passwordStep = PasswordViewController()
        let birthdayStep = BirthdayViewController()

        return [emailStep, passwordStep, birthdayStep]
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    private var currentStep = 0

    override func loadView() {
        super.loadView()
        setupUI()
        setupLayout()
        embedAllSteps()
        updateProgress()
    }
}

// MARK: Setup Layout && UI
private extension RegisterViewController {
    func setupLayout() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(progressView)
        self.view.addSubview(containerView)

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            progressView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            progressView.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0),

            containerView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 12.0),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    func setupUI() {
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Creating an account"
        self.view.backgroundColor = .grey100

        let backBarButtonItem = UIBarButtonItem(
            title: nil,
            image: UIImage(named: "back"),
            target: self,
            action: #selector(goBackButton))
        self.navigationItem.leftBarButtonItem = backBarButtonItem

        progressView.trackTintColor = .grey60
        progressView.progressTintColor = .white
    }
}

// MARK: Steps Logic
extension RegisterViewController {
    private func embedAllSteps() {
        let action = UIAction { [weak self] _ in
            guard let self else { return }

            if currentStep < steps.count - 1 {
                steps[currentStep].view.isHidden = true
                currentStep += 1
                steps[currentStep].view.isHidden = false
                updateProgress()
            }
        }

        steps.forEach { step in
            step.view.isHidden = true
            containerView.addSubview(step.view)
            step.didMove(toParent: self)
            step.setNextButtonAction(action: action)

            step.view.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                step.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.0),
                step.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                step.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                step.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
        }
        steps.first?.view.isHidden = false
    }

    private func updateProgress() {
        let progress = Float(currentStep) / Float(steps.count - 1)
        progressView.setProgress(progress, animated: true)
    }
}

// MARK: - Actions
private extension RegisterViewController {
    @objc func goBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
