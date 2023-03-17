//
//  Article.swift
//  QuickNews-Storyboard-MVVM
//
//  Created by Chatsopon Deepateep on 17/3/23.
//

import Foundation

struct ArticleResponse: Decodable {
  let articles: [Article]
}

struct Article: Decodable {
  let title: String
  let description: String?
}
