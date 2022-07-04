//
//  NetworkManager.swift
//  Fairytale Spin
//
//  Created by Nick M on 04.07.2022.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    
    let monitor =   NWPathMonitor()
    let queue =     DispatchQueue(label: "NetworkManager")
    
    @Published var isConnected = false

    init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}

