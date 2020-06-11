//: [Previous](@previous)

import Foundation

//: ## Subscripting

//:
//: Subscripts can be defined for classes, structures, and enumerations. They are used to provide a shortcut to elements in collections, lists, and sequence types by allowing a terser syntax. They can be used to set and get elements by specifying an index instead of using separate methods to set or retrieve values.


class MovieList {
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

var movieList = MovieList()

var aMovie = movieList[0]

movieList[1] = "Forest Gump"
aMovie = movieList[1]

/*:

[Next](@next)

The license for this document is available [here](License).
*/
