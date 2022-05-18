//
//  HelpScreenViewController.swift
//  Habits
//
//  Created by Alexander Thompson on 27/5/21.
//

import UIKit

class HowToUseVC: UIViewController {
    
    //MARK: - Properties
    
    let pageControl = PageControl()
    let scrollView  = ScrollView()
    
    //MARK: - Class Funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureL`ayout()
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       configureScrollView()
    }
    
    //MARK: - Functions
    
    private func configureLayout() {
        view.backgroundColor = BackgroundColors.mainBackGround
        view.addSubviews(pageControl, scrollView)

        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
            
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: view.frame.size.height / 13)
        ])
    }

    
    private func configureScrollView() {
        let numberOfPages = 6
        scrollView.contentSize     = CGSize(width: scrollView.frame.size.width * CGFloat(numberOfPages), height: scrollView.frame.size.height)
       
        for num in 0...Int(numberOfPages) - 1 {
            let page               = ScrollViewPage(frame: CGRect(x: CGFloat(num) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            page.addGradient(colors: gradients.array[num])
            page.label.text        = helpPage.helpText[num]
            page.imageView.image   = UIImage(named: helpPage.imageNames[num])
         
            scrollView.addSubview(page)
        }
    }
    
    //MARK: - @Objc Funcs
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    
}

//MARK: - ScrollView - UIScrollViewDelegate

extension HowToUseVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
    
}
