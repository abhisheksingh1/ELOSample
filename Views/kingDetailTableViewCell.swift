//
//  kingDetailTableViewCell.swift
//  GameofThrones
//
//  Created by Abhishek on 06/05/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class kingDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kingName: UILabel!
    
    @IBOutlet weak var eloScoreLbl: UILabel!
    @IBOutlet weak var totalBattle: UILabel!
    @IBOutlet weak var winBattlelbl: UILabel!
    @IBOutlet weak var defendBattle: UILabel!
    
    func configureCell(kingBattleDetail:FormatedKingsDetail)  {
        let totalBattleCount = Int(kingBattleDetail.defender!)!+Int(kingBattleDetail.attacker!)!
        kingName.text = kingBattleDetail.name
        eloScoreLbl.text = kingBattleDetail.elo
        totalBattle.text = String(totalBattleCount)
        winBattlelbl.text = kingBattleDetail.victoer
        defendBattle.text = kingBattleDetail.defender
        self.layoutIfNeeded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
