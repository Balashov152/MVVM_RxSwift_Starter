

import RxSwift
import RxCocoa

class ViewModel {
    
    let searchText = Variable("")
    
    lazy var data: Driver<[Repository]> = {
        return searchText.asObservable()
            .debug()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(ViewModel.repositoriesBy)
            .asDriver(onErrorJustReturn: [])
    }()
    
    static func repositoriesBy(git: String) -> Observable<[Repository]> {
        guard !git.isEmpty, let url = URL(string: "https://api.github.com/users/\(git)/repos") else {
            return Observable.just ([])
        }
        
        return URLSession.shared.rx.json(url: url)
            .retry(3)
            .map(parse)
    }
    
    static func parse(json: Any) -> [Repository] {
        guard let items = json as? [[String: Any]]  else {
            return []
        }
        var repositories: [Repository] = []
        
        items.forEach{
            guard let repoName = $0["name"] as? String,
                let repoURL = $0["html_url"] as? String else {
                    return
            }
            repositories.append(Repository(repoName: repoName, repoURL: repoURL))
        }
        return repositories
    }
    
}


