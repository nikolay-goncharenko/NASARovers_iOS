//
//  TempStorage.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 02.11.2023.
//

import RealmSwift

class TempStorage: Object {
    @Persisted var rover: Routes.Rover
    @Persisted var date: String
    @Persisted var item: Int
    @Persisted var cameras: List<RoverCameras>
}
