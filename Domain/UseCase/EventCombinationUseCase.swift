//
//  CountingEventUseCase.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol EventCombinationUseCase {
    func add(_ eventCombination: EventCombination,
             completion: @escaping (Result<Void, Error>) -> Void)
    func eventCombinations(completion: @escaping (Result<[EventCombination], Error>) -> Void)
    func eventCombination(of uuid: String,
                          completion: @escaping (Result<EventCombination?, Error>) -> Void)
    func update(_ eventCombination: EventCombination,
                completion: @escaping (Result<Void, Error>) -> Void)
    func delete(_ eventCombination: EventCombination,
                completion: @escaping (Result<Void, Error>) -> Void )
}
