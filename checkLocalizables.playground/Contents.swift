/* Check if all localizable files contain the same translations as in the localizable files.:
 
// localizables: [String] -> Array of the locatable files to be tested
 (EJ: let localizables = ["es", "en", "it", "pt"] )
 
// defaultLocalizable: String -> Default localizable file
 (EJ: let defaultLocalizable = "es")
*/

// checkLocalizables(localizables: ["es", "en", "it", "pt"], defaultLocalizable: "en")




static func checkLocalizables(localizables: [String], defaultLocalizable: String) {
    var defaultLocalizableDict = [String: String]()
    var localizablesDict = [String: [String: String]]()
    
    if let path = Bundle.main.path(forResource: defaultLocalizable, ofType: "lproj") {
        if let bundle = Bundle(path: path) {
            if let path = bundle.path(forResource: "Localizable", ofType: "strings") {
                if let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
                    defaultLocalizableDict = dict
                }
            }
        }
    }
    
    for localizable in localizables {
        if let path = Bundle.main.path(forResource: localizable, ofType: "lproj") {
            if let bundle = Bundle(path: path) {
                if let path = bundle.path(forResource: "Localizable", ofType: "strings") {
                    if let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
                        localizablesDict[localizable] = dict
                    }
                }
            }
        }
    }
    
    var missingKeys = [String: [String]]()
    for (key, value) in defaultLocalizableDict {
        for (localizable, localizableDict) in localizablesDict {
            if localizableDict[key] == nil {
                if missingKeys[localizable] == nil {
                    missingKeys[localizable] = [String]()
                }
                missingKeys[localizable]?.append(key)
            }
        }
    }
    
    for (localizable, keys) in missingKeys {
        print(" Missing keys in  \"\(localizable)\"  ----> \(keys)")
        
    }
}
