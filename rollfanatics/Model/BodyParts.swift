//
//  BodyParts.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/23/23.
//

import Foundation

enum BodyPart: String, Identifiable, Codable {
    case head
    case neck
    
    case leftShoulder
    case rightShoulder
    
    case leftElbow
    case rightElbow
    
    case leftWrist
    case rightWrist
    
    case leftThigh
    case rightThigh
    
    case leftKnee
    case rightKnee
    
    case leftShin
    case rightShin
    
    case leftAnkle
    case rightAnkle
    
    case mainBody
    
    
    var name: String {
        rawValue.capitalized
    }

    var id: String {
        name
    }
    
}
