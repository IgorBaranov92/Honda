import Foundation
import Realm
import RealmSwift

class OperationR: Object {
    
    @objc dynamic var mileage = 0
    @objc dynamic var info = ""
    @objc dynamic var price = 0
    @objc dynamic var type = ""

    
    convenience init(mileage:Int,info:String,price:Int,type:String) {
        self.init()
        self.mileage = mileage
        self.info = info
        self.price = price
        self.type = type
    }
}
