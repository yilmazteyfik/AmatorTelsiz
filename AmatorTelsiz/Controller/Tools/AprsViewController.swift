import UIKit
import WebKit

class APRSViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // WKWebView oluşturma
        webView = WKWebView(frame: view.frame)
        webView.navigationDelegate = self
        view.addSubview(webView)

        // URL oluşturma
        if let url = URL(string: "https://aprs.fi/#!lat=41.04880&lng=28.95170") {
            // URL'yi yükleme
            let request = URLRequest(url: url)
            webView.load(request)
        }

        // UIScrollView özelliğini devre dışı bırakma
        webView.scrollView.isScrollEnabled = false
    }

    // İzin isteği için kullanılır
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
