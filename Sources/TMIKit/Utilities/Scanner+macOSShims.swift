//
//  Scanner+LinuxSupport.swift
//  TMIKitPackageDescription
//
//  Created by Grant Butler on 9/9/17.
//

import Foundation

#if os(OSX)
extension Scanner {
    
    func scanUpToString(_ string: String) -> String? {
        var storage: NSString?
        
        if self.scanUpTo(string, into: &storage) {
            return storage as String?
        }
        
        return nil
    }

}
#endif
