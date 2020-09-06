import UIKit

struct constants {
    var userCashe = "User"
    var lastAccountLogin = "lastAccount"
    var arrOfLogins = "arrOfLogins"
    var lastLoginAccontId = "lastLoginAccontId"
    var lastLoginAccontEmail = "lastLoginAccontEmail"
    var loggedHistory = "loggedHistory"
    var itunes = "https://itunes.apple.com/search?"
   
    static func hideNavigation <T :UIViewController> (_ nav :T) {
        nav.navigationController?.navigationBar.isHidden = true
    }
    
    static func delegationTableView <T: UIViewController>
        (viewController: T ,table :UITableView) {
        
        table.delegate = (viewController as! UITableViewDelegate)
        table.dataSource = (viewController as! UITableViewDataSource)
    }
}
struct CasheKey {
    var isLoggedIn = "IsLoggedIn"
    var signedUp = "SignedUP"
}

