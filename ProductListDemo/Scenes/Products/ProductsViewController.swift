//
//  ProductsViewController.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Reusable
import Then

final class ProductsViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: ProductsViewModel!
    var disposeBag = DisposeBag()
    
    var products = [Product]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        title = "ProductList"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: ProductCell.self)
    }
    
    func bindViewModel() {
        let input = ProductsViewModel.Input(loadTrigger: Driver.just(()))
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.products
            .drive(onNext: { [weak self] products in // subcribe
                self?.products = products
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension ProductsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProductCell.self)
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "\(product.price)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProductsViewController: UITableViewDelegate {
    
}

// MARK: - StoryboardSceneBased
extension ProductsViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.product
}
