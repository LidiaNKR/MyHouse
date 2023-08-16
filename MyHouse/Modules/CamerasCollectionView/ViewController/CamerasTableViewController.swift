//
//  CamerasTableViewController.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import RealmSwift

final class CamerasTableViewController: UITableViewController {
    
    // MARK: - Private properties
    private var rooms = [String]()
    private var firstRoomCameras = [Camera]()
    private var secondRoomCameras = [Camera]()
    private var dataFetcherService: DataFetcherServiceProtocol? = DataFetcherService()
    private var storageManager: StorageManagerProtocol = StorageManager()
    private var camerasList: Results<Camera>!
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        camerasList = storageManager.realm.objects(Camera.self)
        showData()
        setupRefreshControl()
    }
    
    // MARK: - Private methods
    ///Проверка наличия данных в сети. Если данных нет - грузим из сети.
    private func showData() {
        camerasList.isEmpty ? fetchData() : showRealmData()
    }
    
    ///Получение данных камер из сети и сохранение их в БД
    private func fetchData() {
        dataFetcherService?.fetchCamera { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            deliteData()
            rooms = result.data.room
            storageManager.deleteCamera(object: camerasList)
            
            for camera in result.data.cameras {
                if rooms.contains(camera.room ?? "") {
                    firstRoomCameras.append(camera)
                    storageManager.save(object: camera)
                } else {
                    secondRoomCameras.append(camera)
                    storageManager.save(object: camera)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    ///Отображение данные из базы данных
    private func showRealmData() {
        deliteData()
        for camera in camerasList {
            if camera.room == "FIRST" {
                firstRoomCameras.append(camera)
            } else {
                secondRoomCameras.append(camera)
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    ///Удаление данных
    private func deliteData() {
        self.rooms.removeAll()
        self.firstRoomCameras.removeAll()
        self.secondRoomCameras.removeAll()
    }
    
    ///Изменение статуса избранного у камеры
    private func changeFavorites(indexPath: IndexPath, plusIndex: Int) {
        storageManager.editFavoriteCamera(
            camera: camerasList[indexPath.row + plusIndex]
        )
        print(camerasList[indexPath.row])
        tableView.reloadData()
    }
    
    ///Установка RefreshControl
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление...")
        refreshControl.addTarget(
            self,
            action: #selector(didPullToRefresh),
            for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    ///Обновление данных через RefreshControl
    @objc private func didPullToRefresh() {
        fetchData()
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}

    // MARK: - UITableViewDelegate
extension CamerasTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return section == 0 ? firstRoomCameras.count : secondRoomCameras.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CameraTableViewCell.identifier,
            for: indexPath
        ) as? CameraTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.configure(with: firstRoomCameras[indexPath.row])
        } else if indexPath.section == 1 {
            cell.configure(with: secondRoomCameras[indexPath.row])
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

    // MARK: - UITableViewDelegate
extension CamerasTableViewController {
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 279
    }
    
    override func tableView(
        _ tableView: UITableView,
        willDisplayHeaderView view: UIView,
        forSection section: Int
    ) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.systemFont(ofSize: 21, weight: .light)
        header.textLabel?.frame = header.bounds
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
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding / 2)
        cell.layer.mask = maskLayer
    }
    
    override func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        section == 0 ? "FIRST" : "SECOND"
    }
    
    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        let favoriteAction = UIContextualAction(style: .normal, title: "") {
            action, view, completion in
            
            if indexPath.section == 0, (indexPath.last ?? 1) == 0 {
                    self.changeFavorites(indexPath: indexPath, plusIndex: 0)
                completion(true)
                } else {
                    self.changeFavorites(indexPath: indexPath, plusIndex: 1)
                    completion(true)
                }
        }
        favoriteAction.image = UIImage(named: "Favorite")
        favoriteAction.backgroundColor = .clear
        favoriteAction.backgroundColor = .systemGray6
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}
