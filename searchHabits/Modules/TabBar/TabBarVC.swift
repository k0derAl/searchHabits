import UIKit

class TabBarController: UITabBarController {
    private var secondItem: UITabBarItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupItems()
    }

    private func setupItems() {
        let firstViewController =
            UINavigationController(rootViewController: MainViewController())
        
        let firstItem = UITabBarItem(title: "Main",
                                     image: nil,
                                     tag: 0)
        firstViewController.tabBarItem = firstItem
        viewControllers =
            [firstViewController]
        self.selectedIndex = 0
    }
}

