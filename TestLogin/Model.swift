//
//  Model.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 31.10.2021.
//

import Foundation

    
// MARK: - Определение пользователя

struct SingleUserInfo {
    enum Gender: String {
        case male = "мужчина"
        case female = "женщина"
    }
    var gender: Gender
    var firstName: String
    var surName: String
    var email: String?
    var phone: String?
    
    var fullName: String {
        surName + " " + firstName
    }
    init? (firatName: String, surName: String, gender: Gender, email: String? = nil, phone: String? = nil) {
        guard firatName != "", surName != "" else { return nil }
        // Если почта задана, проверяем почту
        if let emailUnwrapped = email {
            guard emailUnwrapped.contains("@"), emailUnwrapped.contains(".") else { return nil }
        }
        self.firstName = firatName
        self.surName = surName
        self.gender = gender
        self.email = email
        self.phone = phone
    }
    
    
}

struct UsersInfo {
    // Словарь вида [fullUserName : userInfo]
    var usersDict: [String: SingleUserInfo]
    
    mutating func addUser(_ userInfo: SingleUserInfo) -> Bool {
        if usersDict[userInfo.fullName] == nil {
            usersDict[userInfo.fullName] = userInfo
            return true
        } else {
            return false
        }
    }
    
    // MARK: !!! Вопрос Алексею !!!
    // Рационально ли пользоваться таким вычисляемым значением?
    // Или словарь будет заново мапиться и  сортироваться при каждом его вызове и для работы лучше хранить массив?
    var asArray: [SingleUserInfo] {
        let userData = usersDict.map {$0.value}
        return userData.sorted {$0.fullName > $1.fullName}
    }
        
    var count: Int {
        usersDict.count
    }
    
    init() {
        usersDict = [:]
    }
    
}


// MARK: - Заполнение таблицы пользователей

func FillUserData() -> UsersInfo {
    var users: UsersInfo = .init()
    
    let minUsersCount = 30
    let maxUsersCount = 50
    
    var usersCount = Int.random(in: minUsersCount...maxUsersCount)
    
    enum DependsOnGender {
        case depends
        case independs
    }
    
    // [Имя: Пол]
    let firstNamesData: [String: SingleUserInfo.Gender] = [
        "Alexey": .male, "Ivan": .male, "Peter": .male, "Sergey": .male, "Nicolas": .male,
        "Paul": .male, "Robinson": .male, "Anna": .female, "Irina": .female, "Paula": .female,
        "Ekaterina": .female, "Natalia": .female, "Mark": .male, "Vanessa": .female,
        "Nikolay": .male, "Alexandra": .female, "Inga": .female
    ]
    
    // [Фамилия: Изменяемость_для_женщин] (например, Петров -> Таня Петрова или же Джексон -> Таня Джексон)
    let surNamesData: [String: DependsOnGender] = [
        "Ivanov": .depends, "Petrov": .depends, "Sidorov": .depends, "Markov": .depends,
        "Brass": .independs, "Norris": .independs, "Chumakov": .depends, "Akulov": .depends,
        "Elisov": .depends, "Koris": .independs, "Oort": .independs, "Skil": .independs,
        "Ivashenko": .independs, "Pauliner": .independs, "Moose": .independs, "Garcia": .independs,
        "Fernandez": .independs, "Gomes": .independs, "Rodriguez": .independs, "Smith": .independs,
        "Williams": .independs, "Gibson": .independs, "Jackson": .independs, "Kuznetsov": .depends,
        "Popov": .depends, "Orlov": .depends, "Nikitin": .depends, "Alekseev": .depends,
        "Vorobiev": .depends, "Korolev": .depends, "Polyakov": .depends, "Tarasov": .depends
    ]

    // Добавляем пользователей пока количество успешных попыток (уникальных пользователей) не станет нулем.
    while usersCount > 0 {
        guard let firstNameData = firstNamesData.randomElement(),
              let surNameData = surNamesData.randomElement()
        else { break }
        
        
        let firstName = firstNameData.key

        let surName: String
        
        // В случае женщин и изменяемой фамилии, добавляем "а" в конец фамилиии
        if firstNameData.value == .female && surNameData.value == .depends {
            surName = surNameData.key + "a"
        } else {
            surName = surNameData.key
        }
        
        // Делаем email.
        let email: String?
        if let mailDomain = ["gmail.com", "yahoo.com", "mail.ru", "yandex.ru", "protonmail.org"].randomElement() {
            switch Bool.random() {
            case true: email = firstName + "." + surName + "@" + mailDomain
            case false: email = surName + String(Int.random(in: 0...100000)) + "@" + mailDomain
            }
        } else {
            email = nil
        }
        
        // Делаем телефон
        let phoneNums = Array(0...9).map {(_: Int) -> String in String(Int.random(in: 0...9))}
        let phone = "+7 (" + phoneNums[0...2].joined(separator: "") + ") " +
            phoneNums[3...5].joined(separator: "") + "-" +
            phoneNums[6...7].joined(separator: "") + "-" +
            phoneNums[8...9].joined(separator: "")
 
        if let userInfo = SingleUserInfo.init(firatName: firstName, surName: surName,
                          gender: firstNameData.value, email: email, phone: phone) {
            // Такого пользователя нет - уменьшаем счетчик
            if users.addUser(userInfo) {
               usersCount -= 1
            }
        }
        
    }

    return users
}




