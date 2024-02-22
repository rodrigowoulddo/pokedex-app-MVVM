//
//  URLResponse+Extensions.swift
//  pokedex-app
//
//  Created by Rodrigo Giglio on 21/02/2024.
//

import Foundation


extension URLResponse {

    var hasSucceded: Bool {

        let httpResponse = self as! HTTPURLResponse

        return httpResponse.statusCode == 200
    }
}
