//
//  UserVeiwModel.swift
//  UsersApp
//
//  Created by Maxos on 6/10/23.
//

import Foundation

class UserViewModel {
    var onLoading: ((Bool) -> Void)?
    var onSuccess: (([UserModel]) -> Void)?
    var onFailure: ((String?) -> Void)?
    
    func fetchData() {
        onLoading?(true)
        onFailure?(nil)
        NetworkingManager.fetchData { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.onSuccess?(success)
                    print(success)
                case .failure:
                    self.onFailure?("Oops, something went wrong!")
                }
                self.onLoading?(false)
            }
        }
    }
}

/*
Тестовое задание:
- Получить данные по ссылке https://my.api.mockaroo.com/users.json?key=f0ce7b20
- Отобразить данные на экране в двух режимах (Table & Collection) полей gender name age
- Добавить возможность фильтрации по возрасту (возрастание убывание).
- Добавить возможность отображения определенного пола пользователей.
- По нажатия по ячейке - отобразить все данные о выбранном человеке в отдельном окне.
- Добавить возможность перезагрузки данных
- Архитектура MVVM
*/
