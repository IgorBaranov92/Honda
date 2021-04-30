import Foundation
import Realm
import RealmSwift


class Operations {
    
    private let realm = try! Realm()
    
    private(set) lazy var all = realm.objects(OperationR.self).sorted(byKeyPath: "mileage", ascending: false)
       
    func getOperation(_ key:String) -> OperationR {
        return realm.objects(OperationR.self)
            .sorted(byKeyPath: "mileage", ascending: false)
            .filter { $0.type == key }.first!
    }
    
    func add(_ operation:OperationR) {
        try! realm.write {
            realm.add(operation)
        }
    }
    
    func delete(at index: Int) {
        let operation = all[index]
        try! realm.write {
            realm.delete(operation)
        }
    }
    
}
