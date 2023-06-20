//
//  TabBarController.swift
//  Deprem
//
//  Created by Onur Duyar on 16.04.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
      
        let firstVC = EarthQuakeListVC()
        let firstNavVC = UINavigationController(rootViewController: firstVC)
        firstNavVC.title = "Deprem Listesi"
        firstNavVC.tabBarItem.image = UIImage(systemName: "info.bubble")
        firstNavVC.tabBarItem.selectedImage = UIImage(systemName: "info.bubble.fill")
        
    
        let secondVC = MapVC()
        let secondNavVC = UINavigationController(rootViewController: secondVC)
        secondNavVC.title = "Isı Haritası"
        secondNavVC.tabBarItem.image = UIImage(systemName: "map")?.withRenderingMode(.alwaysOriginal)
        secondNavVC.tabBarItem.selectedImage = UIImage(systemName: "map.fill")?.withRenderingMode(.alwaysOriginal)
        
    
        let thirdVC = HelpVC()
        let thirdNavVC = UINavigationController(rootViewController: thirdVC)
        thirdNavVC.title = "Yardım"
        thirdNavVC.tabBarItem.image = UIImage(systemName: "cross.circle")
        thirdNavVC.tabBarItem.selectedImage = UIImage(systemName: "cross.circle.fill")
    
        self.viewControllers = [firstNavVC, secondNavVC, thirdNavVC]
        self.selectedIndex = 1
    }
}
