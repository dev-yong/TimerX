//
//  Realm+Rx.swift
//  RealmPlatform
//
//  Created by 이광용 on 19/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

extension Reactive where Base: Realm {
    func add<R: RealmRepresentable>(_ item: R, update: Bool = true) -> Observable<Void> {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.add(item.asRealm(), update: update)
                }
                observer.onNext(())
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    func delete<R: RealmRepresentable>(_ item: R) -> Observable<Void> {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.delete(item.asRealm())
                }
                observer.onNext(())
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    func delete<R: RealmRepresentable>(contentsOf items: [R]) -> Observable<Void> {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.delete(items.map { $0.asRealm() })
                }
                observer.onNext(())
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
