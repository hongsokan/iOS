//: [Previous](@previous)

import Foundation

/*:

## Protocol-Oriented Programming

A Swift protocol defines a list of methods, properties, and in some cases related types and aliases, that a type supports. The protocol forms a contract with a promise that any type that conforms to it will satisfy the requirements of the protocol.

*/


/*:

### Dispatching

Protocols in Swift are a superset of Objective-C protocols. In Objective-C all methods are resolved via __dynamic dispatch__ at runtime using __messaging__. Swift on the other hand makes use of __multiple dispatch techniques__, by _default_ it uses a __vtable__ which lists available methods in the class. A vtable is created at compile time and contains function pointers that are accessed by index. The compiler will use the vtable as a lookup table for translating method calls to the appropriate function pointer. If a Swift class inherits from an Objective-C class, then it will use dynamic dispatch at runtime. You can also force Swift to use __dynamic dispatching__ by marking class methods with the __@objc__ attribute.

*/

/*: 

### Protocol Syntax

Use the protocol keyword followed by the name for the protocol. When you define a protocol property you must specify it if is gettable or writable or both. 

*/

import AppKit

protocol MyProtocol {
    var name: String { get }
    
    func convertToImage() -> NSImage
    
}


/*:

### Examine Protocols for use in Collections

Let’s look at a few of the protocols that are used to define the Swift Collection types. We’ll examine more of these throughout the book, but this will give you an idea of how the Swift Standard Library is using protocols to design extensible types.


Let’s take a look at a more complete example of what the ParticleList implementation would look like to support the array literal syntax:

*/

struct Particle {
    var name: String
    var symbol: String
    var statistics: String
}

struct PatricleList: ExpressibleByArrayLiteral {
    
    private let items: [Particle]
    
    init(arrayLiteral: Particle...) {
        self.items = arrayLiteral
    }
}

var p1 = Particle(name: "Quark", symbol: "q", statistics: "Fermionic")
var p2 = Particle(name: "Lepton", symbol: "l", statistics: "Fermionic")
var p3 = Particle(name: "Photon", symbol: "Y", statistics: "Bosonic")

var particleList = [p1, p2, p3]

/*:
 
 The license for this document is available [here](License).
 */

