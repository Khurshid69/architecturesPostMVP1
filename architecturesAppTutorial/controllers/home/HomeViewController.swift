//
//  HomeViewController.swift
//  architecturesAppTutorial
//
//  Created by user on 20/11/21.
//

import UIKit
import Alamofire

class HomeViewController: BaseViewController, HomeView {
    
    
    @IBOutlet weak var tableView: UITableView!
    var items: Array<Post> = Array()
    var presenter: HomePresenter!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    
        
        
    }
    
    
    
    
    
    //MARK: - All of the Controller is controlling by (initViews)
    
    func initViews(){
        addNc()
        tableView.dataSource = self
        tableView.delegate = self
        
        // MARK: - Calling Presenter()'s protocols
        presenter = HomePresenter()
        presenter.homeView = self
        presenter.controller = self
        presenter.apiPostList()
        
    }
    
    
    
    //MARK: - Protocols
    
    func onLoadPosts(posts: [Post]) {
        if posts.count > 0 {
            refreshTableView(post: posts)
        }else{
            // error Ooops
        }
    }
    
    func onLoadPostsDelete(deleted: Bool) {
        if deleted {
            presenter.apiPostList()
        }else{
            // error Ooops
        }
    }
    

    
    //MARK: - Refresh Table View
    
    func refreshTableView(post: [Post]){
        self.items = post
        self.tableView.reloadData()

    }
    
   
    
                                                    
    //MARK: - Navigation Controller
    
    func addNc(){
        let info = UIImage(systemName: "plus.bubble")
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: info, style: .plain, target: self, action: #selector(rightTapped))]
        let more = UIImage(systemName: "arrow.clockwise")
        more?.withTintColor(.black)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(image: more, style: .plain, target: self, action: #selector(leftTapped))]
        title = "Architectures"
    }
    
    
    
    //MARK: - Calling ViewControllers
    
    func callCreateViewController(){
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func callEditViewController(post: Post){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.post = post
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Actions
    @objc func rightTapped(){
        callCreateViewController()
    }
    
    @objc func leftTapped(){
        presenter.apiPostList()
    }
    
}



// MARK: - TableView

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)?.first as! ContactTableViewCell
        
        cell.titleLabel.text = item.title
        cell.bodyLabel.text = item.body
        
        return cell
    }
    
    
    
    
    
    // MARK: - Swipe
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeCompleteConttextualAction(forRowAt: indexPath, post: items[indexPath.row])])
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeDeleteConttextualAction(forRowAt: indexPath, post: items[indexPath.row])])
    }
    
    
    //MARK: - Contextual Actions
    
    private func makeDeleteConttextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("Deleted")
            completion(true)
            self.presenter.apiPostDelete(post: post)
        }
    }
    
    private func makeCompleteConttextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("Completed")
            completion(true)
            self.callEditViewController(post: post)
            
        }
    }
}
