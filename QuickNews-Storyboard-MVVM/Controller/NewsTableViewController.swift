//
//  NewsTableViewController.swift
//  QuickNews-Storyboard-MVVM
//
//  Created by Chatsopon Deepateep on 17/3/23.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
  let disposeBag = DisposeBag()
  private var articleListViewModel: ArticleListViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    populateNews()
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articleListViewModel?.articleViewModels.count ?? 0
  }

  private func populateNews() {
    // swiftlint:disable:next force_unwrapping
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=8bfba1b8763148feb3583622592d9115")!
    let resource = Resource<ArticleResponse>(url: url)
    URLRequest.load(resource: resource)
      .subscribe { articleResponse in
        let articles = articleResponse.articles
        self.articleListViewModel = ArticleListViewModel(articles)
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
      .disposed(by: disposeBag)
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(
        withIdentifier: "ArticleTableViewCell",
        for: indexPath) as? ArticleTableViewCell else {
      fatalError("Cannot find ArticleTableViewCell")
    }
    guard let articleViewModel = articleListViewModel?
      .articleAt(indexPath.row) else { fatalError("Fail to access articleListViewModel") }
    articleViewModel
      .title
      .asDriver(onErrorJustReturn: "")
      .drive(cell.titleLabel.rx.text)
      .disposed(by: disposeBag)
    articleViewModel
      .description
      .asDriver(onErrorJustReturn: "")
      .drive(cell.descriptionLabel.rx.text)
      .disposed(by: disposeBag)

    return cell
  }
}
