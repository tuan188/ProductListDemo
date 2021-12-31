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
    @IBOutlet weak var createProductButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    var viewModel: ProductsViewModel!
    var disposeBag = DisposeBag()
    
    var products = [Product]()
    var editProductSubject = PublishSubject<IndexPath>()
    var deleteProductSubject = PublishSubject<IndexPath>()
    
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
        tableView.rowHeight = 90
        tableView.register(cellType: ProductCell.self)
    }
    
    func bindViewModel() {
//        let loadTrigger = rx.sentMessage(#selector(viewWillAppear(_:)))
//            .asDriverOnErrorJustComplete()
//            .mapToVoid()
        
        let createdProductTrigger = NotificationCenter.default.rx.notification(.createdProduct)
            .map { $0.object as? Product }
            .unwrap()
            .asDriverOnErrorJustComplete()
        
        let input = ProductsViewModel.Input(
            loadTrigger: .just(()),
            selectProductTrigger: tableView.rx.itemSelected.asDriver(),
            editProductTrigger: editProductSubject.asDriverOnErrorJustComplete(),
            deleteProductTrigger: deleteProductSubject.asDriverOnErrorJustComplete(),
            createProductTrigger: createProductButton.rx.tap.asDriver(),
            createdProductTrigger: createdProductTrigger
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.products
            .drive(onNext: { [weak self] products in // subcribe
                print("output products")
                self?.products = products
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.isLoading
            .drive(rx.isLoading)
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
        cell.nameLabel?.text = product.name
        cell.priceLabel?.text = "\(product.price)"
        
//        cell.deleteButton.rx.tap
//            .subscribe(onNext: { _ in
//
//            })
//            .disposed(by: cell.disposeBag)
        
        cell.editProduct = { [weak self] in
            self?.editProductSubject.onNext(indexPath)
        }
        
        cell.deleteProduct = { [weak self] in
            self?.deleteProductSubject.onNext(indexPath)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - StoryboardSceneBased
extension ProductsViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.product
}
