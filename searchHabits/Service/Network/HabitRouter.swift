

import Foundation
import Alamofire

class SittintHabitRouter {
    static let mainPath = "https://stg.ultiself.com/api/commands/get-habit-short-info-list"
    static let tempToken = "Bearer SoRJvOKwZGos5tGjzIEBBRRLgI0qVrhpgKGX5uHSZcceBVJTobXKoC2NI39m"
    
}

public enum HabitRouter: URLRequestConvertible {

    case postHabitData([String: Any])
    
    public func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case
                .postHabitData:
                return .post
            }
        }
        let params: ([String: Any]?) = {
            switch self {
            case .postHabitData(let json):
                return (json)
            }
        }()
        let url: URL = {
            // build up and return the URL for each endpoint
            let url = URL(string: SittintHabitRouter.mainPath)!
            return url
        }()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(SittintHabitRouter.tempToken, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default

            default:
                return JSONEncoding.default
            }
        }()

        return try encoding.encode(urlRequest, with: params)
    }
    
}

