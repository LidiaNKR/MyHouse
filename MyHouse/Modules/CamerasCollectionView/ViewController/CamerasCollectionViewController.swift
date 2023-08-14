//
//  CamerasCollectionViewController.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import RealmSwift

final class CamerasCollectionViewController: UICollectionViewController {
    
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
        collectionView.collectionViewLayout = createLayout()
    }
    
    // MARK: - Private methods
    private func showData() {
        camerasList.isEmpty ? fetchData() : showRealmData()
    }
    
    private func fetchData() {
        dataFetcherService?.fetchCamera { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
//            updateData()
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
                self.collectionView.reloadData()
            }
        }
    }
    
    private func showRealmData() {
        updateData()
        for camera in camerasList {
            if camera.room == "FIRST" {
                firstRoomCameras.append(camera)
            } else {
                secondRoomCameras.append(camera)
            }
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func updateData() {
        self.rooms = []
        self.firstRoomCameras = []
        self.secondRoomCameras = []
    }
    
    private func changeFavorites(indexPath: IndexPath, indexPlus: Int) {
        storageManager.edit(camera: camerasList[indexPath.item + indexPlus])
        collectionView.reloadData()
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {

        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)

        configuration.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            guard let self = self else {
                return UISwipeActionsConfiguration()
            }

            let favoriteAction = UIContextualAction(style: .normal, title: "") { action, view, completion in
                self.changeFavorites(indexPath: indexPath, indexPlus: 0)
                completion(true)
            }
            favoriteAction.image = UIImage(named: "Favorite")
            favoriteAction.backgroundColor = .clear
            favoriteAction.backgroundColor = .systemGray6

            return UISwipeActionsConfiguration(actions: [favoriteAction])
        }
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление...")
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh() {
        fetchData()
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

    // MARK: - UICollectionDataSource
extension CamerasCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        section == 0 ? firstRoomCameras.count : secondRoomCameras.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CameraCollectionViewCell.identifier,
            for: indexPath
        ) as? CameraCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            cell.configure(with: firstRoomCameras[indexPath.row])
        } else if indexPath.section == 1 {
            cell.configure(with: secondRoomCameras[indexPath.row])
        }
        
        return cell
    }
}

extension CamerasCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: 279)
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "Header",
            for: indexPath
        ) as? SectionHeader {
            indexPath.section == 0 ?
            (sectionHeader.sectionHeaderlabel.text = "FIRST")
            : (sectionHeader.sectionHeaderlabel.text = "SECOND")
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}
