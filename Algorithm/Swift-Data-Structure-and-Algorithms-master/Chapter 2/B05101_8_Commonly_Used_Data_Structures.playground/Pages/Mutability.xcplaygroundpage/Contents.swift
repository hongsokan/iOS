//: [Previous](@previous)

import Foundation

//: ## Mutability
//:
//: Swift doesn’t require that you define separate mutable and immutable types. When you create an array, set, or dictionary variable using the var keyword it will be created as mutable object. You can modify it by adding, removing, or changing the value of items in the collection. If you create an array, set, or dictionary using the let keyword you are creating a constant object. A constant collection type cannot be modified, either by adding or removing items, or by changing the value of items in the collection.
//:

//: Mutability of Collections
//:
//: When you create an instance of a class and assign it to a constant, you cannot assign another variable to that instance, but you can modify the properties of that instance.


struct Person {
    var firstName: String
    var lastName: String
    init(firstName: String, lastName: String){
        self.firstName = firstName
        self.lastName = lastName
    }
}

class Address {
    var street: String = ""
    var city: String = ""
    var state: String = ""
    var zipcode: String = ""
    init(street: String, city: String, state: String, zipcode: String){
        self.street = street
        self.city = city
        self.state = state
        self.zipcode = zipcode
    }
}


// Create a constant instance of a Person struct

let person = Person(firstName: "John:", lastName: "Smith")

/*: 

This generates a compile time error



    person.firstName = "Erik"



**error: cannot assign to property: 'person' is a 'let' constant person.firstName = "Erik"**

*/


// Create a constant instance of an Address class
let address = Address(street: "1 Infinite Loop", city: "Cupertino", state: "CA", zipcode: "95014")

// This is valid and does not generate a compile time error, because Address is a reference type
address.city = "19111 Pruneridge Avenue"

/*:

This does generate a compile time error, because the address instance is constant and cannot be modified to point to a different instance

    address = Address(street: "19111 Pruneridge Avenue", city: "Cupertino", state: "CA", zipcode: "95014")

**error: cannot assign to value: 'address' is a 'let' constant
address = Address(street: "19111 Pruneridge Avenue", city: "Cupertino", state: "CA", zipcode: "95014")**

*/


/*:

[Next](@next)

The license for this document is available [here](License).
*/
