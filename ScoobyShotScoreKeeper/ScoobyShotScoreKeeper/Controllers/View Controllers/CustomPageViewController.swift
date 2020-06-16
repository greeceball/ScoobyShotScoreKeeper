//
//  CustomPageViewController.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/16/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class CustomPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    
    lazy var subViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "MainMini", bundle: nil).instantiateViewController(identifier: "ScoreKeeperViewController") as! ScoreKeeperViewController
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Data Source
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if(currentIndex <= 0) {
            return nil
        }
        return subViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if (currentIndex >= subViewControllers.count - 1) {
            return nil
        }
        return subViewControllers[currentIndex + 1]
        
    }
}
