//
//  AppDelegate.swift
//  SearchPubChem
//
//  Created by Jae Seung Lee on 1/15/18.
//  Copyright © 2018 Jae Seung Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let dataController = DataController(modelName: "PubChemSolution")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        dataController.load()
        checkIfFirstLaunch()
        configureTabBarController()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        saveData()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: - Convenient methods
extension AppDelegate {
    func saveData() {
        do {
            try dataController.viewContext.save()
        } catch {
            NSLog("Error while saving by AppDelegate")
        }
    }
    
    func checkIfFirstLaunch() {
        if !UserDefaults.standard.bool(forKey: "HasLaunchedBefore") {
            UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
            UserDefaults.standard.synchronize()
            preloadData()
            saveData()
        }
    }
    
    func configureTabBarController() {
        let tabBarController = window?.rootViewController as! UITabBarController
        let viewControllers = tabBarController.viewControllers!
        
        for viewController in viewControllers {
            guard let navigationViewController = viewController as? UINavigationController else {
                break
            }
            
            if let topViewController = navigationViewController.topViewController as? CompoundTableViewController {
                topViewController.dataController = dataController
            } else if let topViewController = navigationViewController.topViewController as? SolutionTableViewController {
                topViewController.dataController = dataController
            }
        }
    }
    
    func preloadData() {
        do {
            try dataController.dropAllData()
        } catch {
            NSLog("Error while dropping all objects in DB")
        }
        
        // Example Compound 1: Water
        let water = Compound(context: dataController.viewContext)
        water.name = "water"
        water.firstCharacterInName = "W"
        water.formula = "H2O"
        water.molecularWeight = 18.015
        water.cid = "962"
        water.nameIUPAC = "oxidane"
        water.image = UIImagePNGRepresentation(UIImage(named: "Water")!)!
        
        // Example Compound 2: Sodium Chloride
        let sodiumChloride = Compound(context: dataController.viewContext)
        sodiumChloride.name = "sodium chloride"
        sodiumChloride.firstCharacterInName = "S"
        sodiumChloride.formula = "NaCl"
        sodiumChloride.molecularWeight = 58.44
        sodiumChloride.cid = "5234"
        sodiumChloride.nameIUPAC = "sodium chloride"
        sodiumChloride.image = UIImagePNGRepresentation(UIImage(named: "NaCl")!)
        
        // Example Solution: Sodium Chloride Aqueous Solution
        let saltyWater = Solution(context: dataController.viewContext)
        saltyWater.name = "salty water"
        saltyWater.compounds = NSSet(array: [water, sodiumChloride])
        
        let amounts = [water.name!: 1.0, sodiumChloride.name!: 0.05]
        saltyWater.amount = amounts as NSObject
    }
}
