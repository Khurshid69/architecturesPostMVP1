//
//  Post.swift
//  architecturesAppTutorial
//
//  Created by user on 20/11/21.
//

import Foundation

struct Post: Codable {
    var id: String? = ""
    var title: String? = ""
    var body: String? = ""
    
    init(title: String, body: String){
        self.title = title
        self.body = body
    }
}
