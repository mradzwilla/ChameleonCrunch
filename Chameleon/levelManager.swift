//
//  levelManager.swift
//  Chameleon
//
//  Created by Michael Radzwilla on 4/28/17.
//  Copyright © 2017 swifttutorial. All rights reserved.
//

import Foundation
import GameplayKit

class levelManager {
    //Add color array
    var level = 1
    
    var flyCount: Int {
        switch level{
        case 1,2:
            return 2
        case 3,4:
            return 5
        default:
            return 10
        }
    }
    
    var flySpeedMin:CGFloat {
        switch level{
        //Lower speeds will make fly go faster
        case 1...5:
            return 4
        default:
            return 2
        }
    }
    
    var flySpeedMax:CGFloat {
        switch level{
        case 1...5:
            return 8
        default:
            return 3
        }
    }
    
    func randomFlySpeed()->CGFloat {
        return CGFloat.random(min: flySpeedMin, max:flySpeedMax)
    }
    func nextLevel(){
        level += 1
        print("Next level: \(level)")
    }
    
    let oscillationMin:CGFloat = 0
    var oscillationMax:CGFloat {
        switch level{
        case 1...3:
            return 10
        case 4...7:
            return 100
        default:
            return 200
        }
    }
    
    func randomFlyOscillation()->CGFloat {
        return CGFloat.random(min: oscillationMin, max:oscillationMax)
    }
}
