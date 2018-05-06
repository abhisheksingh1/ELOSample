//
//  ProcessData.swift
//  GameofThrones
//
//  Created by Abhishek on 06/05/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
class ProcessData {
    var battleList = [Battle]()
    
    let initialElo = 1000
    var kingsName = [String]()
    var totalAttackerPointList = [[String:Int]]()
    var defenderPointList = [[String:Int]]()
    var victoryPointsList =  [[String:Int]]()
    var eLOList = [[String:Int]]()
    
    init(battleList:[Battle]) {
        self.battleList = battleList
    }
    func processBattleDataBasedOnAttackerAndDefender()-> [FormatedKingsDetail] {
        for battle in battleList {
            if let attackerKing = battle.attacker_king, attackerKing != ""   {
                if !kingsName.contains(attackerKing) {
                    kingsName.append(attackerKing);
                    totalAttackerPointList.append([attackerKing:0])
                    defenderPointList.append([attackerKing:0])
                    victoryPointsList.append([attackerKing:0])
                    eLOList.append([attackerKing:0])
                }
                if let outCome = battle.attacker_outcome, outCome == "win" {
                    updateVictoryPointsList(name: attackerKing)
                }
                updatetotalAttackerPointList(name: attackerKing)
            }
            if let defenderKing = battle.defender_king, defenderKing != "" {
                if !kingsName.contains(defenderKing) {
                    kingsName.append(defenderKing);
                    totalAttackerPointList.append([defenderKing:0])
                    defenderPointList.append([defenderKing:0])
                    victoryPointsList.append([defenderKing:0])
                    eLOList.append([defenderKing:0])
                }
                updateDefenderPointList(name: defenderKing)
            }
        }
         getDefenderAndVictoryCountByEachKingName()
         print(GetFinalBattleFormatedData())
         return GetFinalBattleFormatedData()
    }
    
    func getDefenderAndVictoryCountByEachKingName() {
        for i in 0 ..< kingsName.count {
            var defenderNumber = 0
            var victoryNumbre = 0
            let name = kingsName[i]
            for (key, value) in defenderPointList[i] {
                if kingsName[i] == key {
                    defenderNumber += value
                }
            }
            for (key, value) in victoryPointsList[i] {
                if kingsName[i] == key {
                    victoryNumbre += value
                }
            }
            calculateELO(defenderCount: defenderNumber, victoryCount: victoryNumbre, name: name)
        }
    }
    
    func calculateELO(defenderCount:Int, victoryCount:Int, name:String = "") {
        let elo =  (initialElo*(defenderCount+victoryCount) - (400 * defenderCount) + (400 * victoryCount))/((defenderCount + victoryCount) == 0 ? 1: defenderCount + victoryCount)
        updateElo(eloValue: elo, name: name)
    }
    
    func updateElo(eloValue:Int, name:String) {
        for i in 0 ..< eLOList.count {
            for (key, value) in eLOList[i] {
                if key == name {
                    let newValue = value+eloValue
                    let newObject = [key:newValue]
                    eLOList.remove(at: i)
                    eLOList.insert(newObject, at: i)
                }
            }
        }
    }
    
    func updatetotalAttackerPointList(name:String) {
        for i in 0 ..< totalAttackerPointList.count {
            for (key, value) in totalAttackerPointList[i] {
                if key == name {
                    let newValue = value+1
                    let newObject = [key:newValue]
                    totalAttackerPointList.remove(at: i)
                    totalAttackerPointList.insert(newObject, at: i)
                }
            }
        }
    }
    func updateDefenderPointList(name:String) {
        for i in 0 ..< defenderPointList.count {
            for (key, value) in defenderPointList[i] {
                if key == name {
                    let newValue = value+1
                    let newObject = [key:newValue]
                    defenderPointList.remove(at: i)
                    defenderPointList.insert(newObject, at: i)
                }
            }
        }
    }
    
    func updateVictoryPointsList(name:String) {
        for i in 0 ..< victoryPointsList.count {
            for (key, value) in victoryPointsList[i] {
                if key == name {
                    let newValue = value+1
                    let newObject = [key:newValue]
                    victoryPointsList.remove(at: i)
                    victoryPointsList.insert(newObject, at: i)
                }
            }
        }
    }
    func GetFinalBattleFormatedData() ->[FormatedKingsDetail] {
        var kingsDetail = [FormatedKingsDetail]()
        for i in 0 ..< kingsName.count {
            var kingDetail = [String:String]()
            let kingName = kingsName[i]
            let FormatedKingsDetailEntityModel = FormatedKingsDetail.mr_createEntity(in: NSManagedObjectContext.mr_default())
            kingDetail["name"] = kingName
            kingDetail["attacker"] = (totalAttackerPointList[i][kingName])! == 0 ? "0":String((totalAttackerPointList[i][kingName])!)
            kingDetail["defender"] = (defenderPointList[i][kingName])! == 0 ? "0":String((defenderPointList[i][kingName])!)
            kingDetail["victoer"] = (victoryPointsList[i][kingName])! == 0 ? "0":String((victoryPointsList[i][kingName])!)
            kingDetail["elo"] = (eLOList[i][kingName])! == 0 ? "0":String((eLOList[i][kingName])!)
            FormatedKingsDetailEntityModel?.mr_importValuesForKeys(with: kingDetail)
            kingsDetail.append(FormatedKingsDetailEntityModel!)
        }
        return kingsDetail
    }
    
}
