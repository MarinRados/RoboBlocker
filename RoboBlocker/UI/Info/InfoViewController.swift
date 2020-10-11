//
//  InfoViewController.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit
import CallKit

final class InfoViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: "com.marinrados.RoboBlocker.CallDirectoryHandler", completionHandler: nil)
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        blockedCallsTitleLabel.anchor(top: (view.safeAreaLayoutGuide.topAnchor, 24), leading: (view.leadingAnchor, 24), trailing: (view.trailingAnchor, 24))
        blockedCallsValueLabel.anchor(top: (blockedCallsTitleLabel.bottomAnchor, 16), leading: (view.leadingAnchor, 24))
        suspiciousCallsTitleLabel.anchor(top: (blockedCallsValueLabel.bottomAnchor, 24), leading: (view.leadingAnchor, 24), trailing: (view.trailingAnchor, 24))
        suspiciousCallsValueLabel.anchor(top: (suspiciousCallsTitleLabel.bottomAnchor, 16), leading: (view.leadingAnchor, 24))
        blockedSMSTitleLabel.anchor(top: (suspiciousCallsValueLabel.bottomAnchor, 24), leading: (view.leadingAnchor, 24), trailing: (view.trailingAnchor, 24))
        blockedSMSValueLabel.anchor(top: (blockedSMSTitleLabel.bottomAnchor, 16), leading: (view.leadingAnchor, 24))
    }
    
    // MARK: - UI Components
    
    private lazy var blockedCallsTitleLabel: UILabel = {
        let blockedCallsTitleLabel = UILabel()
        blockedCallsTitleLabel.numberOfLines = 0
        UILabelStyle.bold24Dark.apply(to: blockedCallsTitleLabel)
        blockedCallsTitleLabel.text = "Blocked calls"
        view.addSubview(blockedCallsTitleLabel)
        return blockedCallsTitleLabel
    }()
    
    private lazy var blockedCallsValueLabel: UILabel = {
        let blockedCallsValueLabel = UILabel()
        UILabelStyle.bold32Main.apply(to: blockedCallsValueLabel)
        blockedCallsValueLabel.text = "145"
        view.addSubview(blockedCallsValueLabel)
        return blockedCallsValueLabel
    }()
    
    private lazy var suspiciousCallsTitleLabel: UILabel = {
        let suspiciousCallsTitleLabel = UILabel()
        suspiciousCallsTitleLabel.numberOfLines = 0
        UILabelStyle.bold24Dark.apply(to: suspiciousCallsTitleLabel)
        suspiciousCallsTitleLabel.text = "Suspicious calls received"
        view.addSubview(suspiciousCallsTitleLabel)
        return suspiciousCallsTitleLabel
    }()
    
    private lazy var suspiciousCallsValueLabel: UILabel = {
        let suspiciousCallsValueLabel = UILabel()
        UILabelStyle.bold32Main.apply(to: suspiciousCallsValueLabel)
        suspiciousCallsValueLabel.text = "19"
        view.addSubview(suspiciousCallsValueLabel)
        return suspiciousCallsValueLabel
    }()
    
    private lazy var blockedSMSTitleLabel: UILabel = {
        let blockedSMSTitleLabel = UILabel()
        blockedSMSTitleLabel.numberOfLines = 0
        UILabelStyle.bold24Dark.apply(to: blockedSMSTitleLabel)
        blockedSMSTitleLabel.text = "Messages filtered"
        view.addSubview(blockedSMSTitleLabel)
        return blockedSMSTitleLabel
    }()
    
    private lazy var blockedSMSValueLabel: UILabel = {
        let blockedSMSValueLabel = UILabel()
        UILabelStyle.bold32Main.apply(to: blockedSMSValueLabel)
        blockedSMSValueLabel.text = "24"
        view.addSubview(blockedSMSValueLabel)
        return blockedSMSValueLabel
    }()
}
