import Foundation
import Realm
import RealmSwift

class Consumption {
    
    private let realm = try! Realm()
    
    var allRecords: Results<Record> {
        return realm.objects(Record.self).sorted(byKeyPath: "mileage", ascending: false)
    }
    
    func append(_ record:Record) {
        try! realm.write {
            realm.add(record)
        }
    }
    
//    func removeAll() {
//        try! realm.write {
//            realm.deleteAll()
//        }
//    }
    
    func delete(at index:Int) {
        let record = allRecords[index]
        try! realm.write {
            realm.delete(record)
        }
    }
    
}
