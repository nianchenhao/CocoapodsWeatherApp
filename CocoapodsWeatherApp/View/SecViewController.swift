//
//  SecViewController.swift
//  CocoapodsWeatherApp
//
//  Created by 粘辰晧 on 2021/6/5.
//

import UIKit
import SVProgressHUD

protocol delegateProtocol {
    func newCityName(city: String)
}

class SecViewController: UIViewController {
    
    var delegate: delegateProtocol?
    
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBAction func getCityWeather(_ sender: UIButton) {
        // 傳遞數據到第一個view 透過delegate protocol的方式來做
        if cityTextField.text != ""{
            
            let inputCity = cityTextField.text
            
            delegate?.newCityName(city: inputCity!) // 會在第一個view controller實作
            
            self.dismiss(animated: true, completion: nil)
            
            SVProgressHUD.show()
            
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
