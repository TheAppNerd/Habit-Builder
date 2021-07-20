//
//  HelpScreenViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/21.
//

import UIKit

class HelpScreenViewController: UIViewController {

    let pageControl = PageControl()
    let scrollView = ScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      configureLayout()
        scrollView.delegate = self
    
}
    
    
    func configureLayout() {
        view.addSubview(pageControl)
        view.addSubview(scrollView)
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        pageControl.backgroundColor = .systemBlue
        
        
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),

            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        
        //scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 100)
        
        
        if scrollView.subviews.count == 2 {
            configureScrollView()
    }
    }
    
   private func configureScrollView() {
    scrollView.contentSize = CGSize(width: scrollView.frame.size.width * 3, height: scrollView.frame.size.height)
    let colors: [UIColor] = [
        //add functionality here to change view layouts
        .red,
        .brown,
        .cyan
    ]
    for x in 0...2 {
        let page = UIView(frame: CGRect(x: CGFloat(x) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
        page.backgroundColor = colors[x]
        scrollView.addSubview(page)
    }
    }
    
}

extension HelpScreenViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
    
}
