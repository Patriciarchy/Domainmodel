import Foundation

struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//

public struct Money {

    var amount : Int
    var currency : String
    
    init (amount : Int, currency : String) {
        self.amount = amount
        self.currency = currency
    }

    
    func convert(_ name: String) -> Money {
        
        let outputName = name
        
        let toUSD = self.toUSD(amount: self.amount, currency: self.currency)

        let toOther = self.toOther(amount: toUSD, currency: outputName)

        return Money(amount: Int(toOther), currency: outputName)
    }
    
    // Normalizes currency to USD
    private func toUSD(amount: Int, currency: String) -> Double {
        
        if (currency == "GBP") {
            return Double(amount) * 2.0
        } else if (currency == "EUR") {
            return Double(amount) * 2.0 / 3.0
        } else if (currency == "CAN") {
            return Double(amount) * 4.0 / 5.0
        } else if (currency == "USD") {
            return Double(amount)
        } else {
            return 0
        }
    }

    // Converts to the other currencies
    private func toOther(amount: Double, currency: String) -> Double {
        if (currency == "GBP") {
            return Double(amount) * 0.5
        } else if (currency == "EUR") {
            return Double(amount) * 3.0 / 2.0
        } else if (currency == "CAN") {
            return Double(amount) * 5.0 / 4.0
        } else if (currency == "USD") {
            return Double(amount)
        } else {
            return 0.0
        }
    }
    
    func add(input : Money) -> Money {
        if (input.currency == self.currency) {
            let num = self.amount + input.amount
            return Money(amount: num, currency: self.currency)
        } else {
            let usd = Int(toUSD(amount: input.amount, currency: input.currency)) + self.amount
            return Money(amount: usd, currency: "USD")
        }
        
    }
    
    func subtract(input : Money) -> Money {
        if (input.currency == self.currency) {
            let num = self.amount - input.amount
            return Money(amount: num, currency: self.currency)
        } else {
            let usd = self.amount - Int(toUSD(amount: input.amount, currency: input.currency))
            return Money(amount: usd, currency: "USD")
        }
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    var title : String
    var type : JobType
    
    init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    func calculateIncome (_ hours : Int) -> Int {
        switch type {
        case .Salary (let annual):
            return annual
        case .Hourly (let hourly):
            let amount = hourly * Double(hours)
            return Int(amount)
        }
    }
    
    func raise(_ amount : Any) -> Int {
        if (amount > 1) {
            switch self.type {
            case .Salary (let num):
                return Int(num) + amount
            case .Hourly (let num):
                let amount = num * Double(hours)
                return Int(amount) + amount
            }
        } else if (amount <= 1.0) {
            switch self.type {
            case .Salary (let num):
                return Int(num) + Int(Double(num) * amount)
            case .Hourly (let num):
                let amount = num * Double(hours)
                return Int(amount) + Int(Double(num) * amount)
            }
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName : String
    var lastName : String
    var age : Int
    var spouse : Person?
    var job : String?
    
    init(firstName : String, lastName : String, age : Int) {
      self.firstName = firstName
      self.lastName = lastName
      self.age = age
    }
    
    func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(jobString) spouse:\(spouseString)]"
    }
}

////////////////////////////////////
// Family
//
public class Family {
    
}
