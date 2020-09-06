
import UIKit
import SDWebImage
import AVKit
import AVFoundation
//import MBProgressHUD

class MoviesVC: UIViewController {

    @IBOutlet weak var historyLb: UILabel!
    @IBOutlet weak var MoviesTable: UITableView!
    @IBOutlet weak var searchMoviesBar: UISearchBar!
    
    //var user: User
    var arrOfMedia: [Media] = []
    var filterMedia:[Media] = []
    var testingFilter: [ItunesMedia] = []
    
    var dataType: DataType = .music
    var searchText: String = ""
    var lastChar: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        searchMoviesBar.delegate = self
        
        constants.delegationTableView(viewController: self, table: MoviesTable)
        
        MoviesTable.register(UINib(nibName: "MoviesCell", bundle: nil), forCellReuseIdentifier: "moviesCellId")

        constants.hideNavigation(self)
        
    }
    
    func getData() {
     guard let emailCashed = UserDefaults.standard.object(forKey: constants().lastLoginAccontEmail)
     else {return}
         filterMedia = []
        DataBaseManager.shared.getHistory(emailCashed: emailCashed as! String) { (selected) in
            let media = Media(artworkUrl100: selected[DataBaseManager.shared.imageInCell],
                              artistName: selected[DataBaseManager.shared.name],
                              trackName: selected[DataBaseManager.shared.name],
                              longDescription: selected[DataBaseManager.shared.description],
                              previewUrl: selected[DataBaseManager.shared.previewUrl],
                              kind: selected[DataBaseManager.shared.kind]

            )
            
            switch self.dataType {
                
            case .music:
                if media.kind == kindOfData.song.rawValue {
                self.filterMedia.insert(media, at: 0)
                    self.MoviesTable.reloadData()
                    
                }
            case .tvShow:
                if media.kind == kindOfData.tv_episode.rawValue {
                 self.filterMedia.insert(media, at: 0)
                    self.MoviesTable.reloadData()

                 }
            case .movie:
                if media.kind == kindOfData.feature_movie.rawValue {
                 self.filterMedia.insert(media, at: 0)
                    self.MoviesTable.reloadData()

                 }
            }
            
        }
        
    }

    
    @IBAction func mediaType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            
        case 0:
            dataType = .music
            getContent(dataType: "music", searchText: searchText)
        case 1:
            dataType = .tvShow
            getContent(dataType: "tvShow", searchText: searchText)
        case 2:
            dataType = .movie
            getContent(dataType: "movie", searchText: searchText)
        default: break
            
        }
    }
    
    func getContent(dataType:String, searchText:String) {
        
        if searchText == ""{
            getData()
        
        } else if lastChar == " " {
            getData()
        } else {
            ApiManager.itunesMediaLoad(dataType: dataType, searchText: searchText) { (media) in
                self.filterMedia = media.results
                self.MoviesTable.reloadData()
            }
        }
    }
    @IBAction func profile(_ sender: Any) {
      
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        
       // profileVC.user = user
        
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
  
    }


extension MoviesVC: UITableViewDataSource ,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMedia.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCellId") as! MoviesCell
        
        cell.imgView?.sd_setImage(with: URL(string: filterMedia[indexPath.row].artworkUrl100!))
        
        switch dataType {
        case .music:
            cell.movieName.text = "\(filterMedia[indexPath.row].trackName ?? "")"
            cell.longDescription.text = filterMedia[indexPath.row].artistName
            
        case .tvShow:
            cell.movieName.text = filterMedia[indexPath.row].artistName
            cell.longDescription.text = "\(filterMedia[indexPath.row].longDescription ?? "")"
        case .movie:
            cell.movieName.text = filterMedia[indexPath.row].trackName
            cell.longDescription.text = "\(filterMedia[indexPath.row].longDescription ?? "")"
        default: break
        }
        
        cell.movie = filterMedia[indexPath.row]
        
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     let cell = MoviesTable.cellForRow(at: indexPath) as! MoviesCell
     guard let emailCashed = UserDefaults.standard.object(forKey: constants().lastLoginAccontEmail)
     else {return}
     DataBaseManager.shared.insertIntoHistory(email: emailCashed as! String, cell: cell.movie!)
       
        
        
        switch dataType {
        case .music:
            performSegue(withIdentifier: "showData", sender: self)
                
            
        case .tvShow, .movie:
                let videoURL = URL(string: filterMedia[indexPath.row].previewUrl!)
            let playing = AVPlayer(url: videoURL!)
            let vc = AVPlayerViewController()
                vc.player = playing
            present(vc, animated: true)
                vc.player?.play()
            


        default:
            break
        }
        
         
                }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlayerViewController {
            destination.movieDetails = filterMedia[MoviesTable.indexPathForSelectedRow!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
            }
    
    
    

extension MoviesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        
        lastChar = "\(searchText.last ?? " ")"
        
        if searchText == "" {
             historyLb.isHidden = false
            getData()
            self.MoviesTable.reloadData()
        } else {
            historyLb.isHidden = true
            getContent(dataType: dataType.rawValue, searchText: searchText)
        }
    }

}



//        Navigation().instantiateViewController(Controller: .MovieDetalsVC, Action: .push, Navigation: self.navigationController!) { (moviesDetailsScreen) in
//            let screen = (moviesDetailsScreen as! MovieDetalsVC)
//            screen.movieDetails = cell.movie
