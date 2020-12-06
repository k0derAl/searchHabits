
import Foundation

class ConfiguratorMainVC {
    func configure(
        view: MainViewController,
        networking: NetworkServiceProtocol) {
        let presenter = PresenterMainVC(
            view,
            networking)
        view.presenter = presenter
    }
}

