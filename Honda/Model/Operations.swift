import Foundation
import Realm
import RealmSwift


class Operations {
    
    private let realm = try! Realm()
    
    var all: Results<OperationR> {
        return realm.objects(OperationR.self).sorted(byKeyPath: "mileage", ascending: false)
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
