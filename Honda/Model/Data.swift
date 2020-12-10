import Foundation

protocol AddDataDelegate : class {
    func addDataWith(mileage:Int,litrage:Double,place:String?,tripType:String,petrolType:String,differenceMileage:Int)
}


protocol ChangeOperationDelegate : class {
    func changeOperationWith(mileage:Int,price:Int,info:String,indexPath:IndexPath)
}



extension String {
    func getFirstCharacterFromString() -> String {
        return String(describing:self.first!)
    }
}

extension Double {
    func showIntegerIfPossible() -> String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(self))
        }
        return String(format:"%.1f",self)
    }
    mutating func roundedByOne() -> Double {
        return Darwin.round(self*10)/10
    }
}

extension Date {
    static func stringFromDate() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let timeZone = TimeZone(abbreviation: "GMT")
        var dateComponents = DateComponents()
        dateComponents.timeZone = timeZone
        dateFormatter.timeZone = timeZone
        dateComponents.year = calendar.component(.year, from: Date())
        dateComponents.month = calendar.component(.month, from: Date())
        dateComponents.day = calendar.component(.day, from: Date())
        dateComponents.hour = calendar.component(.hour, from: Date())
        dateComponents.minute = calendar.component(.minute, from: Date())
        dateComponents.second = calendar.component(.second, from: Date())
        let rightDate = calendar.date(from: dateComponents)
        let stringFromDate = dateFormatter.string(from: rightDate!)
        return stringFromDate
    }
    
    static func rigthDateFrom(_ selectedDate : Date) -> Date {
        var dateComponents = DateComponents()
        let calendar = Calendar.current
        dateComponents.year = calendar.component(.year, from: selectedDate)
        dateComponents.month = calendar.component(.month, from: selectedDate)
        dateComponents.day = calendar.component(.day, from: selectedDate)
        dateComponents.hour = calendar.component(.hour, from: selectedDate)
        dateComponents.minute = calendar.component(.minute, from: selectedDate)
        dateComponents.second = calendar.component(.second, from: selectedDate)
        dateComponents.timeZone = TimeZone(abbreviation: "GMT")
        let rightDate = calendar.date(from: dateComponents)!
        return rightDate
    }
}
