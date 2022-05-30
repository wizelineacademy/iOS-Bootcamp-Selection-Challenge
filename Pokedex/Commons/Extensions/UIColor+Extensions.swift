//
//  UIColor+Extensions.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

extension UIColor {

    // swiftlint:disable:next cyclomatic_complexity
    static func pokemon(_ type: PokemonType, alternative: Bool = false) -> UIColor {
        switch type {
        case .grass:
            return alternative ? UIColor.primaryGrass : UIColor.secondaryGrass
        case .poison:
            return alternative ? UIColor.primaryPoison : UIColor.secondaryPoison
        case .fire:
            return alternative ? UIColor.primaryFire : UIColor.secondaryFire
        case .flying:
            return alternative ? UIColor.primaryFlying : UIColor.secondaryFlying
        case .bug:
            return alternative ? UIColor.primaryBug : UIColor.secondaryBug
        case .water:
            return alternative ? UIColor.primaryWater : UIColor.secondaryWater
        case .fighting:
            return alternative ? UIColor.primaryFighting : UIColor.secondaryFighting
        case .ice:
            return alternative ? UIColor.primaryIce : UIColor.secondaryIce
        case .electric:
            return alternative ? UIColor.primaryElectric : UIColor.secondaryElectric
        case .ground:
            return alternative ? UIColor.primaryGround : UIColor.secondaryGround
        default:
            return alternative ? UIColor.primaryNormal : UIColor.secondaryNormal
        }
    }

    static let primaryWater = UIColor(red: 85.0/255, green: 158.0/255, blue: 223.0/255, alpha: 0.8)
    static let secondaryWater = UIColor(red: 105.0/255, green: 185.0/255, blue: 227.0/255, alpha: 0.8)
    static let primaryGrass = UIColor(red: 95.0/255, green: 188.0/255, blue: 81.0/255, alpha: 0.8)
    static let secondaryGrass = UIColor(red: 90.0/255, green: 193.0/255, blue: 120.0/255, alpha: 0.8)
    static let primaryBug = UIColor(red: 146.0/255, green: 188.0/255, blue: 44.0/255, alpha: 0.8)
    static let secondaryBug = UIColor(red: 175.0/255, green: 200.0/255, blue: 54.0/255, alpha: 0.8)
    static let primaryNormal = UIColor(red: 146.0/255, green: 152.0/255, blue: 164.0/255, alpha: 0.8)
    static let secondaryNormal = UIColor(red: 163.0/255, green: 164.0/255, blue: 158.0/255, alpha: 0.8)
    static let primaryFire = UIColor(red: 251.0/255, green: 155.0/255, blue: 81.0/255, alpha: 0.8)
    static let secondaryFire = UIColor(red: 251.0/255, green: 174.0/255, blue: 70.0/255, alpha: 0.8)
    static let primaryPoison = UIColor(red: 168.0/255, green: 100.0/255, blue: 199.0/255, alpha: 0.8)
    static let secondaryPoison = UIColor(red: 194.0/255, green: 97.0/255, blue: 212.0/255, alpha: 0.8)
    static let primaryFlying = UIColor(red: 144.0/255, green: 167.0/255, blue: 218.0/255, alpha: 0.8)
    static let secondaryFlying = UIColor(red: 166.0/255, green: 194.0/255, blue: 242.0/255, alpha: 0.8)
    static let primaryFighting = UIColor(red: 206.0/255, green: 66.0/255, blue: 101.0/255, alpha: 0.8)
    static let secondaryFighting  = UIColor(red: 231.0/255, green: 67.0/255, blue: 71.0/255, alpha: 0.8)
    static let primaryIce = UIColor(red: 112.0/255, green: 204.0/255, blue: 189.0/255, alpha: 0.8)
    static let secondaryIce  = UIColor(red: 140.0/255, green: 221.0/255, blue: 212.0/255, alpha: 0.8)
    static let primaryElectric = UIColor(red: 237.0/255, green: 213.0/255, blue: 62.0/255, alpha: 0.8)
    static let secondaryElectric  = UIColor(red: 251.0/255, green: 226.0/255, blue: 115.0/255, alpha: 0.8)
    static let primaryGround = UIColor(red: 220.0/255, green: 117.0/255, blue: 69.0/255, alpha: 0.8)
    static let secondaryGround  = UIColor(red: 210.0/255, green: 148.0/255, blue: 99.0/255, alpha: 0.8)

}
