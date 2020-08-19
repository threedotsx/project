import SystemConfiguration

public class CheckInternet {
    class func Connection() -> Bool{
        var zeroAddres = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero:(0,0,0,0,0,0,0,0))
        zeroAddres.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddres))
        zeroAddres.sin_family = sa_family_t(AF_INET)
        
        let defaultRouterReachability = withUnsafePointer(to: &zeroAddres) { $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAdress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAdress)
            
 
        }
        
    }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouterReachability!, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnetion = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnetion)
        
        return ret
        
    }
 

}
