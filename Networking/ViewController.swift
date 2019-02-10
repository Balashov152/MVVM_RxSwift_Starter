
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar { return searchController.searchBar }
    
    var viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        
        viewModel.data
            .debug()
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { any, repository, cell in
                cell.textLabel?.text = repository.repoName
                cell.detailTextLabel?.text = repository.repoURL
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
        .debug()
        .bind(to: viewModel.searchText)
        .disposed(by: disposeBag)
        
//        viewModel.data.asDriver()
//        .map({"\( $0.count) Repositories"})
//        .drive(navigationItem.rx.title)
//        .disposed(by: disposeBag)
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = "NavdeepSinghh"
        searchBar.placeholder = "Enter GitHub ID, e.g., \"NavdeepSinghh\""
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    

        
    
}
