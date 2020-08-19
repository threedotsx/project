import UIKit
class CategoryController: UIViewController {
    var categoryArray : Category?
    var index : Int = 0
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var CostLabel: UILabel!
    @IBOutlet var LostLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = categoryArray?.name
        CostLabel.text = categoryArray?.cost
        LostLabel.text = categoryArray?.lost

    }
    

    
    


}
