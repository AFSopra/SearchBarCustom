//
//  SearchBarView.swift
//  SearchBarCustom
//
//  Created sopra on 20/11/20.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private enum SearchBarConstants {
    static let cornerRadius = CGFloat(24)
    static let leftTextFieldPadding = CGFloat(16)
    static let font = UIFont(name: "", size: CGFloat(14))
    static let darkIndigo = UIColor.darkGray
    static let paleGreyTwo = UIColor.systemGray4
    static let heightSearchContainer: CGFloat = 160
    static let targetHeightSearchContainer: CGFloat = 66
    static let animationDurationOut = 0.6
    static let animationDurationIn = 0.6
    static let borderWidth: CGFloat = 1.0
    static let scanButtonWidth = CGFloat(53)
    static let scanButtonHeight = CGFloat(56)
}

class SearchBarView: UIViewController {
    var presenter: SearchBarPresenterProtocol!

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var activeSearchBarConstraint: NSLayoutConstraint!
    @IBOutlet private weak var inactiveSearchBarConstraint: NSLayoutConstraint!

    var scanButton = UIButton()
    var searchText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
    }

    private func setupSearchBar() {
        if let searchBarTextField = searchBar.textField {
            searchBar.placeholder = "Buscar por..."
            searchBar.setImage(UIImage(), for: .search, state: .normal)
            searchBar.delegate = self

            searchBarTextField.font = SearchBarConstants.font
            searchBarTextField.textColor = SearchBarConstants.darkIndigo
            searchBarTextField.tintColor = SearchBarConstants.darkIndigo
            searchBarTextField.backgroundColor = SearchBarConstants.paleGreyTwo
            searchBarTextField.layer.cornerRadius = SearchBarConstants.cornerRadius
            searchBarTextField.clipsToBounds = true

            searchBarTextField.setLeftPaddingPoints(SearchBarConstants.leftTextFieldPadding)
            searchBarTextField.setRightPaddingPoints(SearchBarConstants.leftTextFieldPadding)

            filterButton.titleLabel?.font = SearchBarConstants.font
            filterButton.titleLabel?.textColor = SearchBarConstants.darkIndigo

            setupScanButton()
        }
    }

    func setupScanButton() {
        let image = UIImage(named: "BarCode") as UIImage?

        scanButton = UIButton(frame: CGRect(x: searchBar.frame.maxX - SearchBarConstants.scanButtonWidth - 2 * SearchBarConstants.leftTextFieldPadding, y: searchBar.frame.height - SearchBarConstants.scanButtonHeight, width: SearchBarConstants.scanButtonWidth, height: searchBar.frame.height))

        scanButton.setImage(image, for: .normal)
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)

        searchBar.addSubview(scanButton)
    }

    @objc func scanButtonTapped() {
        let alertViewController = UIAlertController(title: "BarCode Scan", message: "Presentar VC", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertViewController.addAction(alertAction)
        present(alertViewController, animated: true, completion: nil)
    }

    private func createAlert(searchText: String) {
        let alertViewController = UIAlertController(title: "Buscar", message: searchText, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertViewController.addAction(alertAction)
        present(alertViewController, animated: true, completion: nil)
    }
}

extension SearchBarView: SearchBarViewProtocol {}

extension SearchBarView: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        if let searchBarTextField = searchBar.textField {
            self.searchText = searchText
            if searchText == "Fin" {
                searchBar.resignFirstResponder()
                searchBarTextField.text = ""
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchBarTextField = searchBar.textField {
            searchBar.resignFirstResponder()
            searchBarTextField.text = ""

            createAlert(searchText: searchText)
        }
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {
        showOnlySearchBar()
    }

    func searchBarTextDidEndEditing(_: UISearchBar) {
        resetSearchView()
    }

    private func showOnlySearchBar() {
        if let searchBarTextField = searchBar.textField {
            searchBarTextField.layer.borderWidth = SearchBarConstants.borderWidth
            searchBarTextField.layer.borderColor = UIColor.blue.cgColor

            filterButton.isHidden = true
            scanButton.isHidden = true
            activeSearchBarConstraint.isActive = true
            inactiveSearchBarConstraint.isActive = false

            UIView.animate(withDuration: SearchBarConstants.animationDurationOut) {
                self.view.layoutIfNeeded()
            }
        }
    }

    private func resetSearchView() {
        if let searchBarTextField = searchBar.textField {
            searchBarTextField.layer.borderWidth = 0
            searchBarTextField.layer.borderColor = UIColor.clear.cgColor

            filterButton.isHidden = false
            scanButton.isHidden = false
            activeSearchBarConstraint.isActive = false
            inactiveSearchBarConstraint.isActive = true
            UIView.animate(withDuration: SearchBarConstants.animationDurationIn) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
