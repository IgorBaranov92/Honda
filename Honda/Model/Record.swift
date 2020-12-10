import Foundation
import Realm
import RealmSwift

class Record: Object {
    
    @objc dynamic var mileage: Int = 0
    @objc dynamic var consumption: Double = 0.0
    @objc dynamic var date = ""
    @objc dynamic var litrage: Double = 0.0
    @objc dynamic var petrol: String = ""
    @objc dynamic var place: String = ""
    @objc dynamic var type: String = ""
    
    convenience init(mileage:Int,consumption:Double,date:String,litrage:Double,petrol:String,place:String,type:String) {
        self.init()
        self.mileage = mileage
        self.consumption = consumption
        self.date = date
        self.litrage = litrage
        self.petrol = petrol
        self.place = place
        self.type = type
    }

    
}
