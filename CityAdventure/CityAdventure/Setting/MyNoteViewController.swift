//
//  MyNoteViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 18..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
class MyNoteViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
    
    @IBAction func close(sender:UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension MyNoteViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCollectionViewCell") as! NoteCollectionViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return 150
        case 2:
            return 200
        case 3:
            return 300
        default:
            return 50
        }
    }
}
