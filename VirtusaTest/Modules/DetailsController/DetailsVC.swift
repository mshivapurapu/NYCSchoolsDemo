//
//  DetailsVC.swift
//  VirtusaTest
//
//  Created by Mahendra Shivapurapu on 21/03/23.
//

import UIKit

class DetailsVC: UIViewController {
    typealias ViewModel = DetailsVM
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: ViewModel!
    
    public static func initialise(listData: ListData) -> DetailsVC? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC else { return nil }
        detailsVC.initialise(listData: listData)
        return detailsVC
    }
    
    private func initialise(listData: ListData) {
        self.viewModel = ViewModel(listData: listData)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

    private func setup() {
        title = "School Details"
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UIScreen.main.bounds.height
    }
}

extension DetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailsCell = tableView.dequeueReusableCell(withIdentifier: Constants.detailsCell) as! DetailsCell
        detailsCell.setDatasource(listData: self.viewModel.listData)
        
        return detailsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
