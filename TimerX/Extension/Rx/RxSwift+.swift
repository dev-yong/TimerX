//
//  RxSwift+.swift
//  TimerX
//
//  Created by 이광용 on 29/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

extension ObservableType {
    func unwrap<T>() -> Observable<T> where Element == T? {
        return self.filter { $0 != nil }.map { $0! }
    }
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    func asDriverOnErrorJustNever() -> Driver<Element> {
        return asDriver { _ in
            return Driver.never()
        }
    }
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

extension SharedSequence {
    func unwrap<T>() -> SharedSequence<SharingStrategy, T> where Element == T? {
        return self.filter { $0 != nil }.map { $0! }
    }
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}
