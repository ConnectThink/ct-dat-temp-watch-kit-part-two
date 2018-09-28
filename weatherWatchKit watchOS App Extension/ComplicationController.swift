//
//  ComplicationController.swift
//  weatherWatchKit watchOS App Extension
//
//  Created by Matt Lathrop on 9/25/18.
//  Copyright © 2018 Connect Think. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        if let template = template(for: complication, text: "66") {
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        } else {
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        if let template = template(for: complication, text: "11") {
            handler(template)
        } else {
            handler(nil)
        }
    }
    
    // MARK: - Other
    
    func template(for complication: CLKComplication, text: String) -> CLKComplicationTemplate? {
        var template: CLKComplicationTemplate?
        
        switch complication.family {
        case .modularSmall:
            let concreteTemplate = CLKComplicationTemplateModularSmallSimpleText()
            concreteTemplate.textProvider = CLKSimpleTextProvider(text: text)
            template = concreteTemplate
        case .modularLarge:
            let concreteTemplate = CLKComplicationTemplateModularLargeTallBody()
            concreteTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Dat Temp")
            concreteTemplate.bodyTextProvider = CLKSimpleTextProvider(text: text)
            template = concreteTemplate
        case .utilitarianSmall, .utilitarianSmallFlat:
            let concreteTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
            concreteTemplate.imageProvider = CLKImageProvider(onePieceImage: UIImage())
            concreteTemplate.textProvider = CLKSimpleTextProvider(text: text)
            template = concreteTemplate
        case .utilitarianLarge:
            let concreteTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            concreteTemplate.imageProvider = CLKImageProvider(onePieceImage: UIImage())
            concreteTemplate.textProvider = CLKSimpleTextProvider(text: text)
            template = concreteTemplate
        case .circularSmall:
            let concreteTemplate = CLKComplicationTemplateCircularSmallSimpleText()
            concreteTemplate.textProvider = CLKSimpleTextProvider(text: text)
            template = concreteTemplate
        case .extraLarge:
            let concreteTemplate = CLKComplicationTemplateExtraLargeSimpleText()
            concreteTemplate.textProvider = CLKSimpleTextProvider(text: text)
            template = concreteTemplate
        case .graphicCorner:
            let image = imageFromText(text: text as NSString, centreX: 10, centreY: 10) ?? UIImage()
            let concreteTemplate = CLKComplicationTemplateGraphicCornerTextImage()
            concreteTemplate.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
            concreteTemplate.textProvider = CLKSimpleTextProvider(text: "")
            template = concreteTemplate
        case .graphicBezel:
            let circularTemplate = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText()
            circularTemplate.centerTextProvider = CLKSimpleTextProvider(text: text)
            circularTemplate.bottomTextProvider = CLKSimpleTextProvider(text: "")
            circularTemplate.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .black, fillFraction: 1.0);
            
            let concreteTemplate = CLKComplicationTemplateGraphicBezelCircularText()
            concreteTemplate.circularTemplate = circularTemplate
            concreteTemplate.textProvider = CLKSimpleTextProvider(text: "Dat Temp")
            template = concreteTemplate
        case .graphicCircular:
            let concreteTemplate = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText()
            concreteTemplate.centerTextProvider = CLKSimpleTextProvider(text: "Dat Temp")
            concreteTemplate.bottomTextProvider = CLKSimpleTextProvider(text: text)
            concreteTemplate.gaugeProvider = CLKGaugeProvider()
            template = concreteTemplate
        case .graphicRectangular:
            let concreteTemplate = CLKComplicationTemplateGraphicRectangularStandardBody()
            concreteTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Dat Temp")
            concreteTemplate.body1TextProvider = CLKSimpleTextProvider(text: text)
            template = concreteTemplate
        }
        
        return template
    }
    
    func imageFromText(text : NSString, centreX : CGFloat, centreY : CGFloat ) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 20, height: 20))
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.white]
        let textSize = text.size(withAttributes: attributes)
        text.draw(in: CGRect(x: centreX - textSize.width / 2.0, y: centreY - textSize.height / 2.0, width: textSize.width, height: textSize.height), withAttributes : attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
