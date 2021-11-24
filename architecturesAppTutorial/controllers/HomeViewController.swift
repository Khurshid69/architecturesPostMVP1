//
//  HomeViewController.swift
//  architecturesAppTutorial
//
//  Created by user on 20/11/21.
//

import UIKit
import Alamofire

class HomeViewController: BaseViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var items: Array<Post> = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    
        
        
    }
    
    
    //MARK: - All of the Controller is controlling by (initViews)
    
    func initViews(){
        addNc()
        tableView.dataSource = self
        tableView.delegate = self
        apiContactList()
//        let post = Post(title: "Hello", body: "Salom")
//        apiPostUpdate(post: post)
        
    }
    

    
    
    //MARK: - Calling API_LIST
    
    func refreshTableView(posts: [Post]){
        self.items = posts
        self.tableView.reloadData()
    }
    
    func apiContactList(){
        showProgress()
        
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.hideProgress()
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Post].self, from: response.data!)
                self.refreshTableView(posts: contacts)
            case let .failure(error):
                print(error)
            }
        })
    }
    
    
    //MARK: - Calling API_DELETE
    
    func apiContactDelete(post: Post){
        showProgress()
        
        AFHttp.del(url: AFHttp.API_POST_DELETE + post.id!, params: AFHttp.paramsEmpty(), handler: { response in
            self.hideProgress()
            switch response.result {
            case .success:
                print(response.result)
                self.apiContactList()
            case let .failure(error):
                print(error)
            }
        })
        
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
    
    func callEditViewController(){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Actions
    @objc func rightTapped(){
        callCreateViewController()
    }
    
    @objc func leftTapped(){
        apiContactList()
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
            self.apiContactDelete(post: post)
        }
    }
    
    private func makeCompleteConttextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("Completed")
            completion(true)
            self.callEditViewController()
            
        }
    }
}
