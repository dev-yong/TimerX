//
//  UseCaseProvider.swift
//  RealmPlatform
//
//  Created by 이광용 on 24/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

public final class UseCaseProvider: Domain.UseCaseProvider {
    private let configuration: Realm.Configuration
    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }
    public func makeEventCombinationUseCase() -> EventCombinationUseCase {
    }
}
