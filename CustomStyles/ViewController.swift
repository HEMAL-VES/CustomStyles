//
//  ViewController.swift
//  CustomStyles
//
//  Created by Jayesh Kawli on 6/8/17.
//  Copyright © 2017 Jayesh Kawli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let fullView = UIView()
    let imageView = UIImageView()
    let chevronImageView = UIImageView()
    let textLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        fullView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.0
        chevronImageView.contentMode = .scaleAspectFit
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center

        self.view.addSubview(fullView)
        fullView.addSubview(imageView)
        fullView.addSubview(chevronImageView)
        fullView.addSubview(textLabel)

        let views = ["fullView": fullView, "imageView": imageView, "chevronImageView": chevronImageView, "textLabel": textLabel]

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[fullView]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[fullView]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[imageView]-30-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[imageView(200)]-10-[chevronImageView(20)]-[textLabel(>=0)]", options: [], metrics: nil, views: views))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[textLabel]-20-|", options: [], metrics: nil, views: views))

        self.view.addConstraint(NSLayoutConstraint(item: chevronImageView, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: chevronImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0))

        if let currentStyle = JSONFileReader.readJSONFile(with: "app1") {
            fullView.layer.cornerRadius = currentStyle.cornerRadius
            fullView.backgroundColor = currentStyle.backgroundColor
            imageView.image = currentStyle.mainImage
            chevronImageView.image = currentStyle.chevronImage
            textLabel.textColor = currentStyle.textColor
            textLabel.text = currentStyle.text
            textLabel.font = currentStyle.font
            if currentStyle.animation {
                UIView.animate(withDuration: 2.0, animations: {
                    self.imageView.alpha = 1.0
                })
            } else {
                imageView.alpha = 1.0
            }
        }

    }
}

