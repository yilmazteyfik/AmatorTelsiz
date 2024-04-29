import UIKit
import WebKit

class RoleViewController: UIViewController {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Arka plan UIView oluşturma ve beyaz arka plan rengi
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400))
        backgroundView.backgroundColor = UIColor.white
        view.addSubview(backgroundView)

        // WKWebView oluşturma ve arka plan UIView üzerine yerleştirme
        webView = WKWebView(frame: CGRect(x: 0, y: 120, width: self.view.frame.width, height: self.view.frame.height - 120))
        view.addSubview(webView)

        // Gömülü harita URL'sini yükleme
        if let url = URL(string: "https://www.google.com/maps/d/u/0/embed?mid=1Yu1VsHAggrFyOV8Pt6T33kq9M7jm5pQ&ehbc=2E312F") {
            let request = URLRequest(url: url)
            webView.load(request)
        }

        // UIScrollView özelliğini devre dışı bırakma
        webView.scrollView.isScrollEnabled = false
    }
}
