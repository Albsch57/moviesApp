//
//  FullPosterViewController.swift
//  Movies
//
//  Created by Alyona Bedrosova on 20.09.2023.
//

import UIKit

class FullPosterViewController: UIViewController {
    
    private var cardView: FullView {
        view as! FullView
    }
    
    override func loadView() {
        view = FullView()
    }
    
    
    var posterImage: UIImage? {
        didSet {
            if let image = posterImage {
                cardView.imageFont.image = image
            }  else {
                print("posterImage is nil")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .cyan
    }
    
}
