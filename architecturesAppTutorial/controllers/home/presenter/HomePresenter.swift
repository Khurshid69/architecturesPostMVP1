//
//  HomePresenter.swift
//  architecturesAppTutorial
//
//  Created by user on 24/11/21.
//

import Foundation


protocol HomePresenterProtocol {
    func apiPostList()
    func apiPostDelete(post: Post)
}

class HomePresenter: HomePresenterProtocol {
    
    var homeView: HomeView!
    var controller: BaseViewController!
    
    func apiPostList(){
        controller?.showProgress()
        
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.controller?.hideProgress()
            
            switch response.result {
            case .success:
                let posts = try! JSONDecoder().decode([Post].self, from: response.data!)
                self.homeView.onLoadPosts(posts: posts)
            case let .failure(error):
                print(error)
                self.homeView.onLoadPosts(posts: [Post]())
            }
        })
    }
    
    
    //MARK: - Calling API_DELETE
    
    func apiPostDelete(post: Post){
        controller?.showProgress()
        
        AFHttp.del(url: AFHttp.API_POST_DELETE + post.id!, params: AFHttp.paramsEmpty(), handler: {  response in
            self.controller?.hideProgress()
            
            switch response.result {
            case .success:
                print(response.result)
                self.homeView.onLoadPostsDelete(deleted: true)
            case let .failure(error):
                print(error)
                self.homeView.onLoadPostsDelete(deleted: false)
                
            }
        })
        
    }
    
    
    
}
