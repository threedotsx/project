import UIKit

class TableViewController: UITableViewController {
   var CategoryArray  : [Category] = [Category]()
        @IBAction func refresh(_ sender: Any) {
            if CheckInternet.Connection(){
            loadCategory {
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }

        } else {
            self.Alert (Message: "Не можем подключиться, проверьте интернет соединение")
                self.refreshControl?.endRefreshing()
        }
    }
        override func viewDidLoad() {
                super.viewDidLoad()
                loadCategory {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
            }
            
        }
    
    func Alert (Message: String) {
           let alert = UIAlertController(title: "Ошибка", message: Message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return  1
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let category = categories[indexPath.row]
            cell.textLabel?.text = category.name

            return cell
        }
    
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          performSegue(withIdentifier: "CategorySegue", sender: self)
      }
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "CategorySegue" {
              if let indexPath = tableView.indexPathForSelectedRow {
                  (segue.destination as? PostViewController)?.CategoryArray = categories[indexPath.row]
                  tableView.deselectRow(at: indexPath, animated: true)
                  
          }
          }
      }
      
  
        } 

            
            



