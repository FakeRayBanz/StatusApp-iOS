
import Foundation

var serviceContainer = ServiceCollection();

class ServiceCollection {
    private var _services: [String: Any] = [:];

    // Register a protocol and the class that will be resolved
    
    func Register<T, U>(interface: T, service: U) {
        let key = String(describing: T.self);
        _services[key] = service;
    }
    
    func Resolve<T, U>(interface: T) -> U {
        let key = String(describing: T.self);
        return _services[key] as! U;
    }
}

func DependencyInjection() {
    serviceContainer.Register(interface: IMessagingClient.self, service: MessagingClient())
}
