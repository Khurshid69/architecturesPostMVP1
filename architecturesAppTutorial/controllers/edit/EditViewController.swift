//
//  EditViewController.swift
//  architecturesAppTutorial
//
//  Created by user on 20/11/21.
//

import UIKit
import Alamofire

class EditViewController: BaseViewController, EditView {
    
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyLabel: UITextField!
    
    var post = Post()
    var presenter: EditPresenter!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
    }
    
    func onEditView(editPost: Bool) {
        if editPost {
            // success maybe :)
        }else{
            // error
        }
    }
    
    

    func initViews(){
        titleLabel.text = post.title
        bodyLabel.text = post.body
        
        
        presenter = EditPresenter()
        presenter.editView = self
        presenter.controller = self
    }
    
    
    @IBAction func changeButton(_ sender: Any) {
        post.body = bodyLabel.text
        post.title = titleLabel.text
        presenter.apiContactEdit(post: post)
        self.dismiss(animated: true, completion: nil)
        
    }
}
