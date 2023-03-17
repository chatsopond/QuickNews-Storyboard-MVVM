//
//  ArticleViewModel.swift
//  QuickNews-Storyboard-MVVM
//
//  Created by Chatsopon Deepateep on 17/3/23.
//

import Foundation
import RxSwift

struct ArticleListViewModel {
  let articleViewModels: [ArticleViewModel]
}

extension ArticleListViewModel {
  init(_ articles: [Article]) {
    self.articleViewModels = articles.compactMap {
      ArticleViewModel($0)
    }
  }
}

extension ArticleListViewModel {
  func articleAt(_ index: Int) -> ArticleViewModel {
    return articleViewModels[index]
  }
}

struct ArticleViewModel {
  let article: Article
  init(_ article: Article) {
    self.article = article
  }
}

extension ArticleViewModel {
  var title: Observable<String> {
    return Observable<String>.just(article.title)
  }

  var description: Observable<String> {
    return Observable<String>.just(article.description ?? "")
  }
}
