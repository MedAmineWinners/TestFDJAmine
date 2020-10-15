//
//  Extensions.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 05/10/2020.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension Data {
    func decode<T: Codable>() -> T {
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: self) else {
            fatalError("failed to decode data")
        }
        return loaded
    }
}

extension UITableView {
    func reloadDataAnimated() {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {self.reloadData()}, completion: nil)
    }
}

extension UICollectionView {
    func reloadDataAnimated() {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {self.reloadData()}, completion: nil)
    }
}
