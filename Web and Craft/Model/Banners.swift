
struct BannerMain:Decodable{
    
    var status:Bool?
    var homeData:[Banner]
}

struct Banner:Decodable{
   
    var type:String?
    var values:[Banners]
}

struct Banners:Decodable{
    
    var id:Int?
    var banner_url:String?
}

