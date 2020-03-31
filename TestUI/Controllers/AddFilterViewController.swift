//
//  AddFilterViewController.swift
//  AddBlocker
//
//  Created by Igor Ryazancev on 2/26/20.
//  Copyright © 2020 DEVBUFF. All rights reserved.
//

import UIKit

final class AddFilterViewController: UIViewController {

    //MARK: - Variables private
    @IBOutlet private weak var navigationContentView: UIView!
    @IBOutlet private weak var problematicWebsitesContentView: UIView!
    @IBOutlet private weak var blockListContentView: UIView!
    @IBOutlet private weak var socialListContentView: UIView!
    @IBOutlet private weak var adblockListContentView: UIView!
    @IBOutlet private weak var ultimateListContentView: UIView!
    @IBOutlet private weak var buyProButton: RoundedButton!
    
    private lazy var problematicWebsitesView: SettingsTapView = {
        let view = SettingsTapView.view(image: R.image.addFilterGlobIcon(), title: "Problematic websites", type: .onOff)
//        view.isON = settings.problematicWebSitesIsOn
//        view.switchTurnOnClosure = { [unowned self] isOn in
//            settings.problematicWebSitesIsOn = isOn
//            NotificationCenter.default.post(name: App.NotificationNames.updateBlockJSON, object: nil)
//        }
        return view
    }()
    
    private lazy var blockListView: SettingsTapView = {
        let view = SettingsTapView.view(image: R.image.addFilterAnnounceIcon(), title: "Annoyances block list", type: .onOff)
//        view.isON = settings.annoyancesBlockList
//        view.switchTurnOnClosure = { [unowned self] isOn in
//            settings.annoyancesBlockList = isOn
//            NotificationCenter.default.post(name: App.NotificationNames.updateBlockJSON, object: nil)
//        }
        
        return view
    }()
    
    private lazy var socialListView: SettingsTapView = {
        let view = SettingsTapView.view(image: R.image.addFilterSocialIcon(), title: "Social block list", type: .onOff)
//        view.isON = settings.socialBlockList
//        view.switchTurnOnClosure = { [unowned self] isOn in
//            settings.socialBlockList = isOn
//            NotificationCenter.default.post(name: App.NotificationNames.updateBlockJSON, object: nil)
//        }
        
        return view
    }()
    
    private lazy var adblockListView: SettingsTapView = {
        let view = SettingsTapView.view(image: R.image.addFilterCompleteIcon(), title: "Complete Adblock list", type: .onOff)
//        view.isON = settings.completeBlockList
//        view.switchTurnOnClosure = { [unowned self] isOn in
//            settings.completeBlockList = isOn
//            NotificationCenter.default.post(name: App.NotificationNames.updateBlockJSON, object: nil)
//        }
        return view
    }()
    
    private lazy var ultimateListView: SettingsTapView = {
        let view = SettingsTapView.view(image: R.image.addFilterUltimateIcon(), title: "Ultimate Adblock list", type: .onOff)
//        view.isON = settings.ultimateBlockList
//        view.switchTurnOnClosure = { [unowned self] isOn in
//            settings.ultimateBlockList = isOn
//            NotificationCenter.default.post(name: App.NotificationNames.updateBlockJSON, object: nil)
//        }
        return view
    }()

    //MARK: - Actions
    @IBAction func buyButtonAction(_ sender: Any) {
        //do something
    }
    
}

//MARK: - Lifecycle
extension AddFilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
}

//MARK: - Setups
private extension AddFilterViewController {
    
    func setup() {
        setupNavigationView()
        setupProButton()
        setupViews()
    }
    
    func setupNavigationView() {
        let navigationView = CustomNavigationView.view(type: .addFilters)
        navigationView.leftButtonImage = R.image.backButton()
        navigationView.rightButtonImage = R.image.okButton()
        
        navigationView.leftButtonClosure = { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        
        navigationView.rightButtonClosure = { [unowned self] in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        navigationContentView.addSubview(navigationView)
    }
    
    func setupProButton() {
        buyProButton.leftImage = R.image.buskectIon()
    }
    
    func setupViews() {
        problematicWebsitesContentView.addSubview(problematicWebsitesView)
        blockListContentView.addSubview(blockListView)
        socialListContentView.addSubview(socialListView)
        adblockListContentView.addSubview(adblockListView)
        ultimateListContentView.addSubview(ultimateListView)
    }
    
}
