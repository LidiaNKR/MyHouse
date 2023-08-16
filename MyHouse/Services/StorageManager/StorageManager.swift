//
//  StorageManager.swift
//  MyHouse
//
//  Created by Лидия Ладанюк on 14.08.2023.
//

import RealmSwift

protocol StorageManagerProtocol {
    var realm: Realm { get set }
    ///Сохранение информации в БД
    /// - Parameters:
    ///   - object: объект сохранения

    func save(object: Object)
    ///Удаление информации о камерах из БД
    /// - Parameters:
    ///   - object: объект данных камер

    func deleteCamera(object: Results<Camera>)
    
    ///Удаление информации о дверях из БД
    ///  - Parameters:
    ///   - object: объект данных дверей
    func deleteDoor(object: Results<Door>)
    
    ///Изменение статуса избранного для камеры
    ///  - Parameters:
    ///   - camera: модель камеры
    func editFavoriteCamera(camera: Camera)
    
    ///Изменение статуса избранного для двери
    ///  - Parameters:
    ///   - door: модель двери
    func editFavoriteDoor(door: Door)
    
    ///Изменение имени двери
    ///  - Parameters:
    ///   - door: модель двери
    ///   - newValue: новое имя двери
    func editDoorName(door: Door, newValue: String)
}

final class StorageManager: StorageManagerProtocol {
    var realm = try! Realm()

    // MARK: - Work with favorite photos
    func save(object: Object) {
        write {
            realm.add(object)
        }
    }
    
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
    
    func editFavoriteCamera(camera: Camera) {
        write {
            camera.favorites.toggle()
        }
    }
    
    func editFavoriteDoor(door: Door) {
        write {
            door.favorites.toggle()
        }
    }
    
    func editDoorName(door: Door, newValue: String) {
        write {
            door.name = newValue
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
