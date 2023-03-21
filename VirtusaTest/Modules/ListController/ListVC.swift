//
//  ViewController.swift
//  VirtusaTest
//
//  Created by Mahendra Shivapurapu on 20/03/23.
//

import UIKit
import SnapKit

class ListVC: UIViewController {
    
    typealias ViewModel = ListVM
    private var viewModel: ViewModel
    
    private let indicator = UIActivityIndicatorView(style: .medium)
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseIdentifier)
        tableView.estimatedRowHeight = 120
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let listVM = ListVM(listService: ListService())
        self.viewModel = listVM
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        indicator.startAnimating()
        viewModel.getList()
    }
    
    private func setup() {
        title = "Schools List"
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.viewUpdatingProtocol = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        view.addSubview(indicator)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func moveToDetail(listData: ListData) {
        guard let detailsVC = DetailsVC.initialise(listData: listData) else { return }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension ListVC: ViewUpdatingProtocol {
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.tableView.invalidateIntrinsicContentSize()
            self.tableView.reloadData()
        }
    }
}

extension ListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: Constants.listCell) as! ListCell
        
        if let listDetails = viewModel.getList(for: indexPath.row) {
            listCell.setDatasource(listData: listDetails)
        }
        
        listCell.backgroundColor = indexPath.row % 2 == 0 ? .systemTeal : .systemMint
        return listCell
    }
}

extension ListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listDetails = viewModel.getList(for: indexPath.row) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.moveToDetail(listData: listDetails)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
