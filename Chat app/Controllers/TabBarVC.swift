//
//  TabBarVC.swift
//  Chat app
//
//  Created by Rustem Manafov on 09.02.23.
//

import UIKit

class TabBarVC: UITabBarController {
    
    let chatList: UIViewController
    
    init(chatList: UIViewController) {
        self.chatList = chatList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViewController()
    }

    private func setUpViewController() {
        let settings = SettingsVC()
        let nav1 = UINavigationController(rootViewController: chatList)
        let nav2 = UINavigationController(rootViewController: settings)
        
        nav1.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "message"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)

        setViewControllers([nav1, nav2], animated: true)
    }

}
