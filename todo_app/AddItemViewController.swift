import UIKit

protocol AddItemViewControllerDelegate{
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewControllerDidFinish(controller: AddItemViewController, item: String)
    
}

class AddItemViewController: UITableViewController{
    var delegate: MasterViewController

    required init(coder aDecoder: NSCoder) {
        delegate = MasterViewController()
        super.init(coder: aDecoder)
    }

    
    @IBOutlet weak var textLabel: UITextField!
    
    @IBAction func clickedSaveButton(sender: AnyObject) {
        println("clickedSaveButton")
        self.delegate.addItemViewControllerDidFinish(self, item: self.textLabel.text)
    }
    
    @IBAction func clickedCancelButton(sender: AnyObject) {
        println("clickedCancelButton")
        self.delegate.addItemViewControllerDidCancel(self)
    }
    
    
}