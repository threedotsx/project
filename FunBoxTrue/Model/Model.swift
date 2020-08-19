import Foundation

var categories: [Category] {
    let data = try? Data (contentsOf: urlToData)
    if data == nil {
        return []
        
    }
    let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
    if rootDictionaryAny == nil {
        return []
    }
    let rootDictionary = rootDictionaryAny as? Dictionary <String, Any>
    if rootDictionary == nil {
        return []
    }
    if let array = rootDictionary! ["posts"] as? [Dictionary<String,Any>] {
        var returnArray: [Category] = []
        
        for dict in array {
            let newCategory = Category(dictionary: dict)
            returnArray.append(newCategory)
            
        }
        return returnArray
    }
    return []
    
}
var urlToData : URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}


func loadCategory(complitionHandler :(()-> Void)?) {
    let url = URL(string: "https://my-json-server.typicode.com/threedotsx/demoResst/db")
    let session = URLSession(configuration: .default)
    let downloadTask = session.downloadTask(with: url!) { (urlFile, responce, error) in
    if urlFile != nil {
        try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
        complitionHandler?()
      
    }
}
    downloadTask.resume()
        
    
}


    
    


