//
//  PostDataModel.swift
//  XSampleApp
//
//  Created by Masaya Suzuki on 2025/03/01.
//

import Foundation
import RealmSwift

class PostDataModel: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var userName: String = ""
    @Persisted var text: String = ""
    @Persisted var recordDate: Date = Date()
    
}

