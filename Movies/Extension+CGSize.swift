//
//  Extension+CGSize.swift
//  Movies
//
//  Created by Влад Третьяк on 21.09.2023.
//

import UIKit

extension CGSize {
    var retinaSize: CGSize {
        .init(width: UIScreen.main.scale * width, height: UIScreen.main.scale * height)
    }
}
