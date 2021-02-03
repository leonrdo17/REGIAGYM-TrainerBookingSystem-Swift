//
//  MainMenuTabController.swift
//  Leonardo
//
//  Created by Leonardo on 22/05/19.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation
import UIKit

class MainMenuTabController : UITabBarController
{
    var userName : String?
    var userUsername : String?
    var userPassword : String?
    var userEmail : String?
    var userAddress : String?
    
    var selectedTabBar = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = selectedTabBar
        
        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            if let serviceMenuNavigationController = viewController as? ServiceMenuNavigationController {
                if let serviceMenuViewController = serviceMenuNavigationController.viewControllers.first as? ServiceMenuViewController {
                    serviceMenuViewController.userName = userName
                    serviceMenuViewController.userUsername = userUsername
                    serviceMenuViewController.userPassword = userPassword
                    serviceMenuViewController.userEmail = userEmail
                    serviceMenuViewController.userAddress = userAddress
                }
            }
            
            else if let informationNavigationController = viewController as? InformationNavigationController {
                if let informationViewController = informationNavigationController.viewControllers.first as? InformationViewController {
                    informationViewController.userName = userName
                    informationViewController.userUsername = userUsername
                    informationViewController.userPassword = userPassword
                    informationViewController.userEmail = userEmail
                    informationViewController.userAddress = userAddress
                }
            
                
            }
        
        }
        
    }
}

