import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var districtPicker: UIPickerView!
    @IBOutlet weak var findButton: UIButton!
    
    var provinces: [Province] = []
    var selectedProvince: Province?
    var selectedDistrict: District?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickers()
        fetchProvinces()
    }

    private func setupPickers() {
        cityPicker.delegate = self
        cityPicker.dataSource = self
        districtPicker.delegate = self
        districtPicker.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case cityPicker: return provinces.count
        case districtPicker: return selectedProvince?.districts.count ?? 0
        default: return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case cityPicker: return provinces[row].name
        case districtPicker: return selectedProvince?.districts[row].name
        default: return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case cityPicker:
            selectedProvince = provinces[row]
            districtPicker.reloadAllComponents()
            findButton.isEnabled = false
        case districtPicker:
            selectedDistrict = selectedProvince?.districts[row]
            findButton.isEnabled = true
        default: break
        }
    }

    func fetchProvinces() {
        let url = URL(string: "https://turkiyeapi.herokuapp.com/api/v1/provinces")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("API Hatası: \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(ProvinceResponse.self, from: data)
                DispatchQueue.main.async {
                    self.provinces = result.data
                    self.cityPicker.reloadAllComponents()
                    if let first = self.provinces.first {
                        self.selectedProvince = first
                        self.districtPicker.reloadAllComponents()
                    }
                }
            } catch {
                print("Veri çözümleme hatası: \(error)")
            }
        }.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "PostaKoduViewController" {
               if let destinationVC = segue.destination as? PostaKoduViewController {
                   destinationVC.provinceName = selectedProvince?.name ?? ""
                   destinationVC.districtName = selectedDistrict?.name ?? ""
                   destinationVC.plateCode = String(selectedProvince?.id ?? 0)
                   destinationVC.PopulationCount =
                   String(selectedDistrict?.population ?? 0 )
                   destinationVC.PopulationCount2 =
                   String(selectedProvince?.population ?? 0 )
                   

               }
           }
       }

    @IBAction func findPostalCodeTapped(_ sender: UIButton) {
        if let province = selectedProvince, let district = selectedDistrict {
            print("Seçilen İl: \(province.name), İlçe: \(district.name)")
            performSegue(withIdentifier: "PostaKoduViewController", sender: self)
        }
    }

}

