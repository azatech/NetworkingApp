//
//  ViewController.swift
//  Networking
//
//  Created by Azat Chorekliev on 12/29/19.
//  Copyright © 2019 Azat Chorekliev. All rights reserved
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var downloadImageIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImageIndicator.isHidden = true
        downloadImageIndicator.hidesWhenStopped = true
        fetchImage()

    }

    func fetchImage() {

        self.downloadImageIndicator.isHidden = false
        self.downloadImageIndicator.startAnimating()

        guard let url = URL(string: "https://media.idownloadblog.com/wp-content/uploads/2019/10/Fall-leaves-iPhone-wallpaper-wallsbyjfl-6.jpg") else { return }

        let session = URLSession.shared

        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {

                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.downloadImageIndicator.stopAnimating()
                }
            }
        }.resume()
    }



}
