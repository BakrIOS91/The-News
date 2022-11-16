//
//  DateFormaterExtension.swift
//  TheNews
//
//  Created by Bakr mohamed on 16/11/2022.
//

import SwiftUI

extension DateFormatter {
    enum Formats: String {
        case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
        case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        case yyyyMMddTHHmmssSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
        case yyyyMMddhhmma = "yyyy-MM-dd hh:mm a"
        case yyyyMMddhhmmss = "yyyy-MM-dd HH:mm:ss"
        case yyyyMMdd = "yyyy-MM-dd"
        case ddMMyyyy = "dd-MM-yyyy"
        case dMMM = "d MMM"
        case MMMM = "MMMM"
        case MMM = "MMM"
        case HHmmss = "HH:mm:ss"
        case HHmm = "HH:mm"
        case hhmma = "hh:mm a"
        case ddMMMyyyy = "dd MMM. yyyy"
        case ddMMMyyyy1 = "dd MMM yyyy"
        case ddmmyyyy = "dd/MM/yyyy"
        case MMDDYY = "MM-dd-yyyy"
        case EEEEdMMMyyyy = "EEEE d MMM yyyy"
        case ddmmyyyyHHmmss = "dd/MM/yyyy HH:mm:ss"
        case dMMMyyyy = "d MMM yyyy"
        case dMMMyyy2 = "d MMM, yyyy"
        case MMMdyyy = "MMM d, yyyy"
        case MMddyyyy = "MM/dd/yyyy"
        case dMMMMyyy = "d MMMM yyyy"
        case yyyyd = "yyyy-d"
        case hmma = "h:mm a"
        case ddMMMyyyHHSS = "d MMM yyyy 'at' hh:mm a"
    }

    func string(fromDate date: Date, withFormate format: Formats, local: Locale? = kAppLocale) -> String {
        self.dateFormat = format.rawValue
        self.locale = local
        let dateString = string(from: date)
        return dateString
    }

    func date(fromString string: String, withFormat format: Formats, timeZone: TimeZone = kAppCalendar.timeZone) -> Date? {
        self.dateFormat = format.rawValue
        self.locale = kAppLocale
        self.timeZone = timeZone
        return date(from: string)
    }
}

extension Date {
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

}
