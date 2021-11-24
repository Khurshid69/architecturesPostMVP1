//
//  EditPresenter.swift
//  architecturesAppTutorial
//
//  Created by user on 25/11/21.
//

import Foundation

protocol EditPresenterProtocol {
    func apiContactEdit(post: Post)
}

class EditPresenter: EditPresenterProtocol {
 
    var editView: EditView!
    var controller: BaseViewController!
    
    func apiContactEdit(post: Post) {
        controller?.showProgress()
        
        AFHttp.put(url: AFHttp.API_POST_UPDATE + post.id!, params: AFHttp.paramsPostUpdate(post: post), handler: {[self] response in
            controller?.hideProgress()
            
            switch response.result {
            case .success:
                editView.onEditView(editPost: true)
            case let .failure(error):
                print(error)
                editView.onEditView(editPost: false)
            }
        })
    }
}
