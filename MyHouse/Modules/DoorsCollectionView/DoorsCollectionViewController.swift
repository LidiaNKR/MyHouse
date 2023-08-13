//
//  DoorsCollectionViewController.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import UIKit

final class DoorsCollectionViewController: UICollectionViewController {

    // MARK: - Private properties
    private let reuseIdentifier = "doorCell"
    private var door: DoorModel?
    private var dataFetcherService: DataFetcherServiceProtocol? = DataFetcherService()
    weak var delegate: SegueHandler?
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        view.backgroundColor = .systemGray6
        collectionView.collectionViewLayout = createLayout()
    }
    
    // MARK: - Private methods
    private func fetchData() {
        dataFetcherService?.fetchDoor { [weak self] door in
            guard let self = self else { return }
            self.door = door
            collectionView.reloadData()
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            guard self == self else {
                return UISwipeActionsConfiguration()
            }
            
            let editAction = UIContextualAction(style: .normal, title: "") { action, view, completion in
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
}

    // MARK: - UICollectionDataSource
extension DoorsCollectionViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return door?.data.count ?? 0
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DoorCollectionViewCell.identifier,
            for: indexPath
        ) as? DoorCollectionViewCell else { return UICollectionViewCell() }
        guard let door = door?.data[indexPath.item] else { return cell }
        cell.configure(with: door)
        return cell
    }
}

    // MARK: - UICollectionViewDelegate
extension DoorsCollectionViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            let door = door?.data[indexPath.item]
            delegate?.segueToNext(identifier: "detailSegue", sender: door)
        }
}

    // MARK: - UICollectionViewDelegateFlowLayout
extension DoorsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: 279)
    }
}
