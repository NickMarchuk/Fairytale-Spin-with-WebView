//
//  SetData.swift
//  Fairytale Spin
//
//  Created by Nick M on 19.06.2022.
//

import UIKit

struct SetData{
    
    static var setPopularList: [PopularItems] {
        var items = Array<PopularItems>()
        items.append(PopularItems(backgroundImage: K.bacgroundFairy, character: K.fairy, element: K.star))
        return items
    }
    
    static var setRegularItemsList: [RegularItems] {
        var items = Array<RegularItems>()
        items.append(RegularItems(backgroundImageName: K.regularCellBlue, elementName: "frame_18"))
        items.append(RegularItems(backgroundImageName: K.regularCellGreen, elementName: "frame_10"))
        items.append(RegularItems(backgroundImageName: K.regularCellGreen, elementName: "frame_8"))
        return items
    }

    static func getImageNamesOfSelectedPack(_ selectedPack: SelectedPack, handler: ([String]) -> Void) {
        var pack = Array<String>()
        for i in 0..<9 {
            switch selectedPack {
            case .pack_1:
                pack.append("frame_\(i)")
            case .pack_2:
                pack.append("frame_\(9+i)")
            case .pack_3:
                pack.append("frame_\(18+i)")
            }
        }
       handler(pack)
    }
}
