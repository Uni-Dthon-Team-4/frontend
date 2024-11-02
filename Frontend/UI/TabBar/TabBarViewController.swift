//
//  TabBarViewController.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let firstWindow = windowScene?.windows.first
        
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.tintColor = UIColor.black
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.layer.masksToBounds = false
        
        setTabViewControllers()
        setTabBarItems()
        
        UITabBar.clearShadow()
        
        self.selectedIndex = 0
    }
    
    // MARK: - Functions
    
    /// 탭바와 연결될 뷰컨트롤러 세팅하는 함수
    private func setTabViewControllers() {
        // TODO: 각각 맡은 페이지 구현 방식에 따라 수정 필요
        let homeNavVC = UINavigationController(rootViewController: HomeViewController())
        let classNavVC = UINavigationController(rootViewController: ClassViewController())
        let searchNavVC = UINavigationController(rootViewController: SearchViewController())
        
        self.setViewControllers([homeNavVC, classNavVC, searchNavVC], animated: true)
    }
    
    /// 탭바의 각 탭 아이템들을 세팅하는 함수
    private func setTabBarItems() {
        if let items = self.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "house.fill")
            items[0].image = UIImage(systemName: "house")
            
            items[1].selectedImage = UIImage(systemName: "circle.grid.cross.fill")
            items[1].image = UIImage(systemName: "circle.grid.cross")
            
            items[2].selectedImage = UIImage(systemName: "map.fill")
            items[2].image = UIImage(systemName: "map")
            
            items[0].title = "홈"
            items[0].setTitleTextAttributes([NSAttributedString.Key.font : UIFont.Pretendard(size: 12, family: .Regular)], for: .normal)
            items[0].setTitleTextAttributes([NSAttributedString.Key.font : UIFont.Pretendard(size: 12, family: .SemiBold)], for: .selected)

            items[1].title = "클래스"
            items[1].setTitleTextAttributes([NSAttributedString.Key.font : UIFont.Pretendard(size: 12, family: .Regular)], for: .normal)
            items[1].setTitleTextAttributes([NSAttributedString.Key.font : UIFont.Pretendard(size: 12, family: .SemiBold)], for: .selected)

            items[2].title = "지도"
            items[2].setTitleTextAttributes([NSAttributedString.Key.font : UIFont.Pretendard(size: 12, family: .Regular)], for: .normal)
            items[2].setTitleTextAttributes([NSAttributedString.Key.font : UIFont.Pretendard(size: 12, family: .SemiBold)], for: .selected)
        }
    }
}
