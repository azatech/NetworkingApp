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

    private var deviceName: String? = nil
    private var deviceURL: String? = nil


    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.allowsSelection = true
//        tableView.allowsSelectionDuringEditing = true




        fetchData()
        tableView.delegate = self
        tableView.dataSource = self
    }


    func fetchData() {
        let jsonToStringURL = "https://api.myjson.com/bins/1frfwo"

        guard let url = URL(string: jsonToStringURL) else { return }

        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }

            do {
                self.allDevices = try JSONDecoder().decode([Devices].self, from: data)
                
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
        return 100
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let allAppleDevices = allDevices[indexPath.row]

        deviceName = allAppleDevices.serial
        deviceURL = allAppleDevices.link

        performSegue(withIdentifier: "description", sender: self)

    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let segueId = segue.identifier
        if segueId == "description" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! WebViewController

                destination.selectedDeviceName = allDevices[indexPath.row].serial

                    destination.selectedDeviceURL = allDevices[indexPath.row].link

            }
        }




    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell

        configureCell(cell: cell, for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDevices.count
    }

    // Configuring cell
    private func configureCell(cell: ProductCell, for indexPath: IndexPath) {

        let appleDevices = allDevices[indexPath.row]

        cell.nameLbl.text = appleDevices.serial
        cell.priceLbl.text = String(appleDevices.price)

        DispatchQueue.global().async {
            guard let imageURL = URL(string: appleDevices.link_Image) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: imageData)
                self.tableView.reloadData()
            }
        }

    }
}
