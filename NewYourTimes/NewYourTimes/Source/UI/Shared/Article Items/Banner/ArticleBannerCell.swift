//
//  ArticleBannerCell.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ArticleBannerCell: UICollectionViewCell, ItemViewProtocol {
    
    @IBOutlet weak var bannerImageView: AdvancedImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var itemModel: ItemViewModel?
    
    var itemViewDelegate: ItemViewDelegate?
    
    func didUpdate(_ object: ItemViewModel) {
        
        if let object = object as? ArticleBannerItem,
            let url = URL(string: object.image.url) {
            bannerImageView.setImage(with: url)
        }
    }
    
    static func preferredSizeForItem(_ item: ItemViewModel, containerSize: CGSize) -> CGSize {
        
        guard let item = item as? ArticleBannerItem else {
            fatalError()
        }
        
        let imageHeight = item.image.height
        let imageWidth = item.image.width
        return CGSize(width: containerSize.width, height: containerSize.width * CGFloat(imageHeight) / CGFloat(imageWidth))
    }
}
