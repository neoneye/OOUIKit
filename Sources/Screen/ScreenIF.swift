//
//  ScreenIF.swift
//  OOSwift
//
//  Created by Karsten Litsche on 01.09.17.
//
//

import OOBase

public final class ScreenIF: OOScreenWrap {
    
    public init(condition: OOBool, primary: OOScreen, secondary: OOScreen) {
        super.init(origin:
            ScreenOR(
                condition: condition,
                conditionChangeListener: InformNothing(),
                primary: { _ in primary },
                secondary: { _ in secondary }
            )
        )
    }
    
}
