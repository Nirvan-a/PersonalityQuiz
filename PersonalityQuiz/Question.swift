import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answer: [Answer]
    
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: String {
    case sa = "Self-awareness\nJust like a 🐼",sm = "Self-management\nJust like a 🐺", oa = "Social awareness\nJust like a 🐵", om = "Relationship management\nJust like a 🦁"
    
    var definition: String {
        switch self {
        case .sa:
            return "It is the ability to identify and understand your own emotions and how they affect you.\n\nThrough self-awareness you recognize how your feelings can help or hinder you from reaching your goals.\n\nYou become aware of your emotional tendencies, strengths, and weaknesses."
        case .sm:
            return "It means taking things one step further.\n\nIt's the ability to manage emotions in a way that allows you to accomplish a task, reach a goal, or provide a benefit.\n\nIt includes the quality of self-control, which is the ability to control your emotional reactions."
        case .oa:
            return "It is the ability to accurately perceive the feelings of others and understand how those feelings influence behavior.\n\nIn order to achieve social awareness, you must be empathetic, ready to see and feel things from the perspective of others."
        case .om:
            return "It allows you to get the most out of your relationships with others.\n\nInstead of trying to force others into action, it allows you to use insight and persuasion to motivate them to act.\n\nIt also includes the ability to strengthen the level of trust between you and others."
        }
    }
    
    
}
extension Array{
    public func shuffle() -> Array {
        var primary = self
        primary.removeAll()
        var copy = self
        while copy.count != 0 {
            let randomIndex = Int(arc4random()) % copy.count
            primary.append(copy[randomIndex])
            copy.remove(at: randomIndex)
        }
        return primary
    }
}


