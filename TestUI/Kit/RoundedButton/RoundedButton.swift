//
//  RoundedButton.swift
//  AddBlocker
//
//  Created by Igor Ryazancev on 2/25/20.
//  Copyright © 2020 DEVBUFF. All rights reserved.
//

import UIKit

final class RoundedButton: UIButton {
    
    enum ButtonType: Int {
        case selected
        case unselected
        case clear
    }
    
    @IBInspectable var type: Int {
        get {
            return self.typeButton.rawValue
        }
        set(index) {
            self.typeButton = ButtonType(rawValue: index) ?? .selected
            setup()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        get {
            return leftImageView.image
        }
        set(image) {
            leftImageView.image = image
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        get {
            return rightImageView.image
        }
        set(image) {
            rightImageView.image = image
        }
    }
        
    var typeButton = ButtonType.selected {
        didSet {
            setup()
        }
    }
    
    var titleText: String? {
        get {
            return titleLabel?.text
        }
        set(text) {
            setTitle(text, for: .normal)
        }
    }
    
    //MARK: - Variables private
    private var leftImageView = UIImageView()
    private var rightImageView = UIImageView()

   //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }

}

//MARK: - Lifecycle
extension RoundedButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }
    
}

//MARK: - Setups
private extension RoundedButton {
    
    func setup() {
        setupTitle()
        setLeftImage()
        setRightImage()
    }
    
    func setupTitle() {
        var color: UIColor?
        var textColor: UIColor?
        
        
        switch typeButton {
        case .selected:
            color = R.color.protectionOnColor()
            textColor = .white
            
        case .unselected:
            color = R.color.unselectedButtonColor()
            textColor = R.color.unselectedTextColor()
            
        case .clear:
            color = .clear
            textColor = R.color.unselectedTextColor()
        }
        
        backgroundColor = color
        setTitleColor(textColor, for: .normal)
//        titleLabel?.font = R.font.latoRegular(size: 18)
    }
    
    func setLeftImage() {
        leftImageView.frame.size = CGSize(width: 24.0, height: 24.0)
        
        leftImageView.image = nil
        
        addSubview(leftImageView)
        
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        guard let titleLabel = titleLabel else { return }
        NSLayoutConstraint(item: leftImageView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleLabel, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: -5).isActive = true
        NSLayoutConstraint(item: leftImageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleLabel, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    func setRightImage() {
        rightImageView.frame.size = CGSize(width: 24.0, height: 24.0)
        
        rightImageView.image = nil
                
        addSubview(rightImageView)
        
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        guard let titleLabel = titleLabel else { return }
        NSLayoutConstraint(item: rightImageView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleLabel, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: rightImageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleLabel, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
    }
    
}

