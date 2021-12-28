//
//  ProductDetailsViewController.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 28/12/2021.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Reusable
import Then

final class ProductDetailsViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: ProductDetailsViewModel!
    var disposeBag = DisposeBag()
    
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
        title = "Product Detail"
    }
    
    func bindViewModel() {
        let input = ProductDetailsViewModel.Input(loadTrigger: .just(()))
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.name
            .drive(onNext: { [weak self] name in
                self?.nameLabel.text = name
            })
            .disposed(by: disposeBag)
        
        output.price
            .drive(onNext: { [weak self] price in
                self?.priceLabel.text = "\(price)"
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Binders
extension ProductDetailsViewController {
    
}

// MARK: - StoryboardSceneBased
extension ProductDetailsViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.product
}
