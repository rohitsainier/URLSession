//
//  ViewController.swift
//  TestURLSession
//
//  Created by Rohit Saini on 30/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickIt(_ sender: UIButton) {
        login()
    }
    
    private func login(using session: URLSession = .shared){
        let requestdata = LoginRequest(userId: "rohitsainier@gmail.com", password: "123456", latitude: 47, longitude: 57).toJSON()
        session.request(.login, using: requestdata) { (result) in
            switch result{
            case .success(let response):
                print(response)
            case .failure(let err):
                print(err)
            }
        }
    }
}


struct LoginRequest:Encodable {
    let userId,password:String
    let latitude,longitude: Double
}

struct LoginResponse: Codable {
    let status: Bool
    var message,name: String
    
    
    enum CodingKeys: String, CodingKey {
        case status, message, name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status) ?? false
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
    
}

