//
//  UIViewController+Extension.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import UIKit

protocol XibViewController {
    static var name: String { get }
    static func create() -> Self
}

extension XibViewController where Self: UIViewController {
    
    static var name: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    static func create() -> Self {
        return self.init(nibName: Self.name, bundle: nil)
    }
    
    static func present(from: UIViewController? = top(),
                        animated: Bool = true,
                        prepare: ((_ vc: Self) -> Void)? = nil,
                        completion: (() -> Void)? = nil) {
        guard let parentVC = from else { return }
        let targetVC = create()
        prepare?(targetVC)
        parentVC.present(targetVC, animated: animated, completion: completion)
    }
    
    static func push(from: UIViewController? = top(),
                     animated: Bool = true,
                     prepare: ((_ vc: Self) -> Void)? = nil,
                     completion: (() -> Void)? = nil) {
        guard let parentVC = from else { return }
        let targetVC = create()
        targetVC.hidesBottomBarWhenPushed = true
        prepare?(targetVC)
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        parentVC.navigationController?.pushViewController(targetVC, animated: animated)
        CATransaction.commit()
    }
    
    static func showDialog(size: CGSize? = nil, ratio: CGFloat = 0.8, animated: Bool = false, prepare: ((_ vc: Self) -> Void)? = nil,
                           completion: (() -> Void)? = nil) {
        guard let parentVC = top() else { return }
        let targetVC = create()
        prepare?(targetVC)
        var sizeFrame: CGSize
        if let size = size {
            sizeFrame = size
        } else {
            let sizeVC = targetVC.view.bounds.size
            sizeFrame = CGSize(width: sizeVC.width * ratio, height: sizeVC.height * ratio)
        }
        let transitioningDelegate = ModalTransitioningDelegate(from: parentVC, to: targetVC, sizeFrame, animated: animated)
        targetVC.modalPresentationStyle = .custom
        targetVC.transitioningDelegate = transitioningDelegate
        parentVC.present(targetVC, animated: animated, completion: completion)
    }
    
    static func top(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return top(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return top(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return top(controller: presented)
        }
        return controller
    }
}


class ModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var interactiveDismiss = true
    let size: CGSize
    let animated: Bool
    init(from presented: UIViewController, to presenting: UIViewController, _ size: CGSize, animated: Bool) {
        self.size = size
        self.animated = animated
        super.init()
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
}
