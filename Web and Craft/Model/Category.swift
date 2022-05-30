

struct CategoryMain:Decodable{
    
    var status:Bool?
    var homeData:[Category]
}

struct Category:Decodable{
    
    var type:String?
    var values:[Categories]
}

struct Categories:Decodable{
    
    var id:Int?
    var name:String?
    var image_url:String?
}
