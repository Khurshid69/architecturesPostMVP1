//
//  HomeView.swift
//  architecturesAppTutorial
//
//  Created by user on 24/11/21.
//

import Foundation


protocol HomeView {
    func onLoadPosts(posts: [Post])
    func onLoadPostsDelete(deleted: Bool)
}
