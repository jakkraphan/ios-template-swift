//
//  APIManager.swift
//  iOS-Template
//

import Foundation

class APIManager: NSObject {
    
    class var sharedInstance: APIManager {
        struct Static {
            static var instance: APIManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = APIManager()
        }
        
        return Static.instance!
    }
    
    class var hostURL: NSURL {
        let URL_HOST = NSBundle.mainBundle().infoDictionary!["URL_HOST"] as! String
        return NSURL(string: "\(URL_HOST)")!
    }
    
    class var baseURL: NSURL {
        let version = "v\(self.currentAPIVersion)"
        let hostURLString = "\(APIManager.hostURL.absoluteString)/\(version)"
        return NSURL(string: hostURLString)!
    }
    
    class var currentAPIVersion: UInt {
        return 1
    }
    
    private lazy var manager:AFHTTPRequestOperationManager = {
        let manager = AFHTTPRequestOperationManager(baseURL: APIManager.baseURL)
        manager.requestSerializer = AFJSONRequestSerializer(writingOptions: NSJSONWritingOptions.PrettyPrinted)
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/plain", "text/html", "application/json") as Set<NSObject>
        
        #if DEBUG
            manager.securityPolicy.allowInvalidCertificates = true
        #endif
        
        return manager
        }()
}

//MARK: - Basic methods
extension APIManager {
    //MARK: - Basic Methods
    
    func GET (endpoint:String,
        params:Dictionary<String, AnyObject>?,
        success:((operation:AFHTTPRequestOperation, responseObject:AnyObject?) -> Void)?,
        failure:((operation:AFHTTPRequestOperation, error:NSError?, errorDesc:String) -> Void)?) -> AFHTTPRequestOperation? {
            
            let operation = manager.GET(endpoint, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                
                if let response = responseObject as? Dictionary<String, AnyObject> {
                    
                    if let _ = response["status"] as? String {
                        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: nil)
                        failure?(operation: operation, error: error, errorDesc: NSLocalizedString("API_VERSION_DEPRECATED", comment: ""))
                        
                        return
                        
                    }
                }
                
                success?(operation: operation, responseObject: responseObject)
                
                }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                    
                    if !operation.cancelled {
                        
                        var errorDesc:String!
                        
                        if let response = operation.response {
                            errorDesc = self.getErrorDescription(response.statusCode)
                        } else {
                            errorDesc = self.getErrorDescription(0)
                        }
                        
                        failure?(operation: operation, error: error, errorDesc: errorDesc)
                        
                    } else {
                        failure?(operation: operation, error: error, errorDesc: NSLocalizedString("OPERATION_WAS_CANCELLED", comment: ""))
                    }
            }
            
            return operation
    }
    
    func POST (endpoint:String,
        params:Dictionary<String, AnyObject>?,
        success:((operation:AFHTTPRequestOperation, responseObject:AnyObject?) -> Void)?,
        failure:((operation:AFHTTPRequestOperation, error:NSError?, errorDesc:String) -> Void)?) -> AFHTTPRequestOperation? {
            
            let operation = manager.POST(endpoint, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                
                success?(operation: operation, responseObject: responseObject)
                
                }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                    
                    if !operation.cancelled {
                        
                        var errorDesc:String!
                        
                        if let response = operation.response {
                            errorDesc = self.getErrorDescription(response.statusCode)
                        } else {
                            errorDesc = self.getErrorDescription(0)
                        }
                        
                        failure?(operation: operation, error: error, errorDesc: errorDesc)
                        
                    } else {
                        failure?(operation: operation, error: error, errorDesc: NSLocalizedString("OPERATION_WAS_CANCELLED", comment: ""))
                    }
            }
            
            return operation
    }
    
    private func getErrorDescription (code:Int?) -> String {
        
        if let lCode = code {
            switch lCode {
            case 404:
                return NSLocalizedString("NOT_FOUND", comment: "")
                
            default:
                return NSLocalizedString("UNKNOW_ERROR", comment: "")
            }
        } else {
            return NSLocalizedString("UNKNOW_ERROR", comment: "")
        }
    }
}
