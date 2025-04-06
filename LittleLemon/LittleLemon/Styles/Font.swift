import SwiftUI

extension Font {
    static func title() -> Font {
        return Font.custom("Markazi Text", size: 42).weight(.medium)
    }
    
    static func subtitle() -> Font {
        return Font.custom("Markazi Text", size: 32)
    }
    
    static func caption() -> Font {
        return Font.custom("Markazi Text", size: 16)
    }
    
    static func regular() -> Font {
        return Font.custom("Markazi Text", size: 18)
    }
    
    static func regularBold() -> Font {
        return Font.custom("Markazi Text", size: 18).weight(.bold)
    }
}
