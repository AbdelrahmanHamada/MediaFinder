
import UIKit
import SQLite

struct DataBaseManager {
    
    static var shared = DataBaseManager()
    
    var dataBase: Connection!
    let usersTable = Table("users")
    let historySearchTable = Table("history")

    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    let pass = Expression<String>("password")
    let phone = Expression<String>("phone")
    let address = Expression<String>("address")
    let gender = Expression<String>("gender")
    let image = Expression<Data>("image")
    let description = Expression<String>("search")
    let imageInCell = Expression<String>("ImageCell") // URL "String"
    let previewUrl =  Expression<String>("previewUrl")
    let kind =  Expression<String>("kind")


    


       ///////// connect to Data Base
      func connectDataBase() {
       
        do {
            
              let documentDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
              let fileUrl = documentDir.appendingPathComponent("users").appendingPathExtension("sqlite3")
            
              let dataBasePath = try Connection(fileUrl.path)
            
            DataBaseManager.shared.dataBase = dataBasePath
            
          } catch {
          }
        
      }
        
    func tableCreated () -> Bool {
        let UsersitExists = try? DataBaseManager.shared.dataBase.scalar(DataBaseManager.shared.usersTable.exists)
        let historyitEx = try? DataBaseManager.shared.dataBase.scalar(DataBaseManager.shared.historySearchTable.exists)
        if UsersitExists == nil || historyitEx == nil {
            return true
        }
        return false
    }
    
      ///////// create Table
      func createTable() {
          let createTable = self.usersTable.create {
              (table) in
            
            table.column(id ,primaryKey: true)
            table.column(email ,unique: true)
            table.column(name)
            table.column(pass)
            table.column(phone)
            table.column(address)
            table.column(gender)
            table.column(image)
            
          }
        let createHistoryTable = self.historySearchTable.create {
            table in
            
            table.column(email)
            table.column(name ,unique: true)
            table.column(imageInCell)
            table.column(description)
            table.column(previewUrl)
            table.column(kind)
        }
        
          do {
             try dataBase.run(createHistoryTable)
             try dataBase.run(createTable)
            
          } catch {
            print ("error in ceriation ")
          }
      }
    
    
    // insert User
    
    func insertUser (user: User ,handleError : @escaping (_ action :Error) -> Void) {

            let insertUser = self.usersTable.insert (
                
                self.name <- user.name!,
                self.email <- user.email!,
                self.pass <- user.password,
                self.phone <- user.phoneNum,
                self.address <- user.address,
                self.gender <- user.gender,
                self.image <- user.image.imageData!

            )
              
              do {
                 try self.dataBase.run(insertUser)
              }
              catch{
                handleError(error)
              }

    }
    func insertIntoHistory (email: String ,cell: Media) {
        let insertSearch = self.historySearchTable.insert (
            
            self.email <- email,
            self.name <- cell.artistName ?? cell.trackName!,
            self.imageInCell <- cell.artworkUrl100 ?? "",
            self.description <- cell.longDescription ?? "",
            self.previewUrl <- cell.previewUrl ?? "",
            self.kind <- cell.kind ?? ""
            
        )
        
        do {
            try self.dataBase.run(insertSearch)
        } catch {
            print(error)
        }
    }
    
    
  func getHistory(emailCashed: String ,handle: @escaping (_ selected: Row) -> Void ) {
        var selected :Row?
        do {
            
        let historyArr = try self.dataBase.prepare(self.historySearchTable)
            for data in historyArr {
              let email = try data.get(self.email)
                if email ==  emailCashed {
                    selected = data
                    guard selected != nil else {
                        return
                    }
                    handle(selected!)
                }
            }
        } catch {
            print(error)
        }

        
    }
    // filter User
    
    func filterTableOfUsers(emailTextField: String, handle : @escaping (_ selected: Row) -> Void ) {
        
        var selected :Row?
        
        do {
         let users = try self.dataBase.prepare(self.usersTable)
            for i in users {
              let emailDB = try i.get(self.email)
                if emailDB == emailTextField {
                    selected = i
                    break
                }
            }
        } catch {
            print(error)
        }
        guard selected != nil else {
            return
        }
        handle(selected!)
        
    }
    
    
    func getUserByID(id :Int , handle : @escaping (_ selected: Row) -> Void) {
        var selected :Row?
         
         do {
         let users = try self.dataBase.prepare(self.usersTable)
             for i in users {
               let user = try i.get(self.id)
                 if user == id {
                     selected = i
                     break
                 }
             }
         } catch {
             print(error)
         }
         guard selected != nil else {
             return
         }
         handle(selected!)
    }

    func getUserByEmail(email :String , handle : @escaping (_ selected: Row) -> Void) {
        var selected :Row?
         do {
         let users = try self.dataBase.prepare(self.usersTable)
             for row in users {
                let user = try row.get(self.email)
                 if user == email {
                     selected = row
                     break
                 }
             }
         } catch {
             print(error)
         }
         guard selected != nil else {
             return
         }
        
         handle(selected!)
    }

    func GetDataForProfile (email: String, completionHandler: @escaping
        (_ email: String ,
        _ password: String,
        _ phone: String,
        _ image: Data,
        _ country: String,
        _ name: String,
        _ gender: String
        ) -> Void ){
        
        var selected: Row?
        
        do {
        let users = try self.dataBase.prepare(self.usersTable)
            for row in users {
               let user = try row.get(self.email)
                if user.lowercased() == email.lowercased() {
                    selected = row
                    break
                }
            }
        } catch {
            print(error)
        }
        guard selected != nil else {
            return
        }
        completionHandler(selected![self.email],selected![self.pass],selected![self.phone],selected![self.image],selected![self.address],selected![self.name],selected![self.gender])
    }

      ///////// list User

    func listUsers(){
          do {
            let users = try self.dataBase.prepare(self.usersTable)
            for i in users {
                print(i)
            }
          }
          catch {
              print(error)
          }
    }

      
      ///////// update User

      func updateUser<T:UIViewController>(_ view: T) {
          let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
          alert.addTextField { (text) in
              text.placeholder = "Id"
          }
          alert.addTextField { (text) in
              text.placeholder = "email"
          }
          let action = UIAlertAction(title: "Submit", style: .default) { _ in
              
              guard let id = alert.textFields?.first?.text,
                  let email =  alert.textFields?.last?.text,
                  let userId = Int(id)
              else { return }
              
              let user = self.usersTable.filter(self.id == userId)
              let updateUser = user.update(self.email <- email)
              do {
                 try self.dataBase.run(updateUser)
              }
              catch{
                  print(error)
              }
          }

          alert.addAction(action)
        view.present(alert,animated: true)
      }
      
      ///////// delete User
    

    
    
    func deleteUser <T: UIViewController> (_ view: T) {
              let alert = UIAlertController(title: "Delete User", message: nil, preferredStyle: .alert)
              alert.addTextField { (text) in
                  text.placeholder = "Id"
              }
              let action = UIAlertAction(title: "Submit", style: .default) { _ in
                  
                  guard let id = alert.textFields?.first?.text,
                      let userId = Int(id)
                  else { return }
                  
                  let user = self.usersTable.filter(self.id == userId).delete()
                  do {
                     try self.dataBase.run(user)
                  }
                  catch{
                      print(error)
                  }
              }

              alert.addAction(action)
        view.present(alert,animated: true)
      }
}
