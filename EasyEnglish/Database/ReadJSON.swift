//
//  ReadJSON.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import Foundation
import RealmSwift

struct SentenceData: Decodable {
    let korean: String
    let english: String
}

struct ChapterData: Decodable {
    let chapterName: String
    let sentences: [SentenceData]
}

struct CategoryData: Decodable {
    let categoryName: String
    let chapters: [ChapterData]
}

func loadJSONData() -> [CategoryData]? {
    guard let url = Bundle.main.url(forResource: "sentences", withExtension: "json") else {
        print("JSON file not found")
        return nil
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let categories = try decoder.decode([CategoryData].self, from: data)
        return categories
    } catch {
        print("Error parsing JSON: \(error)")
        return nil
    }
}

func saveToRealm(categories: [CategoryData]) {
    let realm = try! Realm()
    print(realm.configuration.fileURL)

    for category in categories {
        let categoryObject = CategoryTable()
        categoryObject.categoryName = category.categoryName

        for chapter in category.chapters {
            let chapterObject = ChapterTable()
            chapterObject.chapterName = chapter.chapterName

            for sentence in chapter.sentences {
                let sentenceObject = SentenceTable()
                sentenceObject.korean = sentence.korean
                sentenceObject.english = sentence.english

                chapterObject.sentences.append(sentenceObject)
            }
            categoryObject.chapters.append(chapterObject)
        }

        try! realm.write {
            realm.add(categoryObject)
        }
    }
}

func checkFirstLaunch() {
    let userDefaults = UserDefaults.standard

    if userDefaults.bool(forKey: "isFirst") == false {
        if let categories = loadJSONData() {
            saveToRealm(categories: categories)
            userDefaults.set(true, forKey: "isFirst")
        }
    } else {
        print("Data has already been imported")
    }
}

//"transportation": [
//    "chapter1": [
//        {
//            "korean": "버스 정류장이 어디에 있나요?",
//            "english": "Where is the bus stopf?"
//        },
//        {
//            "korean": "택시를 불러 주시겠어요?",
//            "english": "Can you call a taxi for me?"
//        },
//        {
//            "korean": "지하철역까지 얼마나 걸리나요?",
//            "english": "How long does it take to get to the subway station?"
//        },
//        {
//            "korean": "기차표는 어디서 살 수 있나요?",
//            "english": "Where can i buy train tickets?"
//        },
//        {
//            "korean": "이 버스는 시내로 가나요?",
//            "english": "Does this bus go downtown?"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        }
//    ]
//],
//    
//"dailyLife": [
//    "chapter1": [
//        {
//            "korean": "오늘 날씨가 정말 좋네요.",
//            "english": "The weather is really nice today."
//        },
//        {
//            "korean": "어떻게 지내세요?",
//            "english": "How have you been?"
//        },
//        {
//            "korean": "그건 어디서 샀어요?",
//            "english": "Where did you buy that?"
//        },
//        {
//            "korean": "오늘 저녁에 뭐 할 거예요?",
//            "english": "What are you doing tonight?"
//        },
//        {
//            "korean": "지금 몇 시예요?",
//            "english": "What time is it?"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        }
//        
//    ]
//    
//],
//
//"travel": [
//    "chapter1": [
//        {
//            "korean": "근처에 추천할 만한 관광지가 있나요?",
//            "english": "Are there any tourist attractions nearby?"
//        },
//        {
//            "korean": "이곳까지 택시로 얼마나 걸리나요?",
//            "english": "How long does it take to get here by taxi?"
//        },
//        {
//            "korean": "짐을 어디에 맡길 수 있나요?",
//            "english": "Where can i leave my luggage?"
//        },
//        {
//            "korean": "이 호텔에 와이파이가 있나요?",
//            "english": "Does this hotel have Wi-Fi?"
//        },
//        {
//            "korean": "여기서 사진 찍어도 되나요?",
//            "english": "Can i take pictures here?"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        }
//        
//    ]
//    
//],
//
//"business": [
//    "chapter1": [
//        {
//            "korean": "회의는 몇 시에 시작하나요?",
//            "english": "What time does the meeting start?"
//        },
//        {
//            "korean": "이메일로 자료를 보내드릴게요.",
//            "english": "I will send the documents via email"
//        },
//        {
//            "korean": "내일 미팅 준비는 다 됐나요?",
//            "english": "Are you ready for tomorrow's meeting?"
//        },
//        {
//            "korean": "이 계약 조건에 대해 논의해보죠.",
//            "english": "Let's discuss the terms of this contract."
//        },
//        {
//            "korean": "회의록을 작성해 주세요.",
//            "english": "Please write the meeting minutes."
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        }
//        
//    ]
//    
//],
//
//"sports": [
//    "chapter1": [
//        {
//            "korean": "이 영화 봤어?",
//            "english": "Have you seen this movie?"
//        },
//        {
//            "korean": "이 장면 정말 감동적이야.",
//            "english": "This scene is really touching."
//        },
//        {
//            "korean": "주인공이 마지막에 어떻게 됐어?",
//            "english": "What happened to the main character at the end"
//        },
//        {
//            "korean": "다음 시즌 언제 나와?",
//            "english": "When is the next season coming out"
//        },
//        {
//            "korean": "이 드라마 진짜 중독성 있어",
//            "english": "This drama is really addictive"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        }
//        
//    ]
//    
//],
//
//"music": [
//    "chapter1": [
//        {
//            "korean": "이 영화 봤어?",
//            "english": "Have you seen this movie?"
//        },
//        {
//            "korean": "이 장면 정말 감동적이야.",
//            "english": "This scene is really touching."
//        },
//        {
//            "korean": "주인공이 마지막에 어떻게 됐어?",
//            "english": "What happened to the main character at the end"
//        },
//        {
//            "korean": "다음 시즌 언제 나와?",
//            "english": "When is the next season coming out"
//        },
//        {
//            "korean": "이 드라마 진짜 중독성 있어",
//            "english": "This drama is really addictive"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        }
//        
//    ]
//    
//],
//
//"shopping": [
//    "chapter1": [
//        {
//            "korean": "이 영화 봤어?",
//            "english": "Have you seen this movie?"
//        },
//        {
//            "korean": "이 장면 정말 감동적이야.",
//            "english": "This scene is really touching."
//        },
//        {
//            "korean": "주인공이 마지막에 어떻게 됐어?",
//            "english": "What happened to the main character at the end"
//        },
//        {
//            "korean": "다음 시즌 언제 나와?",
//            "english": "When is the next season coming out"
//        },
//        {
//            "korean": "이 드라마 진짜 중독성 있어",
//            "english": "This drama is really addictive"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        }
//        
//    ]
//    
//],
//
//"historyCulture": [
//    "chapter1": [
//        {
//            "korean": "이 영화 봤어?",
//            "english": "Have you seen this movie?"
//        },
//        {
//            "korean": "이 장면 정말 감동적이야.",
//            "english": "This scene is really touching."
//        },
//        {
//            "korean": "주인공이 마지막에 어떻게 됐어?",
//            "english": "What happened to the main character at the end"
//        },
//        {
//            "korean": "다음 시즌 언제 나와?",
//            "english": "When is the next season coming out"
//        },
//        {
//            "korean": "이 드라마 진짜 중독성 있어",
//            "english": "This drama is really addictive"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        },
//        {
//            "korean": "안녕하세요",
//            "english": "Hello"
//        }
//        
//    ]
//    
//]
//
//}
//
