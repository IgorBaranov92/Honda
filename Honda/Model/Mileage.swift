import Foundation
import Realm
import RealmSwift

class MileageR: Object {
    
    @objc dynamic var mileage: Int = 0
    @objc dynamic var consumption: Double = 0.0
    @objc dynamic var date: Date = Date()
    @objc dynamic var litrage: Double = 0.0
    @objc dynamic var petrol: String = ""
    @objc dynamic var place: String = ""
    @objc dynamic var type: String = ""

    
}
