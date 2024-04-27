import UIKit

class QCodeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color to white
        view.backgroundColor = .white
        
        // Define QR code data: questions and answers
        let qrCodeData: [(question: String, answer: String)] = [
            ("QRA İstasyonunuzun adı nedir?", "QRA İstasyonumun adı ………. dır"),
            ("QRB İstasyonumdan ne kadar uzaktasınız?", "QRB İstasyonunuzdan ____ km uzaktayım."),
            ("QRD Nereye gidip nereden geliyorsunuz?", "QRD ____ gidiyorum, ____ den geliyorum."),
            ("QRG Tam olarak frekansımı söyler misiniz?", "QRG Tam olarak frekansınız _______ dır"),
            ("QRH Frekansınız değişiyor", "QRH Evet değişiyor."),
            ("QRH? Frekansım değişiyor mu?", "QRH? Frekansım değişiyor mu?"),
        
        ]
        
        // Vertical position for the first card
        var verticalPosition: CGFloat = 100
        
        // Create card views for each question-answer pair and add to the main view
        for qrData in qrCodeData {
            let cardView = createCardView(question: qrData.question, answer: qrData.answer)
            cardView.frame.origin.y = verticalPosition
            view.addSubview(cardView)
            verticalPosition += cardView.frame.height + 20 // Increase vertical position for next card
        }
    }
    
    func createCardView(question: String, answer: String) -> UIView {
        let cardView = UIView(frame: CGRect(x: 20, y: -50, width: view.frame.width - 40, height: 0))
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 2
        
        let questionLabel = UILabel()
        questionLabel.text = question
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        questionLabel.frame = CGRect(x: 10, y: 10, width: cardView.frame.width - 20, height: 0)
        questionLabel.sizeToFit()
        cardView.addSubview(questionLabel)
        
        let answerLabel = UILabel()
        answerLabel.text = answer
        answerLabel.numberOfLines = 0
        answerLabel.textAlignment = .center
        answerLabel.font = UIFont.systemFont(ofSize: 16)
        answerLabel.frame = CGRect(x: 10, y: questionLabel.frame.maxY + 10, width: cardView.frame.width - 20, height: 0)
        answerLabel.sizeToFit()
        cardView.addSubview(answerLabel)
        
        // Adjust card view height based on labels' height
        cardView.frame.size.height = questionLabel.frame.height + answerLabel.frame.height + 30
        
        return cardView
    }
}
