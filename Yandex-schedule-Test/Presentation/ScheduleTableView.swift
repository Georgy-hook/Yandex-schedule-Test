//
//  ScheduleTableView.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 15.12.2023.
//

import UIKit

final class ScheduleTableView:UITableView{
    
    // MARK: - Variables
    private var items:[SimplifiedSegment] = []
    
    // MARK: - Initiliazation
    init() {
        super.init(frame: .zero, style: .plain)
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.allowsSelection = false
        delegate = self
        dataSource = self
        register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UITableViewDataSource
extension ScheduleTableView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reuseId) as? ScheduleTableViewCell
        else { return UITableViewCell() }
        cell.set(with: items[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ScheduleTableView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - UITableView methods
extension ScheduleTableView{
    func set(with segments:[SimplifiedSegment]){
        items = segments
        self.reloadData()
    }
}
