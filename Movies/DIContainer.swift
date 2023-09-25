//
//  DIContainer.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Swinject

final class DIContainer {
    // Singleton instance of DIContainer
    static let shared = DIContainer()
    
    // Private assembler to manage dependency injection
    private let assembler: Assembler = {
        // Create an assembler with module assemblies
        Assembler([
            NetworkAssembly(),
            MovieSearchAssembly(),
            MovieCardAssembly(),
            PoterPreviewAssembly()
        ], container: Container())
    }()
    
    // Resolve a service of type T
    func resolve<T>(_ serviceType: T.Type) -> T? {
        return assembler.resolver.resolve(serviceType)
    }
    
    // Resolve a service of type T with an argument of type Arg1
    func resolve<T, Arg1>(_ serviceType: T.Type, argument: Arg1) -> T? {
        return assembler.resolver.resolve(serviceType, argument: argument)
    }
}
