import UIKit

// Swift Fun Algorithms #7: Wrapping an Array


// assume we have a list of tracks (music)
let tracks = ["a", "b", "c", "d", "e"]

// algorithm should return this playlist if we select track "d"
 ["d", "e", "a", "b", "c"]


let selectedTrack = "d"
var playlist = [String]()
var priorTracks = [String]()

for track in tracks {
    if track == selectedTrack || playlist.count > 0 {
        playlist.append(track)
    } else {
        priorTracks.append(track)
    }
}

priorTracks
playlist

playlist + priorTracks



// other way to solve the algorithm

let index = tracks.firstIndex(where: { return $0 == selectedTrack} )
let prefixArray = tracks.prefix(upTo: index!)
let suffixArray = tracks.suffix(from: index!)

let arr = suffixArray + prefixArray
