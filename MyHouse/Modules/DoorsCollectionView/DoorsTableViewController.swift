//
//  DoorsTableViewController.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import RealmSwift

final class DoorsTableViewController: UITableViewController {
    
    // MARK: - Private properties
    private var doors = [Door]()
    private var intercom = [Door]()
    private var doorLists: Results<Door>!
    private var dataFetcherService: DataFetcherServiceProtocol = DataFetcherService()
    private var storageManager: StorageManagerProtocol = StorageManager()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        doorLists = storageManager.realm.objects(Door.self)
        showData()
        setupRefreshControl()
    }
    
    // MARK: - Private methods
    ///Проверка наличия данных в сети. Если данных нет - грузим из сети.
    private func showData() {
        doorLists.isEmpty ? fetchData() : showRealmData()
    }
    
    ///Получение данныех о двери из сети и сохранение их в БД
    private func fetchData() {
        dataFetcherService.fetchDoor { [weak self] door in
            guard let self = self else { return }
            guard let door = door else { return }
            deliteData()
            
            storageManager.deleteDoor(object: doorLists)
            for door in door.data {
                if door.snapshot == nil {
                    doors.append(door)
                    storageManager.save(object: door)
                } else {
                    intercom.append(door)
                    storageManager.save(object: door)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    ///Отображение данных из базы данных
    private func showRealmData() {
        deliteData()
        for door in doorLists {
            if door.snapshot == nil {
                doors.append(door)
            } else {
                intercom.append(door)
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    ///Удаление данных
    private func deliteData() {
        self.doors.removeAll()
        self.intercom.removeAll()
    }
    
    ///Изменение статуса избранного у камеры
    private func changeFavorites(indexPath: IndexPath, plusIndex: Int) {
        storageManager.editFavoriteDoor(door: doorLists[indexPath.row + plusIndex])
        tableView.reloadData()
    }
    
    ///Установка RefreshControl
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление...")
        refreshControl.addTarget(
            self,
            action: #selector(didPullToRefresh),
            for: .valueChanged
        )
        tableView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh() {
        fetchData()
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}

    // MARK: - UITableViewDataSource
extension DoorsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return section == 0 ? doors.count : intercom.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DoorTableViewCell.identifier,
                for: indexPath
            ) as? DoorTableViewCell else { return UITableViewCell() }
            
            cell.configure(with: doors[indexPath.row])
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: IntercomTableViewCell.identifier,
                for: indexPath
            ) as? IntercomTableViewCell else { return UITableViewCell() }
            
            cell.configure(with: intercom[indexPath.row])
            return cell
        }
    }
}

    // MARK: - UITableViewDelegate
extension DoorsTableViewController {
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return indexPath.section == 0 ? 72 : 279
    }
    
    override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        let verticalPadding: CGFloat = 10
        let maskLayer = CALayer()
        
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(
            x: cell.bounds.origin.x,
            y: cell.bounds.origin.y,
            width: cell.bounds.width,
            height: cell.bounds.height
        ).insetBy(dx: 0, dy: verticalPadding / 2)
        cell.layer.mask = maskLayer
    }
    
    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "") {
            action, view, completion in
            
            if indexPath.section == 0 {
                self.showAlertController(indexPath: indexPath, plusIndex: 0)
                completion(true)
            } else {
                self.showAlertController(indexPath: indexPath, plusIndex: self.doors.count)
                completion(true)
            }
            
            completion(true)
        }
        editAction.image = UIImage(named: "Pencil")
        editAction.backgroundColor = .systemGray6
        
        let favoriteAction = UIContextualAction(style: .normal, title: "") {
            action, view, completion in
            
            if indexPath.section == 0 {
                self.changeFavorites(indexPath: indexPath, plusIndex: 0)
                completion(true)
            } else {
                self.changeFavorites(indexPath: indexPath, plusIndex: self.doors.count)
                completion(true)
            }
            
            completion(true)
        }
        favoriteAction.image = UIImage(named: "Favorite")
        favoriteAction.backgroundColor = .systemGray6
        
        return UISwipeActionsConfiguration(actions: [editAction, favoriteAction])
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        var door = Door()
        if indexPath.section == 0 {
            door = doors[indexPath.row] } else {
                door = intercom[indexPath.row]
            }
        
        guard let descriptionVC = storyboard?.instantiateViewController(
            withIdentifier: "DescriptionViewController"
        ) as? DescriptionViewController else { return }
        descriptionVC.door = door
        navigationController?.pushViewController(descriptionVC, animated: true)
    }
    
}

    // MARK: - AlertController
extension DoorsTableViewController {
    func showAlertController(indexPath: IndexPath, plusIndex: Int) {
        let door = doorLists[indexPath.row + plusIndex]
        
        let alert = UIAlertController(
            title: "Изменение названия двери",
            message: "Введите новое название",
            preferredStyle: .alert
        )
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            guard let title = alert.textFields?.first?.text else { return }
            guard !title.isEmpty else { return }
            
            if let note = alert.textFields?.last?.text, !note.isEmpty {
                self.storageManager.editDoorName(door: door, newValue: title)
            } else {
                self.storageManager.editDoorName(door: door, newValue: "")
            }
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addTextField { textField in
            textField.placeholder = "Новое название"
            textField.text = door.name
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
}
