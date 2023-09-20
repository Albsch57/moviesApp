//
//  FullView.swift
//  Movies
//
//  Created by Alyona Bedrosova on 20.09.2023.
//

import UIKit

class FullView: UIView {

    let imageFont: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        image.clipsToBounds = true
        return image
    }()
    
    override func layoutSubviews() {
        imageFont.frame = bounds
    }

}
