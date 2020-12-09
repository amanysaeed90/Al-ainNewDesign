import UIKit

open class SwipeMenuViewController: UIViewController, SwipeMenuViewDelegate, SwipeMenuViewDataSource {

    open var swipeMenuView: SwipeMenuView!

    open override func viewDidLoad() {
        super.viewDidLoad()
     
        swipeMenuView = SwipeMenuView(frame: view.frame)
        swipeMenuView.delegate = self
        swipeMenuView.dataSource = self
        view.addSubview(swipeMenuView)
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        swipeMenuView.willChangeOrientation()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSwipeMenuViewConstraints()
    }

    private func addSwipeMenuViewConstraints() {

       // swipeMenuView.translatesAutoresizingMaskIntoConstraints = true

//        if #available(iOS 11.0, *), view.hasSafeAreaInsets, swipeMenuView.options.tabView.isSafeAreaEnabled {
//            NSLayoutConstraint.activate([
//                swipeMenuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                swipeMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                swipeMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                swipeMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
//        } else {
//            NSLayoutConstraint.activate([
//                swipeMenuView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor),
//                swipeMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                swipeMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                swipeMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
//        }
        swipeMenuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)

    }

    // MARK: - SwipeMenuViewDelegate
    open func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) { }
    open func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) { }
    open func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) { }
    open func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) { }

    // MARK: - SwipeMenuViewDataSource

    open func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return childViewControllers.count
    }

    open func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return childViewControllers[index].title ?? ""
    }

    open func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = childViewControllers[index]
        vc.didMove(toParentViewController: self)
        return vc
    }
}

