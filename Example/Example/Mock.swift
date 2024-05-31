//
//  Mock.swift
//  Example
//
//  Created by Ugur Bozkurt on 23/10/2023.
//

import Foundation

enum Mock {
    case sample1, sample2, sample3, custom(String)

    var attributedString: NSAttributedString {
        let data = Mock.htmlTemplate(body).data(using: .utf16)!
        return data.htmlAttributedString!
    }

    var body: String {
        switch self {
        case let .custom(text):
            text
        case .sample1:
            """
                    <p><strong>Lorem Ipsum</strong> is <em>simply dummy text </em>of the <span style="text-decoration: underline;">printing</span> and <s>typesetting</s> industry. <s><span style="text-decoration: underline;"><em><strong>Lorem Ipsum</strong></em></span></s> has been the industry's standard dummy text ever since the 1500s,</p>
                    <p>Indent</p>
                    <p>Double Indent</p>
                    <p>It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</p>
                    <p>&nbsp;</p>
                    <p>It was popularised in the 1960s with the release of Letraset sheets containing.</p>
                    <p>&nbsp;</p>
                    <p>Lorem Ipsum passages, and more recently with desktop publishing software like&nbsp;</p>
                    <p>Aldus PageMaker including versions of Lorem Ipsum.<br>&nbsp;</p>
                """
        case .sample2:
           """
           <ul>
               <li>What would you like to drink?</li>
               <li>Select one of below</li>
               <ol>
                 <li>Coffee</li>
                 <li>Tea</li>
                   <ol>
                     <li>Earl Grey</li>
                   </ol>
                 <li>Milk</li>
               </ol>
               <li>Thanks!</li>
           </ul>
           """
        case .sample3:
           """
           <ul>
               <li style="text-align: right">Hello <span style="text-decoration:underline">world<span></li>
           </ul>
           """
        }
    }

    static var inputStyle = """
             p, ul, ol, div, body {
               font-family: Helvetica;
               font-size: 15px;
             }

             h1 {
               font-family: Helvetica;
               font-size: 24px;
               font-weight: normal;
             }

             h2 {
               font-family: Helvetica;
               font-size: 22px;
               font-weight: normal;
             }

             h3 {
               font-family: Helvetica;
               font-size: 20px;
               font-weight: normal;

             }

             h4 {
               font-family: Helvetica;
               font-size: 19px;
               font-weight: normal;
             }

             h5 {
               font-family: Helvetica;
               font-size: 18px;
               font-weight: normal;
             }

             h6 {
               font-family: Helvetica;
               font-size: 17px;
               font-weight: normal;
             }
     """

    static func htmlTemplate(_ body: String, cssStyle: String = Self.inputStyle) -> String {
     """
        <!DOCTYPE html>
        <html>
        <head>
        <style>
            \(cssStyle)
        </style>
        </head>

        <body>
          \(body)
        </body>

        </html>
    """
    }
}


