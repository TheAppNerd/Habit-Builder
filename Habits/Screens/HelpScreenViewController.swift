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
        pageControl.backgroundColor = .secondarySystemBackground
        
        
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
    let imageNames: [String] = ["addHabitImage", "mainPageImage", "habitDetailsImage"]
    let helpText: [String] = ["Create a habit you want to track",
                              """
Tap the date button to mark off
a habit or select the background
to load the habits details
""",
                             """
Tap a date on the calendar to
mark off a habit or tap edit
in the top right of the screen
to change any habit details
"""]
    
    for num in 0...2 {
        let page = UIView(frame: CGRect(x: CGFloat(num) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
        page.backgroundColor = .systemBackground
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = helpText[num]
        label.textAlignment = .center
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = true
            
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageNames[num])
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        
        page.addSubviews(label, imageView)
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: page.leadingAnchor, constant: padding),
            label.topAnchor.constraint(equalTo: page.topAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: page.trailingAnchor, constant: -padding),
            label.heightAnchor.constraint(equalToConstant: page.frame.size.height / 7),
            
            imageView.leadingAnchor.constraint(equalTo: page.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: page.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: page.bottomAnchor, constant: -padding)
        ])
        
        scrollView.addSubview(page)
    }
    }
    
}

extension HelpScreenViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
    
}
