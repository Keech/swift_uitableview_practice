import UIKit

class MasterViewController: UITableViewController, AddItemViewControllerDelegate {

    var objects = NSMutableArray()

    /********************************************************************
    デリゲート用プロトコルの実装
    *********************************************************************/
    func addItemViewControllerDidFinish(controller: AddItemViewController, item: String) {
        println("addItemViewControllerDidFinish")
        //削除管理用オブジェクトに挿入
        objects.insertObject(item, atIndex: 0)
        
        //TableViewに行を挿入する
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        //モーダルを閉じる
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        println("addItemViewControllerDidCancel")
        //モーダルを閉じる
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //********************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //詳細画面へ
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as String
                (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
        //入力画面へ
        if segue.identifier == "ShowAddItemView" {
           (segue.destinationViewController.viewControllers![0] as AddItemViewController).delegate = self
        }
    }

    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = objects[indexPath.row] as? String
        
        return cell
    }
    
    //編集状態のセルにおけるアクション処理
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

