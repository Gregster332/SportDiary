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

    return container
}
