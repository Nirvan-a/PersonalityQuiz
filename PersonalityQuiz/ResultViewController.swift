import UIKit

class ResultViewController: UIViewController {

    
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel!
    
    
    
    var responses: [Answer]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏返回按钮
        navigationItem.hidesBackButton = true
        //结果展示逻辑
        calculatePersonalityResult()
        
        
    }
    
    func calculatePersonalityResult() {
       //when calculating the result, you don't need the entire "Answer" structure. You care about only the "type" property of each "Answer".you can reduce "response" into a new dictionary of type [AnimalType: Int], when Int is the frequency a player selected the corresponding "AnimalType"
        let frequencyOfAnswers = responses.reduce(into: [:]) {
            (counts, answer) in
            counts[answer.type, default: 0] += 1
        }
        
//        let frequencyOfAnswers = responses.reduce(into: [AnimalType: Int]()) {
//            (counts, answer) in
//            if let existingCount = counts[answer.type] {
//                counts[answer.type] = existingCount + 1
//            }else {
//                counts[answer.type] = 1
//            }
//        }
        
        let frequentAnswerSorted = frequencyOfAnswers.sorted(by: {
            (pair1, pair2) in
            return pair1.value > pair2.value
        })
        let mostCommonAnswer = frequentAnswerSorted.first!.key
        
        //let mostCommonAnswer = frequencyOfAnswer.sorted{$0.1 > $1.1}.first!.key
        
        resultAnswerLabel.text = "Your emotion intelligence is \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
    
    
    
    
    
    //The "coder" parameter will be provided and is used by UIKit to initialize your view controller from the information defined in your "Storyboard".
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    //when you provide your own initializer, you mutst implement any "required" initializers that the superclass defines
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
