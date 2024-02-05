//
//  ViewController.swift
//  PPPMax
//
//  Created by Arthur Silva on 19/01/24.
//

import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var movieName: String?
    var queryString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        movieName = searchBar.text ?? ""
        queryString = movieName?.replacingOccurrences(of: " ", with: "+")
        
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?query=\(queryString)&api_key=f33197e7d286b19bb9d55aeecca2975f")!)
        request.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for network errors
            if let error = error {
                print("Error: \(error)")
                return
            }

            // Check if there is data
            guard let data = data else {
                print("No data received")
                return
            }

            // Print response data as a string
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "No response data")")
            } else {
                print("Invalid HTTP response")
            }
        }

        // Resume the task to execute the request
        dataTask.resume()

        
    }
}

