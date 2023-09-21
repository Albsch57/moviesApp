//
//  EmptyResultsView.swift
//  Movies
//
//  Created by Влад Третьяк on 21.09.2023.
//

import UIKit

final class EmptyResultsView: UIView {
    
    private let label: UILabel = {
       let label = UILabel()
        label.text = "Could not find anything by this request. Try another one"
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Private
private extension EmptyResultsView {
    func setupUI() {
        addSubview(label)
        directionalLayoutMargins = .init(top: 24, leading: 24, bottom: 24, trailing: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        let layoutMargins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
            label.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor)
        ])
    }
}
