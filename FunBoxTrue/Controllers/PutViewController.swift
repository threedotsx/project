import UIKit

class PutViewController: UIViewController {
    var CategoryArray  : Category?
    @IBOutlet var categoryNameTextField: UITextField!
    @IBOutlet var categoryPriceTextField: UITextField!
    @IBOutlet var categoryLostTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func putTapped(_ sender: Any) {
        let CategoryName = categoryNameTextField.text
        let CategoryPrice = categoryPriceTextField.text
        let CategoryLost = categoryLostTextField.text
               
        guard CategoryName != "" && CategoryPrice != "" && CategoryLost != ""
                        else {
                        self.Alert (Message: "Вы забыли ввести данные")
                        return
            }
                    Put()
                    self.navigationController?.popToRootViewController(animated: true)
        }
    
    func Alert (Message: String) {
               let alert = UIAlertController(title: "Ошибка", message: Message, preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "Вернуться", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
           }
    
    func Put () {
        let parametrs = ["name":"\(categoryNameTextField.text!)",
                         "cost":"\(categoryPriceTextField.text!)",
                         "lost": "\(categoryLostTextField.text!)"
        ]
        guard let uploadData = try? JSONEncoder().encode(parametrs) else {
            return
        }
        let url = URL(string: "https://my-json-server.typicode.com/threedotsx/demoResst/posts" + "\(categories.count)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
        }
        task.resume()
    }
}
