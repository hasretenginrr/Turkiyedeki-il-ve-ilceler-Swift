import UIKit

class PostaKoduViewController: UIViewController {

    var districtName: String = ""
    var provinceName: String = ""
    var plateCode: String = ""
    var PopulationCount: String = ""
    var PopulationCount2: String = ""

    @IBOutlet weak var postaKoduLabel: UILabel!
    @IBOutlet weak var ilceLabel: UILabel!
    @IBOutlet weak var ilLabel: UILabel!
    @IBOutlet weak var PopulationLabel: UILabel!
    @IBOutlet weak var PopulationLabel2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    private func updateUI() {
        ilceLabel.text = "\(districtName)"
        ilLabel.text = "\(provinceName)"
        postaKoduLabel.text = "\(plateCode)"
        PopulationLabel.text = "\(PopulationCount)"
        PopulationLabel2.text = "\(PopulationCount2)"
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

