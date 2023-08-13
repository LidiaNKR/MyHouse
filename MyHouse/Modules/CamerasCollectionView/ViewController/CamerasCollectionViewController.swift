//
//  CamerasCollectionViewController.swift
//  MyHouse
//
//  Created by Лидия Некрасова on 11.08.2023.
//

import UIKit

final class CamerasCollectionViewController: UICollectionViewController {
    
    // MARK: - Private properties
    private var cameras: CameraModel?
    private var dataFetcherService: DataFetcherServiceProtocol? = DataFetcherService()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    // MARK: - Private methods
    func fetchData() {
        dataFetcherService?.fetchCamera { [weak self] cameras in
            guard let self = self else { return }
            self.cameras = cameras
            collectionView.reloadData()
        }
    }
}

//    // MARK: - UICollectionDataSource
extension CamerasCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cameras?.data.room?.count ?? 2
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return cameras?.data.cameras.count ?? 0
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CameraCollectionViewCell.identifier,
            for: indexPath
        ) as? CameraCollectionViewCell else { return UICollectionViewCell() }
        guard let camera = cameras?.data.cameras[indexPath.item] else { return cell }
        cell.configure(with: camera)
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
            sectionHeader.sectionHeaderlabel.text = "Section \(indexPath.section)"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}

class SectionHeader: UICollectionReusableView {
    @IBOutlet weak var sectionHeaderlabel: UILabel!
}
