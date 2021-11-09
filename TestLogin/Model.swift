//
//  Model.swift
//  TestLogin
//
//  Created by Alexey Khestanov on 31.10.2021.
//

import Foundation

// MARK: - Adress definitions

struct UserAdress {

    var index: Int
    var region: String
    
    enum CityType: String {
        case city = "г."
        case villageBig = "д."
        case villageSmall = "c."
        case villageCity = "пгт."
    }
    
    private var districtName: String?
    
    var district: String {
        districtName != nil ? districtName! + " р-н" : ""
    }
    
    private var cityName: String
    private var cityType: CityType
    
    var city: String {
        cityType.rawValue + " " + cityName
    }
    
    enum StreetType: String {
        case avenue = "пр."
        case street = "ул."
        case lane = "пер."
        case embankment = "наб."
        case highway = "ш."
        case boulevard = "бул."
    }
    
    private var streetType: StreetType
    private var streetName: String
    
    var street: String {
        streetType.rawValue + " " + streetName
    }
    
    var house: String
    var flat: String?
    
    var fullAdress: String {
        var tmpAdress = String(index) + ", "
        if region != "Москва" && region != "Санкт-Петербург" {
            tmpAdress += region + ", " + district + "," + city + ", "
        } else {
            tmpAdress += CityType.city.rawValue + " " + region + ", "
        }
        if let tmpFlat = flat {
            return tmpAdress + street + ", д. " + house + ", кв. " + tmpFlat
        } else {
            return tmpAdress + street + ", д. " + house
        }
    }
    
    
    // Квартира как строка, например, 12А
    init?(index: Int, region: String, district: String?, cityType: CityType, cityName: String, streetType: StreetType, streetName: String, house: String, flat: String?) {
        if index >= 100000 && index < 999999 && region != "" && cityName != "" && streetName != "" && house != "" {
            self.index = index
            self.region = region
            self.districtName = district
            self.cityType = cityType
            self.cityName = cityName
            self.streetType = streetType
            self.streetName = streetName
            self.house = house
            self.flat = flat
        } else {
            return nil
        }
    }

    // Квартира как число
    init?(index: Int, region: String, district: String?, cityType: CityType, cityName: String, streetType: StreetType, streetName: String, house: String, flat: Int?) {
        if let tmpFlatInt = flat {
            guard tmpFlatInt > 0 && tmpFlatInt <= 100000 else { return nil }
            self.init(index: index, region: region, district: district, cityType: cityType, cityName: cityName, streetType: streetType, streetName: streetName, house: house, flat: String(tmpFlatInt))
        } else {
            // Чтобы избежать ошибки распознания конкретного инициализатора при передаче в него nil
            let nilStrFlat: String? = nil
            self.init(index: index, region: region, district: district, cityType: cityType, cityName: cityName, streetType: streetType, streetName: streetName, house: house, flat: nilStrFlat)
        }
    }
}

// MARK: - User Info Definition

// Проблема структуры в том что правильность значений проверяется только при инициализации...
struct SingleUserInfo {
    var isDeleted: Bool
    var firstName: String
    var surName: String
    var password: String
    var email: String?
    var telegram: String?
    var adress: UserAdress?
    
    private var hobbyList: [String]
    
    var fullName: String {
        firstName + " " + surName
    }
    
    var userInfo: SingleUserInfo {
        self
    }
    
    mutating func addHobby(_ hobby: String) {
        if !hobbyList.contains(hobby) {
            hobbyList.append(hobby)
        }
    }
    
    var hobbies: [String] {
        hobbyList
    }
    
    init?(firstName: String, surName: String, password: String, email: String? = nil, telegram: String? = nil, adress: UserAdress? = nil, hobbyList: [String] = []) {
        guard firstName != "", surName != "", password != "" else { return nil }
        // MARK: - !!! Вопрос Никите !!!
        // А такая проверка точно безопасная? с учетом "ленивости" вычислений в swift.
        // Или лучше заморочиться с if let?
        if (email != nil && !email!.contains("@") && !email!.contains(".")) || (telegram != nil && telegram!.first != "@") {
            return nil
        }
        self.isDeleted = false
        self.firstName = firstName
        self.surName = surName
        self.password = password
        self.email = email
        self.telegram = telegram
        self.adress = adress
        self.hobbyList = []
        for hobby in hobbyList {
            self.addHobby(hobby)
        }
    }
    
