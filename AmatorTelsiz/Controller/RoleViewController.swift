import UIKit
import WebKit

class RoleViewController: UIViewController {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // WKWebView oluşturma
        webView = WKWebView(frame: view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // WebView boyutunu otomatik olarak ayarla
        view.addSubview(webView)

        // Gömülü harita URL'sini yükleme
        if let url = URL(string: "https://www.google.com/maps/d/u/0/embed?mid=1Yu1VsHAggrFyOV8Pt6T33kq9M7jm5pQ&ehbc=2E312F") {
            let request = URLRequest(url: url)
            webView.load(request)
        }

     
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            // Arka tuşa basıldığında veya geri gidildiğinde
            self.tabBarController?.tabBar.isHidden = false // Tab barı görünür yap
        }
    }

}
