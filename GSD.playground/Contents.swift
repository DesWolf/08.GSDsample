import UIKit
import PlaygroundSupport

//верхнеуровняя работа с потоками через очереди GSD

class MyViewController: UIViewController {
    
    var button = UIButton()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hey Hey"
        view.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
    }

    @objc func pressAction() {
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initButton()
    }
    
    func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.setTitle("Wooo", for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(button)
    }
}
class SecondViewController: UIViewController {
    
    var image = UIImageView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hey Hey2"
        view.backgroundColor = UIColor.white
        
        loadPhoto()
//        let imageURL: URL = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
//        if let data = try? Data(contentsOf: imageURL) {
//            self.image.image = UIImage(data: data)
//        }
    }

    func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = view.center
        view.addSubview(image)
    }
    func loadPhoto() {
        let imageURL: URL = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
            
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
                
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initImage()
    }
}
let vc = MyViewController()
let navbar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navbar
