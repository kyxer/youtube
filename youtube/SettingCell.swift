//
//  SettingCell.swift
//  youtube
//
//  Created by German Mendoza on 7/20/16.
//  Copyright © 2016 German LLC. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    var setting:Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named:imageName)?.imageWithRenderingMode(.AlwaysTemplate)
                iconImageView.tintColor = UIColor.darkGrayColor()
            }
            
            
            
        }
    }
    
    override var highlighted: Bool {
        didSet {
            backgroundColor = highlighted ? UIColor.darkGrayColor() : UIColor.whiteColor()
            
            nameLabel.textColor = highlighted ? UIColor.whiteColor() : UIColor.blackColor()
            
            iconImageView.tintColor = highlighted ? UIColor.whiteColor() : UIColor.darkGrayColor()
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFontOfSize(13)
        return label
    }()
    
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"settings")
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat("H:|-16-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint.init(item: iconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
    }
    
}
