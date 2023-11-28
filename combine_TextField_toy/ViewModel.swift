//
//  ViewModel.swift
//  combine_TextField_toy
//
//  Created by MAC on 11/28/23.
//

import Foundation
import Combine

class ViewModel {
    let myID = "abc"
    let myPassword = "123"
    
    @Published var inPutId: String = ""
    @Published var inPutPassword: String = ""
    
}
