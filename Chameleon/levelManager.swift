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
    var flyCountTracker = 0
    var availableColors: Array<UIColor> = [.red, .blue, .yellow, .green, .purple]

    var flyCount: Int {
        switch level{
        case 1...5:
            flyCountTracker += 1
            return flyCountTracker
        case 6:
            flyCountTracker = 3
            return flyCountTracker
        case 7...12:
            flyCountTracker += 1
            return flyCountTracker
        default:
            return 10
        }
    }
    
    var flySpeedMax:CGFloat {
        switch level{
        case 1...5:
            return 15
        case 6...10:
            return 12
        case let x where x > 10:
            return 10
        default:
            return 8
        }
    }
    
    var flySpeedMin:CGFloat {
        switch level{
        //Lower speeds will make fly go faster
        case 1...5:
            return 10
        case 6...10:
            return 6
        case 11...16:
            return 5
        case let x where x > 16:
            return 3
        default:
            return 3
        }
    }
    
    func randomFlySpeed()->CGFloat {
        return CGFloat.random(min: flySpeedMin, max:flySpeedMax)
    }
    func addColors(){
        switch level {
        case 6:
            availableColors.append(.cyan)
            availableColors.append(.orange)
        case 10:
            availableColors.append(.magenta)
        default:
            return
        }
    }
    func nextLevel(){
        level += 1
        addColors()
    }
    
    let oscillationMin:CGFloat = 0
    var oscillationMax:CGFloat {
        switch level{
        case 1...5:
            return 5
        case 6...11:
            return 15
        case 12...20:
            return 30
        default:
            return 200
        }
    }
    
    func randomFlyOscillation()->CGFloat {
        return CGFloat.random(min: oscillationMin, max:oscillationMax)
    }
}
