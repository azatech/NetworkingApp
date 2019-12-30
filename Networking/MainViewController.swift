//
//  MainViewController.swift
//  Networking
//
//  Created by Azat Chorekliev on 12/29/19.
//  Copyright © 2019 Azat Chorekliev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let url = URL(string: "https://jsonplaceholder.typicode.com/users")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getRequest(_ sender: UIButton) {


        let session = URLSession.shared
        if let url = url {
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data, let response = response else { return }

                print(response)
                print(data)

                // Json Serialization
                do {
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }

            }.resume()
        }
    }


    @IBAction func postRequest(_ sender: UIButton) {

        let userData = ["Name": "Apple", "Serail Number": "macBook65-04-90"]
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else  { return }

            request.httpBody = httpBody
//            request.addValue("application", forHTTPHeaderField: "Content-Type")

            request.addValue("application/json", forHTTPHeaderField: "Content-Type")


            // Get again posted data...
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, let response = response else { return }
                print(response)

                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }.resume()
        }

    }
}
