//
//  ViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 10.02.2024.
//

import UIKit

private enum ImageNames: String {
    case first = "onboarding-first"
    case second = "onboarding-second"
    case third = "onboarding-third"
}

class OnboardingViewController: UIPageViewController {
    private var pages = [UIViewController]()

    private let initialPage = 0

    private lazy var skipButton: UIButton = {
        var buttonConfig = UIButton.Configuration.plain()

        let buttonFont = UIFont(name: Fonts.ralewayBold.rawValue, size: 14) ?? .systemFont(ofSize: 14)

        let attributedString = NSAttributedString(string: "Skip", attributes: [
            .font: buttonFont,
            .foregroundColor: UIColor.grey20
        ])

        buttonConfig.attributedTitle = AttributedString(attributedString)

        let button = UIButton(configuration: buttonConfig)

        return button
    }()

    private lazy var nextButton: UIButton = {
        var buttonConfig = UIButton.Configuration.filled()

        let buttonFont = UIFont(name: Fonts.ralewayBold.rawValue, size: 16) ?? .systemFont(ofSize: 16)

        let attributedString = NSAttributedString(string: "Next", attributes: [
            .font: buttonFont,
            .foregroundColor: UIColor.white
        ])

        buttonConfig.attributedTitle = AttributedString(attributedString)

        let button = UIButton(configuration: buttonConfig)

        button.backgroundColor = .primary100

        return button
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()

        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = .grey80
        pageControl.currentPageIndicatorTintColor = .white

        return pageControl
    }()

    // MARK: Animations
    private var pageControlBottomAnchor: NSLayoutConstraint?
    private var skipButtonTopAnchor: NSLayoutConstraint?
    private var nextButtonBottomAnchor: NSLayoutConstraint?

    override func loadView() {
        super.loadView()
        setupViewControllers()
        setupUI()
    }
}

// MARK: - Setup UI
private extension OnboardingViewController {
    func setupUI() {
        self.view.backgroundColor = .grey100

        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage

        nextButton.layer.cornerRadius = 5.0
        nextButton.clipsToBounds = true

        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)

        self.view.addSubview(skipButton)
        self.view.addSubview(nextButton)
        self.view.addSubview(pageControl)

        skipButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            skipButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),

            pageControl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),

            nextButton.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 48.0),
            nextButton.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: -32.0),

            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -30.0)
        ])
    }

    func setupViewControllers() {
        self.dataSource = self
        self.delegate = self

        let firstPage = SubOnboardingViewController(
            imageName: ImageNames.first.rawValue,
            title: "It's time to renewyour sleep!",
            subTitle: nil)

        let secondPage = SubOnboardingViewController(
            imageName: ImageNames.second.rawValue,
            title: "Media library with 200+ meditations and sounds!",
            subTitle: "Enjoy the tones of sleep in dreamland with relaxing music and great stories.")

        let thirdPage = SubOnboardingViewController(
            imageName: ImageNames.third.rawValue,
            title: "Find out what you're doing in your sleep!",
            subTitle: "Check your snoring, talking in a dream, grinding teeth and all phases of sleep.")

        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(thirdPage)

        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        return currentIndex == 0 ? nil : pages[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        return currentIndex < pages.count - 1 ? pages[currentIndex + 1] : nil
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers,
              let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }

        pageControl.currentPage = currentIndex
    }
}

// MARK: - Actions
private extension OnboardingViewController {
    @objc func skipTapped(_ sender: UIButton) {
        goToAuthPage()
    }

       @objc func nextTapped(_ sender: UIButton) {
           let lastPage = pages.count - 1

           if lastPage == pageControl.currentPage {
               goToAuthPage()
           } else {
               pageControl.currentPage += 1
               goToNextPage()
           }
       }

    func goToAuthPage() {
        let authVC = AuthViewController()
        authVC.modalPresentationStyle = .fullScreen
        self.present(authVC, animated: true)
    }

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
          guard let currentPage = viewControllers?[0],
                let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }

          setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
      }
}
