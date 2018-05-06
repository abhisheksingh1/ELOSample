//
//  ViewController.swift
//  GameofThrones
//
//  Created by Abhishek on 05/05/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private lazy var battleEntityList = [Battle]()
    var formatedBattleResult = [FormatedKingsDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.sharedManager.requestBattleData { (battleList, errorString) in
            self.battleEntityList = battleList!
            let processData = ProcessData(battleList: self.battleEntityList)
            self.formatedBattleResult = processData.processBattleDataBasedOnAttackerAndDefender()
            print(self.formatedBattleResult)
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableViewAutomaticDimension
        customizeHeader()
    }
    
    func customizeHeader() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.getImageFromColor(UIColor(red: 253.0/255.0, green: 220.0/255.0, blue: 30.0/255.0, alpha: 1.0)), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor :UIColor.black, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 24)]
        self.title = "Game of Thrones | Kings"
    }
}

extension ViewController:UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.formatedBattleResult.count
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:kingDetailTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "tableViewIdentifier") as? kingDetailTableViewCell)!
        cell.configureCell(kingBattleDetail: self.formatedBattleResult[indexPath.row])
        return cell
    }
}

