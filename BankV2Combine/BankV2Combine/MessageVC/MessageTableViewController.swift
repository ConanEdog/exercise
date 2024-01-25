//
//  MessageTableViewController.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/25.
//

import UIKit

class MessageTableViewController: UITableViewController {

    private let viewModel: MessageListViewModel
    
    init(viewModel: MessageListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableVC()
    }
    
    private func setupTableVC() {
        title = "Notification"
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reusedId)
        tableView.rowHeight = MessageTableViewCell.rowHeight
        tableView.separatorStyle = .none
        tableView.backgroundColor = ThemeColor.background
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfRows(section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reusedId, for: indexPath) as! MessageTableViewCell
        let message = viewModel.mesaage(at: indexPath.row)
        cell.configure(message: message)

        return cell
    }
    

}
