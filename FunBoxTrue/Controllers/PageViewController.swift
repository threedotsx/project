import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
        override func viewDidLoad() {
            setupNavigationBar()
            super.viewDidLoad()
            self.dataSource = self
            self.showViewControllers()
           loadCategory {
                self.showViewControllers()
            }
        }
            func showViewControllers() {
                DispatchQueue.main.async {
                    if let vc = self.pageViewController(for: 0) {
                        self.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
                    
                }
            }
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            let index = ((viewController as? CategoryController)?.index ?? 0) - 1
            return self.pageViewController(for: index)
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            let index = ((viewController as? CategoryController)?.index ?? 0) + 1
            return self.pageViewController(for: index)
        }
        

        
        func pageViewController(for index: Int) -> CategoryController?{
            if index < 0 {
                return nil
           }
            if index >= categories.count {
                return nil
            }
            let vc = (storyboard?.instantiateViewController(withIdentifier: "pageController") as! CategoryController)
            vc.categoryArray = categories[index]
            vc.index = index
            return vc
        }
        func setupNavigationBar(){
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.isHidden = true
            if #available(iOS 11, *) {
                navigationController?.navigationBar.prefersLargeTitles = true
            }
            
        }

        
    }
