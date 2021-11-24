//
//  CreateViewController.swift
//  architecturesAppTutorial
//
//  Created by user on 20/11/21.
//

import UIKit
import Alamofire

class CreateViewController: BaseViewController {
    
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func AddButton(_ sender: Any) {
        
        var param = Parameters()
        param["title"] = titleLabel.text
        param["body"] = bodyLabel.text
        
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: param) { response in
            switch response.result {
            case .success:
                print(response.result)
            case let .failure(error):
                print(error)
            }
        }
        navigationController!.popViewController(animated: true)
    }
}


