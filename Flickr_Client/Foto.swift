//
//  Class.swift
//  Flickr_Client
//
//  Created by Gregory House on 29.09.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class flkrFoto
{
    var owner: String
    var title: String
    var fotoURL: String
    init (ownera: String, titlea: String, fotoURLa: String)
    {
        self.owner = ownera
        self.title = titlea
        self.fotoURL = fotoURLa
    }
}

