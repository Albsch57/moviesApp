//
//  DIContainer.swift
//  Movies
//
//  Created by Влад Третьяк on 21.09.2023.
//

import Swinject

final class DIContainer {
    static let shared = DIContainer()
    private let assembler: Assembler = {
        Assembler([
            NetworkAssembly(),
            MovieSearchAssembly(),
            MovieCardAssembly(),
            PoterPreviewAssembly()
        ], container: Container())
    }()
    
    func resolve<T>(_ serviceType: T.Type) -> T? {
        assembler.resolver.resolve(serviceType)
    }
    
    func resolve<T, Arg1>(_ serviceType: T.Type, argument: Arg1) -> T? {
        assembler.resolver.resolve(serviceType, argument: argument)
    }
}
