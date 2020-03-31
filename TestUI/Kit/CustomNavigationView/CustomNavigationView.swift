//
//  CustomNavigationView.swift
//  AddBlocker
//
//  Created by Igor Ryazancev on 2/25/20.
//  Copyright © 2020 DEVBUFF. All rights reserved.
//

import UIKit

typealias VoidClosure = ()->()
typealias BoolClosure = (Bool)->()
typealias StringClosure = (String)->()

final class CustomNavigationView: UIView {
    
    enum NavigationType {
        case mainScreen
        case settings
        case addFilters
        case aboutAs
        case antiTracking
        case blackList
        case privacy
    }
    
    //MARK: - Variables private
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var titleStackView: UIStackView!
    @IBOutlet private weak var titleImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var titleAndImageStack: UIStackView!
    
    private(set) var type: NavigationType = .mainScreen
    private var isSearchState: Bool = false
    
    //MARK: - Variables public
    var leftButtonImage: UIImage? {
        get {
            return leftButton.imageView?.image
        }
        set(image) {
            leftButton.setImage(image, for: .normal)
        }
    }
    
    var rightButtonImage: UIImage? {
        get {
            return rightButton.imageView?.image
        }
        set(image) {
            rightButton.setImage(image, for: .normal)
        }
    }
    
    var leftButtonClosure: VoidClosure? = nil
    var rightButtonClosure: VoidClosure? = nil
    var plusButtonClosure: VoidClosure? = nil
    var searchStateChanged: BoolClosure? = nil
    var didChangeSearchText: StringClosure? = nil
    
    //MARK: - Class func
    class func view(type: NavigationType) -> CustomNavigationView {
        let view: CustomNavigationView = CustomNavigationView.nib()
        view.type = type
        view.setup()
        
        return view
    }
    
    //MARK: - Actions
    @IBAction func leftButtonAction(_ sender: Any) {
        leftButtonClosure?()
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        guard !isSearchState else {
            searchButtonAction(searchButton)
            
            return
        }
        
        type == .blackList ? plusButtonClosure?() : rightButtonClosure?()
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        searchButton.isSelected = !searchButton.isSelected
        let rightImage = searchButton.isSelected ? R.image.searchCancel() : R.image.navPlusButton()
        rightButton.setImage(rightImage, for: .normal)
        searchBar.isHidden = !searchButton.isSelected
        titleAndImageStack.isHidden = searchButton.isSelected
        searchButton.isHidden = searchButton.isSelected
        isSearchState = searchButton.isSelected
        searchStateChanged?(searchButton.isSelected)
    }
    
}

//MARK: - Setups
private extension CustomNavigationView {
    
    func setup() {
        setupTitle()
        setupSearchBar()
    }
    
    func setupSearchBar() {
        searchBar.setImage(R.image.searchIcon(), for: .search, state: .normal)
        searchBar.delegate = self
        searchBar.barTintColor = R.color.mainBlueColor()
    }
    
    func setupTitle() {
        switch type {
        case .mainScreen:
            titleStackView.isHidden = true
            
        case .settings:
            titleImageView.image = R.image.settingsIcon()
            titleLabel.text = "Settings"
            
        case .addFilters:
            titleImageView.image = R.image.addFiltersIcon1()
            titleLabel.text = "Add filters"
            
        case .antiTracking:
            titleImageView.image = R.image.antiTrackingIcon1()
            titleLabel.text = "Antitracking"
            
        case .aboutAs:
            titleImageView.image = R.image.aboutNavIcon()
            titleLabel.text = "About us"
            
        case .blackList:
            searchButton.isHidden = false
            rightButton.setImage(R.image.navPlusButton(), for: .normal)
            titleImageView.image = R.image.navBlackListIcon()
            titleLabel.text = "Black list"
            
        case .privacy:
            titleLabel.text = "Privacy policy"
            titleImageView.isHidden = true
        }
    }
    
}

//MARK: - Lifecycle
extension CustomNavigationView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let superview = superview {
            frame = superview.bounds
        }
    }
    
}

//MARK: - UISearchBarDelegate
extension CustomNavigationView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        didChangeSearchText?(searchText)
    }
    
}
