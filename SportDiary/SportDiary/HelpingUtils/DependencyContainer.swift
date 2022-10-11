import SwiftUI
import Swinject

func buildContainer() -> Container {

    let container = Container()

    container.register(NetworkManger.self) { _  in
        return NetworkManagerImpl()
    }
    .inObjectScope(.container)

    return container
}
