import Foundation


class ServiceList {
    
    static let intervals = [
        "Масло ДВС" : 7_500,
        "Масло АКПП" : 40_000 ,
        "Передние колодки" : 25_000,
        "Задние колодки" : 50_000,
        "Свечи зажигания" : 110_000,
        "Тормозная жидкость" : 30_000,
        "Салонный фильтр" : 13_000,
        "Воздушный фильтр" : 25_000,
        "Антифриз" : 100_000 ,
        "Регулировка клапанов" : 45_000
    ]
    
    
    static let categories = [
        "Двигатель": ["Масло ДВС","Масляный фильтр","Салонный фильтр","Воздушный фильтр","Антифриз","Свечи зажигания","Регулировка клапанов","Топливный фильтр","Ремень генератора","Прокладка клапанной крышки","Прокладка VTEC","Заглушка распредвала","Прокладка распредвала"],
        "АКПП": ["Масло АКПП","Фильтр АКПП"],
        "Подвеска": ["Сход развал"] ,
        "Тормозная система" : ["Передние колодки","Задние колодки","Тормозная жидкость","Задние тормозные диски","Передние тормозные диски","Обслуживание передних суппортов","Обслуживание задних суппортов"],
        "Электрика" : ["Дальний свет","Передние ПТФ","Ксенон","Задние габариты","Стоп сигнал","Задний ход","АКБ"],
        "Разное" : ["Дворник водительский","Дворник пассажирский","Варка защиты картера","Переобувка"]
    ]
    
    static let types = ["Двигатель","АКПП","Подвеска","Тормозная система","Электрика","Разное"]
    
}
