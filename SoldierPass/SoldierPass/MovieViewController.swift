//
//  MovieViewController.swift
//  SoldierPass
//
//  Created by 방유빈 on 2022/08/18.
//

import UIKit
struct BoxOffice: Decodable{
    let boxOfficeResult: BoxOfficeResult
}
struct BoxOfficeResult: Decodable{
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieData]
}
struct MovieData: Decodable{
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
}

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var standardDate: UILabel!
    
    
    @IBOutlet var movieTV: UITableView!
    
    let key = "646e2c7f0a11dd7ff2d8ccbd89b085aa"
    var targetDate = "20220817"
    var dataStructure: BoxOffice?
    
    var rnum = 0
    
    var movieDataList:[[String]]=[]
    var cnt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roadData()
        print(self.movieDataList)
        movieTV.delegate = self
        movieTV.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    func roadData(){
        let baseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/" +
        "boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(targetDate)"
        
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else{
                print(error!)
                return
            }
            guard let resData = data else { return }
            do {
                self.dataStructure = try JSONDecoder().decode(BoxOffice.self, from: resData)
                
                if let list = self.dataStructure?.boxOfficeResult.dailyBoxOfficeList{
                    for movie in list{
                        var data:[String] = []
                        data.append(movie.rank)
                        data.append(movie.movieNm)
                        data.append(movie.rankInten)
                        self.rnum = Int(movie.rnum)!
                        self.movieDataList.append(data)
                    }
                    
                }
                    
            }catch{
                print("Data Parsing Error")
            }
        }
        
    }
    //tableView
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
       // cell.rank.text = self.movieDataList[indexPath.row][0]
        //cell.movieName.text = self.movieDataList[indexPath.row][1]
        //cell.rankInten.text = self.movieDataList[indexPath.row][2]
        
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnExitClick(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
