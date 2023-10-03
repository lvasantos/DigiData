//
//  SetViewProtocol.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 29/01/23.
//

import Foundation

public protocol SettingViews {
    func setupSubviews()
    func setupConstraints()
}

extension SettingViews {
    func buildLayoutView() {
        setupSubviews()
        setupConstraints()
    }
}
