//
//  SettingsTapView.swift
//  AddBlocker
//
//  Created by Igor Ryazancev on 2/26/20.
//  Copyright © 2020 DEVBUFF. All rights reserved.
//

import UIKit

final class SettingsTapView: UIView {
    
    enum TapViewType {
        case arrow
        case onOff
        case privacy
        case blackList
    }

    //MARK: - Variables private
    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var onOffLabel: UILabel!
    @IBOutlet private weak var privacyLAbel: UILabel!
    @IBOutlet private weak var arrowRightImageView: UIImageView!
    @IBOutlet private weak var switcher: SwiftySwitch!
    
    private(set) var type: TapViewType = .arrow
    
    //MARK: - Class func
    class func view(image: UIImage?, title: String, type: TapViewType) -> SettingsTapView {
        let view: SettingsTapView = SettingsTapView.nib()
        view.leftImageView.image = image
        view.titleLabel.text = title
        view.type = type
        view.setup()
        
        return view
    }
    
    //MARK: - Variables public
    var viewTappedClosure: VoidClosure? = nil
    var switchTurnOnClosure: BoolClosure? = nil
    var isON: Bool {
        set {
            switcher.isOn = newValue
            valueChanged(sender: switcher)
        }
        get {
            return switcher.isOn
        }
    }
    
    //MARK: - Actions
    @objc private func viewTapped() {
        viewTappedClosure?()
    }

}

//MARK: - Lifecycle
extension SettingsTapView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        equalFrame()
    }
    
}

//MARK: - Setups
private extension SettingsTapView {
    
    func setup() {
        setupSwitcher()
        setupUI()
        setupGesture()
    }
    
    func setupUI() {
        switch type {
        case .arrow, .privacy:
            privacyLAbel.isHidden = !(type == .privacy)
            
        case .onOff, .blackList:
            onOffLabel.isHidden = false
            arrowRightImageView.isHidden = true
            switcher.isHidden = false
            switcher.delegate = self
        
        }
    }
    
    func setupSwitcher() {
        if type == .blackList {
//            switcher.isOn = settings.blackListDomainsIsOn
            valueChanged(sender: switcher)
        }
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
    }
    
}

//MARK: - SwiftySwitchDelegate
extension SettingsTapView: SwiftySwitchDelegate {
    
    func valueChanged(sender: SwiftySwitch) {
        switcher.myColor = (sender.isOn ? R.color.mainBlueColor() : R.color.unselectedButtonColor()) ?? .blue
        onOffLabel.text = sender.isOn ? "On" : "Off"
        switchTurnOnClosure?(sender.isOn)
    }
    
}
