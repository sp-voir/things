//
//  PaywallConfig.swift
//  
//
//  Created by Sergey Pugach on 28.01.21.
//

import Foundation

public struct PaywallConfig: Codable/*, PaywallConfigurable*/ {
    
    public var identifier: String {
        return design.rawValue
    }
    
    public enum DesignId: String, Codable {
        case v1
        case v2
        case v2_1
    }
    
    public let name: String
    public let design: DesignId
    public let products: [String]
    public let offering: String?
    public let useOfferings: Bool
    public let profitIds: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case design = "design_id"
        case products = "product_ids"
        case offering = "offering_id"
        case useOfferings = "use_offerings"
        case profitIds = "profit_ids"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.init(
            name: try container.decode(String.self, forKey: .name),
            design: (try? container.decodeIfPresent(DesignId.self, forKey: .design)) ?? Self.default.design,
            products: (try? container.decodeIfPresent([String].self, forKey: .products)) ?? Self.default.products,
            offering: (try? container.decodeIfPresent(String.self, forKey: .offering)) ?? Self.default.offering,
            useOfferings: (try? container.decodeIfPresent(Bool.self, forKey: .useOfferings)) ?? Self.default.useOfferings,
            profitIds: (try? container.decodeIfPresent([String].self, forKey: .profitIds)) ?? Self.default.profitIds
        )
    }
    
    init(name: String, design: DesignId, products: [String], offering: String?, useOfferings: Bool, profitIds: [String]) {
        self.name = name
        self.design = design
        self.products = products
        self.offering = offering
        self.useOfferings = useOfferings
        self.profitIds = profitIds
    }
    
    static let `default`: Self = {
        Self(
            name: "Default",
            design: .v2,
            products: [],
            offering: nil,
            useOfferings: true,
            profitIds: []
        )
    }()
}

extension PaywallConfig: CustomStringConvertible {
    public var description: String {
        return """
               ⚙️ | RemoteConfig >
                    [Paywall Configuration]
                    Name: \(name)
                    Design: \(String(describing: design.rawValue))
                    Products: \(String(describing: products))
                    Use offerings: \(String(describing: useOfferings))
                    Offering id: \(String(describing: offering))
                    Profit ids: \(String(describing: profitIds))
               """
    }
}
