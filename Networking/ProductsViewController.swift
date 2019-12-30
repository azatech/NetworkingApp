//
//  DevicesViewController.swift
//  Networking
//
//  Created by Azat Chorekliev on 12/30/19.
//  Copyright © 2019 Azat Chorekliev. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    var allDevices: [Devices] = []


    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }


    func fetchData() {
        let jsonToStringURL = "https://api.myjson.com/bins/1frfwo"

        guard let url = URL(string: jsonToStringURL) else { return }

        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else { return }

            do {
                let products = try JSONDecoder().decode([Devices].self, from: data)
                for i in products {
                    self.allDevices.append(i)
                }

//                print(self.allDevices)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()

    }


}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 90
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProductCell

        let allInOneDevices = allDevices[indexPath.row]



        DispatchQueue.global().async {
            guard let imageUrl = URL(string: allInOneDevices.link_Image) else { return }
                  guard let imageData = try? Data(contentsOf: imageUrl) else { return }

                  DispatchQueue.main.async {
                    cell?.imageView?.image = UIImage(data: imageData)
                    self.tableView.reloadData()
                  }
              }


        cell?.nameLbl.text = allInOneDevices.serial
        cell?.priceLbl.text = String(allInOneDevices.price)

        
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDevices.count
    }
}
