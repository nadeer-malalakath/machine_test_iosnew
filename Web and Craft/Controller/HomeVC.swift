

import UIKit

class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    

    
    var homedata = [Categories]()
    var bannersData = [Banners]()
    var productData = [Products]()
    
    var favourite = ["false","true","false","false","false","true"]
   
    
    @IBOutlet weak var searchTF: UITextField!
    
    
    @IBOutlet weak var scanImg: UIImageView!
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCollectionView.dataSource=self
        categoryCollectionView.delegate=self
        bannerCollectionView.dataSource=self
        bannerCollectionView.delegate=self
        productCollectionView.dataSource=self
        productCollectionView.delegate=self
        
        self.scanImg.image = UIImage(named: "scan")
        
        getCategories()
        getBanners()
        getProducts()
        
    }
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if(collectionView == bannerCollectionView){
            return bannersData.count
        }
        else if(collectionView == productCollectionView){
            return productData.count
        }
        
        return homedata.count
    }
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
   

  if(collectionView==bannerCollectionView){

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCvCell

        let url = URL(string: (self.bannersData[indexPath.row].banner_url)!) ?? URL(fileURLWithPath: "")

                if let data = try?Data(contentsOf: url)
                {
                    cell.bannerImg.image = UIImage(data: data)
                }
        return cell
    }
    
 else if(collectionView==productCollectionView){

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCvCell

     let attribute : NSMutableAttributedString = NSMutableAttributedString(string:productData[indexPath.row].actual_price!)
     attribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attribute.length))
     
     let url = URL(string: (self.productData[indexPath.row].image)!) ?? URL(fileURLWithPath: "")

             if let data = try?Data(contentsOf: url)
             {
             cell.image.image = UIImage(data: data)
             }
     cell.name.text = productData[indexPath.row].name
     cell.actualPrice.attributedText = attribute
     
     let offer:Int = productData[indexPath.row].offer!
     let offerNSNumber = offer as NSNumber
     let offerString : String = offerNSNumber.stringValue
     
     cell.offerLbl.text = offerString+"% OFF"
     if (productData[indexPath.row].offer_price==productData[indexPath.row].actual_price){
         cell.actualPrice.isHidden=true
         cell.offerImg.isHidden=true
         cell.offerLbl.isHidden=true
     }
     cell.expresso.backgroundColor=UIColor.yellow
     
     cell.offerPrice.text = productData[indexPath.row].offer_price
     
     cell.expresso.image = UIImage(named: "expresso")
     cell.offerImg.image = UIImage(named: "banner")
     
     cell.addBtn.layer.cornerRadius = 5
    
     if (self.favourite[indexPath.row]=="false"){
         cell.fvrtImg.image = UIImage(named: "unmarked")
     }
     else{
         cell.fvrtImg.image = UIImage(named:"marked")
     }
     
     if(productData[indexPath.row].is_express==false){
         cell.expresso.isHidden=true
     }
     
     
     cell.favouriteAction = { [self] in
         if (self.favourite[indexPath.row]=="false"){
             favourite[indexPath.row] = "true"
             cell.fvrtImg.image = UIImage(named: "marked")
             showToast(message: productData[indexPath.row].name!+" added to favourite", font: .systemFont(ofSize: 12.0))
         }
         else{
             favourite[indexPath.row] = "false"
             cell.fvrtImg.image = UIImage(named:"unmarked")
             showToast(message:productData[indexPath.row].name!+" removed from favourite", font: .systemFont(ofSize: 12.0))
         }
     }
   return cell
   }
    
    
else{
     
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCvCell
  
         let url = URL(string: (self.homedata[indexPath.row].image_url)!) ?? URL(fileURLWithPath: "")

                 if let data = try?Data(contentsOf: url)
                 {
                 cell.categoryImg.image = UIImage(data: data)
                 }
            cell.nameLbl.text = homedata[indexPath.row].name
    if (indexPath.row==0){
        cell.imgView.backgroundColor = UIColor(red: 250/255, green: 232/255, blue: 232/255, alpha: 1)
    }
    else if(indexPath.row==1)
    {
        cell.imgView.backgroundColor = UIColor(red: 246/255, green: 243/255, blue: 200/255, alpha: 1)
    }
    else if(indexPath.row==2)
    {
        cell.imgView.backgroundColor = UIColor(red: 254/255, green: 240/255, blue: 240/255, alpha: 1)
    }
    else if(indexPath.row==3)
    {
        cell.imgView.backgroundColor = UIColor(red: 233/255, green: 219/255, blue: 245/255, alpha: 1)
    }
    else if(indexPath.row==4)
    {
        cell.imgView.backgroundColor = UIColor(red: 255/255, green: 242/255, blue: 215/255, alpha: 1)
    }
    cell.imgView.layer.cornerRadius = cell.imgView.frame.size.width/2
    cell.imgView.clipsToBounds = true
    //cell.imgView.backgroundColor = UIColor.lightGray
    
       return cell
   }
}
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 130, y: self.view.frame.size.height-150, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.numberOfLines = 2
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 10.0, delay: 0.5, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
 
func getCategories()
        {
           
        CategoryViewModel.sharedInstance.getCategory().done
                {
                    response in
                    print(response.homeData[0])
            do{
                
                self.homedata = response.homeData[0].values
                self.categoryCollectionView.reloadData()
                
            }
                }.ensure {
                    
                    print("got data")
                    
                }.catch
        {_ in
                    //error in print(error)
                   // self.view.hideToastActivity()
                    //self.tableView.reloadData()
            }
        }

func getBanners()
        {
           
        BannersViewModel.sharedInstance.getBanners().done
                {
                    response in
                    print(response.homeData[1])
            do{
                
                self.bannersData = response.homeData[1].values
                
                self.bannerCollectionView.reloadData()
                
            }
                }.ensure {
                    
                    print("got data")
                    
                }.catch
        {_ in
                    //error in print(error)
                   // self.view.hideToastActivity()
                    //self.tableView.reloadData()
            }
        }
    func getProducts()
            {
               
            ProductsViewModel.sharedInstance.getProducts().done
                    {
                        response in
                        print(response.homeData[2])
                do{
                    
                    self.productData = response.homeData[2].values
                    
                    self.productCollectionView.reloadData()
                    
                }
                    }.ensure {
                        
                        print("got data")
                        
                    }.catch
            {_ in
                       
                }
            }

}

