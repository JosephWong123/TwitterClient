//
//  Url.swift
//  Twitter
//
//  Created by Joseph Wong on 4/29/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import Foundation

enum Url: String {
    case homeTimeline = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    case loginAuth = "https://api.twitter.com/oauth/request_token"
}
