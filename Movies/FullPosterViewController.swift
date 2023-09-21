//
//  FullPosterViewController.swift
//  Movies
//
//  Created by Alyona Bedrosova on 20.09.2023.
//

import UIKit

class FullPosterViewController: UIViewController {
    
    let imageFont: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        image.clipsToBounds = true
        return image
    }()
    
    var posterImage: UIImage? {
        didSet {
            if let image = posterImage {
                imageFont.image = image
            }  else {
                print("posterImage is nil")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFont.frame = view.bounds
    }
    
}
