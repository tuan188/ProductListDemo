//
//  CreateProductViewController.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 31/12/2021.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Reusable
import Then

final class CreateProductViewController: UITableViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    // MARK: - Properties
    
    var viewModel: CreateProductViewModel!
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
        
    }
    
    func bindViewModel() {
        let input = CreateProductViewModel.Input(
            productName: nameTextField.rx.value.orEmpty.asDriver(),
            productPrice: priceTextField.rx.value.orEmpty.asDriver(),
            createProductTrigger: saveButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: disposeBag)
    }
    
    @IBAction private func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Binders
extension CreateProductViewController {
    
}

// MARK: - StoryboardSceneBased
extension CreateProductViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.product
}
