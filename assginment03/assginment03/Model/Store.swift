//
//  Store.swift
//  assginment03
//
//  Created by JIN on 11/13/25.
//

import UIKit

struct Store {
    let storeName: String
    let rating: Double
    let reviewCount: Int
    let deliveryTime: String
    let deliveryFee: DeliveryFee
    let badges: [StoreBadge]
}


enum DeliveryFee {
    case free
    case paid(amount: Int)
    
    var displayText: String {
        switch self {
        case .free:
            return "무료배달"
        case .paid(let amount):
            return "\(amount.formattedWithComma())원"
        }
    }
}


enum StoreBadge: String {
    
    case baeminClub = "배민클럽"
    case pickupAvailable = "픽업가능"
    case fastDelivery = "빠른배달"
    case newStore = "신규"
    case couponAvailable = "쿠폰"
    
    var displayText: String {
        return self.rawValue
    }
}


extension Store {
    
    static let mockData: [Store] = [
        Store(
            storeName: "ASAP PIZZA 구로디지털...",
            rating: 5.0,
            reviewCount: 504,
            deliveryTime: "31~46분",
            deliveryFee: .free,
            badges: [.baeminClub, .pickupAvailable]
        ),
        Store(
            storeName: "레젠드 고기방송",
            rating: 4.9,
            reviewCount: 1203,
            deliveryTime: "25~40분",
            deliveryFee: .free,
            badges: [.baeminClub]
        ),
        Store(
            storeName: "교촌치킨 구로디지털점",
            rating: 4.8,
            reviewCount: 2501,
            deliveryTime: "35~50분",
            deliveryFee: .paid(amount: 2000),
            badges: [.pickupAvailable]
        ),
        Store(
            storeName: "맘스터치 구로점",
            rating: 4.7,
            reviewCount: 890,
            deliveryTime: "20~35분",
            deliveryFee: .free,
            badges: [.baeminClub, .fastDelivery]
        ),
        Store(
            storeName: "BBQ 황금올리브치킨",
            rating: 4.9,
            reviewCount: 1567,
            deliveryTime: "30~45분",
            deliveryFee: .paid(amount: 1500),
            badges: [.pickupAvailable, .couponAvailable]
        ),
        Store(
            storeName: "홍콩반점0410",
            rating: 4.6,
            reviewCount: 3421,
            deliveryTime: "40~55분",
            deliveryFee: .free,
            badges: [.baeminClub]
        ),
        Store(
            storeName: "본죽 구로디지털점",
            rating: 4.8,
            reviewCount: 756,
            deliveryTime: "25~40분",
            deliveryFee: .paid(amount: 1000),
            badges: [.newStore, .baeminClub]
        ),
        Store(
            storeName: "써브웨이 구로점",
            rating: 4.7,
            reviewCount: 432,
            deliveryTime: "15~30분",
            deliveryFee: .free,
            badges: [.fastDelivery, .pickupAvailable]
        ),
        Store(
            storeName: "굽네치킨 구로점",
            rating: 4.9,
            reviewCount: 2134,
            deliveryTime: "35~50분",
            deliveryFee: .paid(amount: 2500),
            badges: [.baeminClub, .couponAvailable]
        ),
        Store(
            storeName: "한솥도시락 구로디지털점",
            rating: 4.5,
            reviewCount: 1890,
            deliveryTime: "20~35분",
            deliveryFee: .free,
            badges: [.baeminClub, .pickupAvailable]
        )
    ]
}

