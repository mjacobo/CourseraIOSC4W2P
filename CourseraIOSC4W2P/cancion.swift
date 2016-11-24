//
//  cancion.swift
//  CourseraIOSC4W2P
//
//  Created by Leyenda Software on 11/19/16.
//  Copyright © 2016 Mauricio Jacobo. All rights reserved.
//

import Foundation

struct cancion {
    var portada:String
    var titulo:String
    var cancionArch:String
    
    init(portada: String, titulo:String, cancionArch: String) {
        self.portada     = portada
        self.titulo      = titulo
        self.cancionArch = cancionArch
    }
}
