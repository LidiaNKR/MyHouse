//
//  DoorsCollectionViewController.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import RealmSwift

final class DoorsCollectionViewController: UICollectionViewController {

    // MARK: - Public properties
    weak var delegate: SegueHandler?
    
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
        collectionView.collectionViewLayout = createLayout()
    }
    
    // MARK: - Private methods
    private func showData() {
        doorLists.isEmpty ? fetchData() : showRealmData()
    }
    
    private func fetchData() {
        dataFetcherService.fetchDoor { [weak self] door in
            guard let self = self else { return }
            guard let door = door else { return }
            updateData()
            
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
                self.collectionView.reloadData()
            }
        }
    }
    
    func updateData() {
        self.doors.removeAll()
        self.intercom.removeAll()
    }
    
    private func showRealmData() {
        updateData()
        for door in doorLists {
            if door.snapshot == nil {
                doors.append(door)
            } else {
                intercom.append(door)
            }
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            guard self == self else {
                return UISwipeActionsConfiguration()
            }

            let editAction = UIContextualAction(style: .normal, title: "") { action, view, completion in
//                self.handleSwipe(for: action)
                completion(true)
            }
            editAction.image = UIImage(named: "Pencil")
            editAction.backgroundColor = .systemGray6

            let favoriteAction = UIContextualAction(style: .normal, title: "") { action, view, completion in
                completion(true)
            }
            favoriteAction.image = UIImage(named: "Favorite")
            favoriteAction.backgroundColor = .systemGray6

            return UISwipeActionsConfiguration(actions: [favoriteAction, editAction])
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
extension DoorsCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return section == 0 ? doors.count : intercom.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DoorCollectionViewCell.identifier,
                for: indexPath
            ) as? DoorCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: doors[indexPath.item])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IntercomCollectionViewCell.identifier,
                for: indexPath
            ) as? IntercomCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: intercom[indexPath.item])
            return cell
        }
    }
}

    // MARK: - UICollectionViewDelegate
extension DoorsCollectionViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            delegate?.segueToNext(identifier: "detailSegue", sender: doors[indexPath.item])
        }
}

    // MARK: - UICollectionViewDelegateFlowLayout
extension DoorsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 72)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 279)
        }
    }
}
