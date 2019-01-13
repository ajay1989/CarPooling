//
//  AlertsViewController.swift
//  CarPooling
//
//  Created by Ajay Vyas on 13/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class AlertsViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "AlertsTableViewCell", bundle: nil), forCellReuseIdentifier: "AlertsTableViewCell")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btn_back_tap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertsTableViewCell", for: indexPath) as! AlertsTableViewCell
        
        return cell
        
        
    }
}
