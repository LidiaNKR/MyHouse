//
//  StorageManager.swift
//  MyHouse
//
//  Created by Лидия Ладанюк on 14.08.2023.
//

import RealmSwift

protocol StorageManagerProtocol {
    var realm: Realm { get set }
    func save(object: Object)
    func deleteCamera(object: Results<Camera>)
    func deleteDoor(object: Results<Door>)
    func edit(camera: Camera)
}

final class StorageManager: StorageManagerProtocol {
    var realm = try! Realm()

    // MARK: - Work with favorite photos
    ///Сохранение информации в БД
    func save(object: Object) {
        write {
            realm.add(object)
        }
    }
    
    ///Удаление информации из БД
    func deleteCamera(object: Results<Camera>) {
        write {
            realm.delete(object)
        }
    }
    
    func deleteDoor(object: Results<Door>) {
        write {
            realm.delete(object)
        }
    }
    
    func edit(camera: Camera) {
        write {
            camera.favorites.toggle()
        }
    }

    ///Запись операций в БД
    private func write(_ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error)
        }
    }
}
