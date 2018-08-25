//
//  ViewController.swift
//  ClientMap
//
//  Created by yo hishuu on 2018/07/31.
//  Copyright © 2018年 yo hishuu. All rights reserved.
//

import UIKit

class ClientViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController?
    var pageNo: Int = 0
    var pageViews = Array<UIViewController>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "訪問顧客"
        self.navigationController?.hidesBarsOnSwipe = true
        installUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func installUI() {
        let pageControllerIdentifierList : [String] = [
            "list0",
            "map0"
        ]
        
        pageControllerIdentifierList.forEach{ viewControllerName in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(viewControllerName)")
            pageViews.append(viewController)
        }
        
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([pageViews[0]], direction: .forward, animated: true, completion: {done in })
    }
    
    // MARK: - Page View Controller Data Source
    //这个协议方法会在用户向前翻页时调用 这里需要将要展示的视图控制器返回 如果返回nil 则不能够再向前翻页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var idx = viewController.view.tag
        if idx > 0 {
            idx -= 1
            self.pageNo = idx
            return pageViews[idx]
        }
        return nil
    }
    //这个协议方法会在用户向后翻页时调用 这里需要将要展示的视图控制器返回 如果返回nil 则不能够在向后翻页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var idx = viewController.view.tag
        if idx < pageViews.count - 1 {
            idx += 1
            self.pageNo = idx
            return pageViews[idx]
        }
        return nil
    }
    //设置页码数
    func presentationCount(for pageViewController: UIPageViewController) -> Int{
        return pageViews.count
    }
    //设置出初始选中的页码点
    func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        return self.pageNo
    }

}

