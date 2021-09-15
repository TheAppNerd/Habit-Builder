//
//  ChartCollectionViewLayout.swift
//  Habits
//
//  Created by Alexander Thompson on 15/9/21.
//

import UIKit

enum ChartCollectionViewLayout {

static func collectionLayout(in view: UIView) -> UICollectionViewFlowLayout {
    

    let availableWidth = view.bounds.width
    let availableHeight = view.bounds.height

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
   
    flowLayout.itemSize = CGSize(width: availableWidth, height: availableHeight)
    flowLayout.scrollDirection = .horizontal
    
    return flowLayout
}
}
