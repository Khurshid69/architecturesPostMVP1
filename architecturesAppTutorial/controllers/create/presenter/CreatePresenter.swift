//
//  CreatePresenter.swift
//  architecturesAppTutorial
//
//  Created by user on 25/11/21.
//

import Foundation
import Alamofire

protocol CreatePresenterProtocol{
    func apiCreatePost(post: Post)
}

class CreatePresenter: CreatePresenterProtocol {
    var createView: CreateView!
    var controller: BaseViewController!
    
    func apiCreatePost(post: Post) {
        controller?.showProgress()
        
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post), handler: { [self] response in
            controller?.hideProgress()
            switch response.result {
            case .success:
                let post = try! JSONDecoder().decode(Post.self, from: response.data!)
                createView.createPosts(post: post)
            case let .failure(error):
                print(error)
                createView.createPosts(post: Post())
            }
        }
        )}
}



