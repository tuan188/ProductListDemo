//
//  ProductCell.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import UIKit
import Reusable
import RxSwift

final class ProductCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var deleteProduct: (() -> Void)?
    var editProduct: (() -> Void)?
    
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    @IBAction private func deleteAction(_ sender: Any) {
        deleteProduct?()
    }
    
    @IBAction private func editAction(_ sender: Any) {
        editProduct?()
    }
    
}
