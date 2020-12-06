

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func getDataHabit(searchText: String, page: Int?, pageSize: Int?,  completion: @escaping ([Habit]?, Error?) -> Void)
}

class NetworkServiceImp: NetworkServiceProtocol {
    //let sessionManager = SessionManager()
    func getDataHabit(searchText: String,
                      page: Int?,
                      pageSize: Int?,
                      completion: @escaping ([Habit]?, Error?) -> Void) {
        var userData: Parameters = ["search": searchText]
        if let page = page { userData["page"] = page }
        if let pageSize = pageSize { userData["page-size"] = pageSize }
        let routing = HabitRouter.postHabitData(userData)
        AF.request(routing).responseData { (response) in
            let statusCode = response.response?.statusCode
          //  print(statusCode)
            switch response.result {
            case .success(let value):
                //add first habit in array for top row of table
                var habits: [Habit] = []
                do {
                    let jsonObject = try JSONDecoder().decode(JSONObject.self, from: value)
                    for value in jsonObject.data {
                        let habit = Habit(data: value)
                        habits.append(habit)
                    }
                    completion(habits, nil)
                } catch let error {
                    print(error)
                    completion(nil, error)
                }

            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