    init?(_ userInfo: SingleUserInfo) {
        guard userInfo.firstName != "", userInfo.surName != "", userInfo.password != "", !userInfo.isDeleted else { return nil }
        self = userInfo
    }
    
    // Это явный "костыль", он нужен так как я в дочерние View передаю структуру SingleUserInfo и класс тут же ругается на отсутствие инициализатора
    init() {
        self.isDeleted = false
        self.firstName = ""
        self.surName = ""
        self.password = ""
        self.email = nil
        self.telegram = nil
        self.adress = nil
        self.hobbyList = []
    }
    
    mutating func update(_ userInfo: SingleUserInfo) {
        self = userInfo
    }
}

struct UsersInfo {
    // Словарь вида [login : userInfo]
    var users: [String: SingleUserInfo]
    
    mutating func addUser(login: String, firstName: String, surName: String, password: String, email: String? = nil, telegram: String? = nil, adress: UserAdress? = nil, hobbyList: [String]) -> Bool {
        guard login != "" else { return false }
        if let userInfo = SingleUserInfo.init(firstName: firstName, surName: surName, password: password, email: email, telegram: telegram, adress: adress, hobbyList: hobbyList) {
            return self.addUser(login: login, userInfo: userInfo)
        } else {
            return false
        }
    }

    mutating func addUser(login: String, userInfo: SingleUserInfo) -> Bool {
        if users[login] != nil {
            return false
        }
        if let userInfo: SingleUserInfo = .init(userInfo) {
            users[login] = userInfo
        }
        return true
    }
    
    init() {
        users = [:]
    }

}


// MARK: - User Data Init

var userList = FillUserData()


func FillUserData() -> UsersInfo {
    let nilString: String? = nil
    var users: UsersInfo = .init()
    _ = users.addUser(
                  login: "KravtsovaA",
                  firstName: "Анюта",
                  surName: "Кравцова",
                  password: ".KravtsovaA",
                  email: "anita.kravtsova@mail.ru",
                  telegram: nil,
                  adress: .init(index: 107065, region: "Москва", district: nil, cityType: .city, cityName: "Москва", streetType: .highway, streetName: "Сахалинская", house: "7 к. 2", flat: 57),
                  hobbyList: ["Алан", "Кот", "Бег", "Леша", "Питер"]
                 )
    _ = users.addUser(
                  login: "IvanovI",
                  firstName: "Иван",
                  surName: "Иванов",
                  password: ".IvanovI",
                  email: "ivanov122@mail.ru",
                  telegram: nil,
                  adress: nil,
                  hobbyList: ["Плавание", "Бег"]
                 )
    _ = users.addUser(
                  login: "PetrovP",
                  firstName: "Петр",
                  surName: "Петров",
                  password: ".PetrovP",
                  email: "petrov.p@gmail.com",
                  telegram: "@petrov123",
                  
                  hobbyList: ["Компьютерные игры", "Путешествия", "Программирование"]
                 )
    _ = users.addUser(
                  login: "ElisovaA",
                  firstName: "Александра",
                  surName: "Елисова",
                  password: ".ElisovaA",
                  email: "Elisova_AM@mail.ru",
                  telegram: nil,
                  adress: .init(index: 127591, region: "Московская область", district: "Истринский", cityType: .villageSmall, cityName: "Рождествено", streetType: .boulevard, streetName: "Сиреневый", house: "5", flat: 59),
        hobbyList: ["Испанский язык", "Путешествия", "Шитье"]
                 )
    _ = users.addUser(
                  login: "SidorovP",
                  firstName: "Петр",
                  surName: "Сидоров",
                  password: ".SidorovP",
                  email: "sidorov_p@gmail.com",
                  telegram: "@petrov123",
                  adress: .init(index: 542600, region: "Псковская область", district: "Порховский", cityType: .villageBig, cityName: "Москва", streetType: .street, streetName: "Ленина", house: "12", flat: nilString),
                  hobbyList: ["Литрбол"]
                 )
    _ = users.addUser(
                  login: "MaratovaM",
                  firstName: "Мария",
                  surName: "Маратова",
                  password: ".MaratovaM",
                  email: "maratova@inbox.ru",
                  telegram: nil,
        adress: .init(index: 148192, region: "Санкт-Петербург", district: nil, cityType: .city, cityName: "Санкт-Петербург", streetType: .avenue, streetName: "Мориса Торезе", house: "26", flat: 101),
                  hobbyList: ["Пение", "Плавание", "Прогулки"]
                 )
    
    return users
}




