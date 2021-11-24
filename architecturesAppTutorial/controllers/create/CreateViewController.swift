//
//  CreateViewController.swift
//  architecturesAppTutorial
//
//  Created by user on 20/11/21.
//

import UIKit
import Alamofire

class CreateViewController: BaseViewController, CreateView {
    

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyLabel: UITextField!
    
    private var post = Post()
    var presenter: CreatePresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
    }
    
    // MARK: - Calling protocol as a function from CreateView
    func createPosts(post: Post) {
        if post.id != nil {
            
        }
    }
    
    func initViews(){
        presenter = CreatePresenter()
        presenter.createView = self
        presenter.controller = self
        
    }
    
    @IBAction func AddButton(_ sender: Any) {
        self.post.body = bodyLabel.text
        self.post.title = titleLabel.text
        presenter.apiCreatePost(post: post)
        navigationController!.popViewController(animated: true)
    }
}


