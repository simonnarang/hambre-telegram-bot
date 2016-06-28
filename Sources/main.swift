/*
©Copyright NaWang Labs All Right Reservered by Simon Narang and Will Wang
*/


//Import important Dependencies

import Foundation

import TelegramBot

import SwiftyJSON

//telgram API setup
var bot = TelegramBot(token: "205431240:AAH12fgfbpCa0aqPy-wYwn9F11H-HMX2HX0")

var router = Router(bot: bot)


//JSON parsing setup

var JAYSON = [(String, String)]()

//Router functions
router["⬅"] = { context in
    
    //Send Keyboard
    var markup = ReplyKeyboardMarkup()
    
    context.respondAsync("Here are possible functions", ["reply_markup": markup])
    
    var button1 = KeyboardButton()
    
    button1.text = "Start"
    
    var button2 = KeyboardButton()
    
    button2.text = "Greet"
    
    var button3 = KeyboardButton()
    
    button3.text = "Settings"
    
    var button4 = KeyboardButton()
    
    button4.text = "About"
    
    var button5 = KeyboardButton()
    
    button5.text = "Games"
    
    var button6 = KeyboardButton()
    
    button6.text = "Find"
    
    //Keyboard Layout
    markup.keyboard = [ [ button1, button2, button3 ],
                               [ button4, button5, button6 ],
    ]
    
    context.respondAsync("Try them!", ["reply_markup": markup])
    
    return true
}

router["Help"] = { context in
    
    //Send Keyboard
    var markup = ReplyKeyboardMarkup()
    
    context.respondAsync("Here are possible functions", ["reply_markup": markup])
    
    var button1 = KeyboardButton()
    
    button1.text = "Start"
    
    var button2 = KeyboardButton()
    
    button2.text = "Greet"
    
    var button3 = KeyboardButton()
    
    button3.text = "Settings"
    
    var button4 = KeyboardButton()
    
    button4.text = "About"
    
    var button5 = KeyboardButton()
    
    button5.text = "Games"
    
    var button6 = KeyboardButton()
    
    button6.text = "Find"
    
    markup.keyboard = [ [ button1, button2, button3 ],
                               [ button4, button5, button6 ],
                               
    ]
    
    context.respondAsync("Try them!", ["reply_markup": markup])
    return true
}

router["Greet"] = { context in
    guard var from = context.message?.from else { return false }
    context.respondAsync("Hello, \(from.first_name)!")
    return true
    
}

router["Start"] = { context in
    
    guard var from = context.message?.from else { return false }
    context.respondAsync("Hello there, \(from.first_name)! Nice to meet you!")
    
    return true
}

router["Games"] = { context in
    
    var markup = ReplyKeyboardMarkup()
    
    context.respondAsync("Bored?", ["reply_markup": markup])
    
    var button1 = KeyboardButton()
    
    button1.text = "20 Questions: \n I guess"
    
    var button2 = KeyboardButton()
    
    button2.text = "20 Questions: \n you guess"
    
    var button3 = KeyboardButton()
    
    button3.text = "⬅"
    
    markup.keyboard = [[button1, button2],
                              [button3]
    ]

    context.respondAsync("var's play some games!", ["reply_markup": markup])
    
    return true
}

router["About"] = { context in
    context.respondAsync("I am designed by NaWang Labs to help you find scrumptious meals around you!")
    return true
}

router["Settings"] = { context in
    
    var markup = ReplyKeyboardMarkup()
    
    context.respondAsync("Settings", ["reply_markup": markup])
    
    var button1 = KeyboardButton()
    
    button1.text = "Send Contact"
    
    button1.request_contact = true
    
    var button2 = KeyboardButton()
    
    button2.text = "Send Location"
    
    button2.request_location = true
    
    var button3 = KeyboardButton()
    
    button3.text = "⬅"
    
    markup.keyboard = [ [ button1, button2 ],
                               [ button3]
    ]
    
    context.respondAsync("Here are the options", ["reply_markup": markup])
    
    return true
}

router["Breakfast"] = { context in
    
    context.respondAsync("Looking for restaurants...")
    
    return true
}

router["Brunch"] = { context in
    context.respondAsync("Looking for restaurants...")
    
    return true
}

router["Lunch"] = { context in
    context.respondAsync("Looking for restaurants...")
    return true
}

router["Linner"] = { context in
    context.respondAsync("Looking for restaurants...")
    return true
}

router["Dinner"] = { context in
    context.respondAsync("Looking for restaurants...")
    return true
}

router["Night"] = { context in
    context.respondAsync("Looking for restaurants...")
    return true
}

router["Find"] = { context in
    
    //setup buttons to select meal
    var markup = ReplyKeyboardMarkup()
    
    context.respondAsync("Looking for restaurants...", ["reply_markup": markup])
    
    var button1 = KeyboardButton()
    
    button1.text = "Breakfast"
    
    var button2 = KeyboardButton()
    
    button2.text = "Brunch"
    
    var button3 = KeyboardButton()
    
    button3.text = "Lunch"
    
    var button4 = KeyboardButton()
    
    button4.text = "Linner"
    
    var button5 = KeyboardButton()
    
    button5.text = "Dinner"
    
    var button6 = KeyboardButton()
    
    button6.text = "Night"
    
    var button10 = KeyboardButton()
    
    button10.text = "⬅"
    
    markup.keyboard = [ [ button1, button2, button3 ],
                               [ button4, button5, button6 ],
                               [ button10]
    ]
    
    context.respondAsync("Here are the options", ["reply_markup": markup])
    
    var baseUrl = "https://hambre-herro.rhcloud.com/"
    var urlComponents = URLComponents(string: baseUrl)
    var finalUrl = urlComponents?.url
    var request = URLRequest(url: finalUrl!)
    request.httpMethod = "GET"
    let task = URLSession.shared().dataTask(with: request)
    { data, response, error in
        if error != nil
        {
            context.respondAsync("My tongue tells me that trouble is on the way")
            print("error in the math")
            print(error)
        }
        else
        {
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            context.respondAsync("Here are your tastebud tinglers: \n\(responseString)")
            print("no error")
        }
    }

    task.resume()

    return true

}

//Print to show that console is working
print("Ready to accept commands")

while var update = bot.nextUpdateSync() {
    
    print("--- update: \(update.debugDescription)")
    
    try router.process(update: update)
    
}

//Say if bot is failing
fatalError("Server stopped due to error: \(bot.lastError)")


