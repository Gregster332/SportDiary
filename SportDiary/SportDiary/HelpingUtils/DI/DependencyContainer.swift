import SwiftUI
import Swinject

func buildContainer() -> Container {

    let container = Container()

    container.register(NetworkManger.self) { _  in
        return NetworkManagerImpl()
    }
    .inObjectScope(.container)
    
    container.register(RealMManager.self) { _ in
        return RealMManagerImpl()
    }
    .inObjectScope(.container)
    
    container.register(HealthKitAssistant.self) { _ in
        return HealthKitAssistantImpl()
    }
    .inObjectScope(.container)
    
    container.register(ActivityListViewModel.self) { resolver in
        return ActivityListViewModel(realmManager: resolver.resolve(RealMManager.self)!)
    }
    .inObjectScope(.container)
    
    container.register(AddNewActivityViewModel.self) { resolver in
        return AddNewActivityViewModel(networkManager: resolver.resolve(NetworkManger.self)!,
                                       realmManager: resolver.resolve(RealMManager.self)!)
    }
    .inObjectScope(.container)
    
    container.register(UserHealthViewModel.self) { resolver in
        return UserHealthViewModel(heakthKitAssistant: resolver.resolve(HealthKitAssistant.self)!)
    }

    return container
}
