//
//  TransitionManager.swift
//  Sleep Tracker
//
//  Created by Dima Y on 13.02.2024.
//

import UIKit

final class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval

    init(duration: TimeInterval) {
        self.duration = duration
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from) as? AuthViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? LoginViewController
        else { return }
    }
}
