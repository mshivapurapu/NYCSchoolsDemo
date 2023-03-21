//
//  ListVM.swift
//  VirtusaTest
//
//  Created by Mahendra Shivapurapu on 21/03/23.
//

import Foundation

protocol ViewUpdatingProtocol: AnyObject {
    func updateView()
}

class ListVM {
    
    private let listService: ListService
    weak var viewUpdatingProtocol: ViewUpdatingProtocol?
    private var listData: [ListData]
    
    init(listService: ListService) {
        self.listService = listService
        self.listData = [ListData]()
    }
    
    func getList() {
        self.listService.getList { [weak self] listResponse in
            guard let self = self,
                  let listResponse = listResponse else { return }
            self.listData = listResponse
            self.viewUpdatingProtocol?.updateView()
        }
    }
    
    func numberOfRows() -> Int {
        return listData.count
    }
    
    func getList(for indexPath: Int) -> ListData? {
        guard indexPath < listData.count else { return nil }
        return listData[indexPath]
    }
}
