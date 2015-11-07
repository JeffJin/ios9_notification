//
//  TodoSchedulingViewController.swift
//  twilio
//
//  Created by Zhengyuan Jin on 2015-11-06.
//  Copyright © 2015 eWorkspace Solutions Inc. All rights reserved.
//

import UIKit

class TodoSchedulingViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var deadlinePicker: UIDatePicker!

    @IBAction func savePressed(sender: UIButton) {
        let todoItem = TodoItem(deadline: deadlinePicker.date, title: titleField.text!, UUID: NSUUID().UUIDString)
        TodoVmService.instance.addItem(todoItem) // schedule a local notification to persist this item
        self.navigationController?.popToRootViewControllerAnimated(true) // return to list view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
