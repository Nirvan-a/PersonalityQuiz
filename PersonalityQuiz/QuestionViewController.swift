import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var rangedStackView: UIStackView!
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    @IBOutlet var multiLabel1: UILabel!
    @IBOutlet var mutiLabel2: UILabel!
    @IBOutlet var mutiLabel3: UILabel!
    @IBOutlet var mutiLabel4: UILabel!
    
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    
    @IBOutlet var questionProgressView: UIProgressView!
    

    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwtich2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    @IBOutlet var rangedSlider: UISlider!
    
    
    //初始化每一个问题并加入列表
    var question: [Question] = [
        Question(text: "Do you often give helpful feedback to others 🧐?", type: .single,
                 answer: [Answer(text: "Yes, I do", type: .om),
                          Answer(text: "I don't care about that", type: .sa),
                          Answer(text: "Depending on who are they", type: .oa),
                          Answer(text: "No, I seldom give helpful feedback", type: .sm),
                          ]),
        Question(text: "If you want to make a friend of the opposite sex, what will you do 🙈?", type: .single,
                 answer: [Answer(text: "Talk to him/her directly", type: .om),
                          Answer(text: "Send message to him/her first", type: .oa),
                          Answer(text: "Indicate and wait for replying", type: .sm),
                          Answer(text: "I won't do something actively", type: .sa)].shuffle()),
        Question(text: " Can you realize when others are using your emotions to manipulate or control you 😤？", type: .single,
                 answer: [Answer(text: "Of couse I can", type: .sa),
                          Answer(text: "Sometimes I can", type: .sm),
                          Answer(text: "Actually, I don't know", type: .om),
                          Answer(text: "I can never realize it", type: .oa),
                          ]),
        Question(text: "How much do you enjoy car rides 🚗?", type: .ranged,
                 answer: [Answer(text: "I dislike them", type: .sa),
                          Answer(text: "I get a little nervous", type: .sm),
                          Answer(text: "I barely notice them", type: .om),
                          Answer(text: "I love them", type: .oa)]),
        Question(text: "Do you think you have a balanced view of youself 👤?", type: .ranged,
                 answer: [Answer(text: "Rarely", type: .om),
                          Answer(text: " ", type: .oa),
                          Answer(text: " ", type: .sa),
                          Answer(text: "Mostly", type: .sm)]),
        Question(text: "How much can you learn from a failure 🥉?", type: .ranged,
                 answer: [Answer(text: "Never", type: .oa),
                          Answer(text: "", type: .sa),
                          Answer(text: "", type: .sm),
                          Answer(text: "As much as posible", type: .om)]),
        Question(text: "If you feel very nervous about something, which activities will you do probably 🥶?", type: .multiple,
                 answer: [Answer(text: "Assuming every possible future situations of the thing.", type: .om),
                          Answer(text: "Share my thoughts with my partners", type: .oa),
                          Answer(text: "Free to do something I like", type: .sm),
                          Answer(text: "Try to forget it first", type: .sa)].shuffle()),
        Question(text: "After you have got financial freedom, which activities will you do 🏖?", type: .multiple,
                 answer: [Answer(text: "Challenge extreme sports", type: .sa),
                          Answer(text: "Travel around the world", type: .om),
                          Answer(text: "Start some art works", type: .sm),
                          Answer(text: "To live as a hermit or poet", type: .oa)].shuffle()),
        Question(text: "Which animals below do you want to have as your future pets?", type: .multiple,
                 answer: [Answer(text: "A loyal dog 🐶", type: .sa),
                          Answer(text: "An elegant cat 😼", type: .sm),
                          Answer(text: "A quiet fish 🐠", type: .oa),
                          Answer(text: "A fierce snake 🐍", type: .om)].shuffle()),
        Question(text: "Chose one thing you mostly want below?", type: .single,
                 answer: [Answer(text: "A normal pencil? ✏️", type: .om),
                          Answer(text: "A dice with a little magic? 🎲", type: .sa),
                          Answer(text: "May be a creepy zombie? 🧟", type: .sm),
                          Answer(text: "Or an embarrassed smiley face? 🌝", type: .oa)]),
        
    ].shuffle()
        
    
    //创建索引
    var questionIndex = 0
    //创建结果收纳列表
    var answersChosen: [Answer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    
    //由于多次用到此功能，因此定义为函数
    func updateUI() {
        //隐藏三种答案UI控件
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
               
        //1. 数据准备部分：
        //根据索引展示问题
        let currentQuestion = question[questionIndex]
        //提取每个问题中的 答案Array（含所有答案）
        let currentAnswers = currentQuestion.answer
        //设置当前进度值
        let totalProgress = Float(questionIndex)/Float(question.count)
        //主label进行问题展示
        questionLabel.text = currentQuestion.text
        //2. 界面更新部分：
        //导航栏标题改变
        navigationItem.title = "Qusetion #\(questionIndex + 1)"
        
        //进度条展示
        questionProgressView.setProgress(totalProgress, animated: true)
        //匹配问题类型：相应进行 答案界面 展示
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }

    //单选类答案
    func updateSingleStack(using answers: [Answer]){
        //展示界面；并赋值每一个 答案label
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    //多选类答案
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwtich2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        mutiLabel2.text = answers[1].text
        mutiLabel3.text = answers[2].text
        mutiLabel4.text = answers[3].text
    }
    //拖动条类答案
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        //设置拖动条在中间
        rangedSlider.setValue(0.5, animated: false)
        
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    //实现 单选按钮 交互：
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = question[questionIndex].answer
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        //继续问题
        nextQuestion()
    }
    //多选类，选了就记录
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = question[questionIndex].answer
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwtich2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    //拖动条类，根据分段情况记录
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = question[questionIndex].answer
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    //实现继续答题逻辑
    func nextQuestion() {
        //索引后移
        questionIndex += 1
        
        if questionIndex < question.count {
            updateUI()
        }else {
            //结束逻辑
            
            //however, app crashed because UIKit is using the default required initializer for "ResultsViewController".You need to tell you storyboard what to call instead when this segue is triggered.
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    //this inserts a method similar to an @IBAction except that it's unique to segues.
    @IBSegueAction func showResult(_ coder: NSCoder) -> ResultViewController? {
        return ResultViewController(coder: coder, responses: answersChosen)
    }
    
    
    
}
