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
    let scrollView = ScrollView()
    
    //need a page constant for all this and pagecontrol
    
    //MARK: - Class Funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        if scrollView.subviews.count == 2 {
            configureScrollView()
        }
    }
    
    //MARK: - Functions
    
    private func configureLayout() {
        view.backgroundColor = BackgroundColors.mainBackGround
        view.addSubviews(pageControl, scrollView)
        view.addSubview(scrollView)

        // TODO: - move this elsewhere
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
            pageControl.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    
  
    
    //move all these to constants
    
    private func configureScrollView() {
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * 6, height: scrollView.frame.size.height)
       
        for num in 0...helpPage.imageNames.count - 1 {
            let page             = UIView(frame: CGRect(x: CGFloat(num) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            page.addGradient(colors: gradients.array[num])
            
            let label                       = UILabel()
            label.text                      = helpPage.helpText[num]
            label.textAlignment             = .center
            label.font                      = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.numberOfLines = 6
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            
            
            let imageView         = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image       = UIImage(named: helpPage.imageNames[num])
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            page.addSubviews(label, imageView)
            let padding: CGFloat = 20
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: page.topAnchor, constant: padding),
                label.leadingAnchor.constraint(equalTo: page.leadingAnchor, constant: padding),
                label.trailingAnchor.constraint(equalTo: page.trailingAnchor, constant: -padding),
                label.heightAnchor.constraint(equalToConstant: page.frame.size.height / 6.5),
                
                imageView.topAnchor.constraint(equalTo: label.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: page.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: page.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: page.bottomAnchor, constant: -padding)
            ])
            scrollView.addSubview(page)
        }
    }
    
}

extension HowToUseVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
    
}
