

struct ProductMain:Decodable{
    
    var status:Bool?
    var homeData:[Product]
}

struct Product:Decodable{
   
    var type:String?
    var values:[Products]
}

struct Products:Decodable{
    
    var id:Int?
    var name:String?
    var image:String?
    var actual_price:String?
    var offer_price:String?
    var offer:Int?
    var is_express:Bool?
}


