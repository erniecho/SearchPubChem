//
//  Compound+Extensions.swift
//  SearchPubChem
//
//  Created by Jae Seung Lee on 2/24/18.
//  Copyright © 2018 Jae Seung Lee. All rights reserved.
//

import Foundation
import CoreData

extension Compound {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        created = Date()
    }
    
    public override func awakeFromFetch() {
        super.awakeFromFetch()
        
        guard let char = name?.first else {
            return
        }
        
        firstCharacterInName = String(char).uppercased()
    }
}
