import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goToMainPage(_ sender: UIButton) {
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") {
            navigationController?.pushViewController(mainVC, animated: true)
        }
    }
}

