//: [Previous](@previous)

/*: 

## Interoperability between Swift and Objective-C

 Swift has been designed to be interoperable with Objective-C. You are able to use Swift APIs in your Objective-C projects, and Objective-C APIs in your Swift projects. Apple has greatly expanded their interoperability between the two languages since Swift was originally released; there is still certain features and functionality that is not compatible between the new languages.

*/


/*: 

### Initialization

 You can directly import any Objective-C framework or C Library into Swift that supports modules, this includes all of the Objective-C system frameworks and common C libraries supplied with the system.

 To use an Objective-C framework in Swift you only need to add the import framework name to make the framework accessible.

*/

import Foundation

/*: 

Initialize an Objective-C `NSString`

    NSString *postalCode = [[NSString alloc] initWithFormat:@"%d-%d",32259, 1234];
    postalCode = “32259-1234”

Send a message to the receiver

    int len = [postalCode length];


- postalCode - is the receiver
- length - is the selector we aren't passing any parameters

- len = 10

*/


//: Using the Swift imported `NSString`

var postalCode:NSString = NSString(format: "%d-%d", 32259, 1234)
var len = postalCode.length


/*:

You can also use your classes you develop in Swift directly in Objective-C. For your Swift class to be accessible in Objective-C it must inherit from NSObject or any other Objective-C class.

If you want to override the symbol name used in Objective-C you can use the @objc(name) attribute, where name is the new symbol name you want to define. 
*/

@objc(ObjCMovieList)
class MovieList : NSObject {
    private var tracks = ["The Godfather", "The Dark Knight", "Pulp Fiction"]
    
    subscript(index: Int) -> String {
        
        get {
            return self.tracks[index]
        }
        
        set {
            self.tracks[index] = newValue
        }
    }
}


/*:

### Swift Type Compatibilty

Beginning in Swift 1.1, there is a built-in language featured called failable initialization, which allows you to define the init? method. Prior to this feature you would have been required to write factory methods to handle failures during objection creation. By using the new failable initialization pattern Swift is able to allow greater use of its uniform construction syntax and potentially remove confusion and duplication between initializers and the creation of factory methods.

*/

// Note the ‘[‘ and ‘]’ characters are invalid for a URI reg-name
// http://tools.ietf.org/html/rfc3986

if let url =  NSURLComponents(string: "http://[www].google.com") {
    // URL is valid and ready for use...
}
else {
    // One or more parts of the URL are invalid...
    // url is nil
}


/*:

If you’re writing pure Swift code, you should frugally use this feature and reserve its use for those situations were it is truly required – do not abuse its use.

Here is an example in Swift demonstrating why you should not use failable initialization in your own types.

*/

import AppKit

public struct BadParticle {
    fileprivate var name: String
    fileprivate var symbol: String
    fileprivate var statistics: String
    fileprivate var image: NSImage
}

extension BadParticle{
    // Initializers
    init?(name: String, symbol: String, statistics: String, imageName: String){
        
        self.name = name
        self.symbol = symbol
        self.statistics = statistics
        if let image = NSImage(named: imageName){
            print("initialization succeeded")
            self.image = image
        }
        else {
            print("initialization failed")
            return nil
        }
    }
}


var badQuarkParticle = BadParticle(name: "Quark", symbol: "q", statistics: "Fermionic", imageName: "QuarkImage.tiff")

//: `badQuarkParticle` is nill because the image file named “QuarkImage” was not found when trying to initialize the object.

/*:

A better implementation would be to not have the initializer handle the creation of the image and let the structure manage any errors within NSImage using an accessor function as in this example.

*/

public struct Particle {
    private var name: String
    private var symbol: String
    private var statistics: String
    fileprivate var image: NSImage
    
    public init(name: String, symbol: String, statistics: String, image: NSImage){
        self.name = name
        self.symbol = symbol
        self.statistics = statistics
        self.image = image
    }
}

extension Particle{
    public func particalAsImage() -> NSImage {
        return self.image
    }
}

var aURL = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Quark_structure_pion.svg/2000px-Quark_structure_pion.svg.png")
let anImage = NSImage(contentsOf: aURL! as URL)

var quarkParticle = Particle(name: "Quark", symbol: "q", statistics: "Fermionic", image: anImage!)
let quarkImage = quarkParticle.particalAsImage()


/*:

[Next](@next)

The license for this document is available [here](License).
*/
