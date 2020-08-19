import UIKit

class PostViewController: UIViewController {
        var CategoryArray  : Category?
    
        @IBOutlet weak var categoryNameTextField: UITextField!
        @IBOutlet var categoryPriceTextField: UITextField!
        @IBOutlet var categoryLostTextField: UITextField!
        
            override func viewDidLoad() {
                super.viewDidLoad()
                categoryPriceTextField.text = CategoryArray?.cost
                categoryNameTextField.text = CategoryArray?.name
                categoryLostTextField.text = CategoryArray?.lost
               
            }
           
        @IBAction func postTapped(_ sender: Any) {
            let CategoryName = categoryNameTextField.text
            let CategoryPrice = categoryPriceTextField.text
            let CategoryLost = categoryLostTextField.text
            
                    guard CategoryName != "" && CategoryPrice != "" && CategoryLost != ""
                        else {
                        self.Alert (Message: "Вы забыли ввести данные")
                        return
            }
                    post()
                    self.navigationController?.popToRootViewController(animated: true)
        }
        func Alert (Message: String) {
               let alert = UIAlertController(title: "Ошибка", message: Message, preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "Вернуться", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
           }
            func post() {
                   let parametrs = ["name":"\(categoryNameTextField.text!)",
                                    "cost":"\(categoryPriceTextField.text!)",
                                    "lost": "\(categoryLostTextField.text!)"
                                    ]
                   
                   guard let url = URL(string: String ("https://my-json-server.typicode.com/threedotsx/demoResst/posts")) else {return}
                   var request = URLRequest(url: url)
                   request.httpMethod = "POST"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                   guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else {return}
                       request.httpBody = httpBody
                   let session = URLSession.shared
                   session.dataTask(with: request) { (data, response, error) in
                       if let response = response {
                           print(response)
                       }
                       guard let data = data else {return}
                       do {
                           let json = try JSONSerialization.jsonObject(with: data, options: [])
                           print(json)
                       } catch {
                           print(error)
                       }
                   
                   }.resume()
               }
            }
