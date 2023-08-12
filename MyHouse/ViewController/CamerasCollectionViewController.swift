//
//  CamerasCollectionViewController.swift
//  MyHouse
//
//  Created by Лидия Ладанюк on 11.08.2023.
//

import UIKit


class CamerasCollectionViewController: UICollectionViewController {
    
    var cameras: CameraModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

        collectionView.register(CameraCollectionViewCell.self, forCellWithReuseIdentifier: CameraCollectionViewCell.identifier)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CameraCollectionViewCell.identifier,
                                                            for: indexPath) as? CameraCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }

    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let camera = cameras.data.cameras[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: camera)
    }
}
