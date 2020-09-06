

import UIKit

struct ItunesMedia: Decodable {
    var resultCount: Int
    var results: [Media]
}

struct Media: Decodable {
    var artworkUrl100: String?
    var artistName: String?
    var trackName: String?
    var longDescription: String?
    var previewUrl:String?
    var kind:String?
}

enum DataType :String{
    case music
    case tvShow
    case movie
}

enum kindOfData :String {
    case song
    case tv_episode = "tv-episode"
    case feature_movie = "feature-movie"
}
