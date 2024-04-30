import UIKit

class TabbarController: UITabBarController {
    
    var upperLineView: UIView?
    
    let indicatorDiameter: CGFloat = 8
    let spacing: CGFloat = 0
    let indicatorOffset: CGFloat = 4 // Adjust this value to change the offset

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTabbarIndicatorView(index: selectedIndex, isFirstTime: true)
    }
    
    /// Add tabbar item indicator upper line
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false){
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
            return
        }
        if let existingView = upperLineView {
            existingView.removeFromSuperview()
        }
        
        // Calculate the position of the indicator
        let iconCenterX = tabView.center.x
        var iconBottomY = tabView.frame.maxY - indicatorOffset // Adjusted for the offset
        // Adjust for the first tab
        if index == 0 {
            iconBottomY += spacing
        }
        
        upperLineView = UIView(frame: CGRect(x: iconCenterX - indicatorDiameter / 2, y: iconBottomY, width: indicatorDiameter, height: indicatorDiameter))
        upperLineView?.backgroundColor = UIColor.white
        upperLineView?.layer.cornerRadius = indicatorDiameter / 2 // Make it circular
        
        if let viewToAdd = upperLineView {
            tabBar.addSubview(viewToAdd)
        }
    }

}

extension TabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabbarIndicatorView(index: selectedIndex)
    }
}
