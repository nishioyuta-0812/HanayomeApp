//
//  NewsListViewController.swift
//  HanayomeApp
//
//  Created by 西尾悠太 on 2022/01/02.
//

import Foundation
import UIKit

class NewsListViewController: UITableViewController, XMLParserDelegate {
    
    var parser: XMLParser!
    var newsItems = [NewsItem]()
    var newsItem: NewsItem?
    var currentString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        startDownload()
        
    }
    
    
    @IBAction func reloadNews(_ sender: Any) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = newsItems[indexPath.row].title
        cell.contentConfiguration = content
        return cell
    }
    
    func startDownload() {
        self.newsItems = []
        if let url = URL(string: "https://wired.jp/rssfeeder") {
            if let parser = XMLParser(contentsOf: url) {
                self.parser = parser
                self.parser.delegate = self
                self.parser.parse()
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.currentString = ""
        if elementName == "item" {
            self.newsItem = NewsItem()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "title": self.newsItem?.title = currentString
        case "link": self.newsItem?.link = currentString
        case "item": self.newsItems.append(self.newsItem!)
        default: break
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = newsItems[indexPath.row]
            let controller = segue.destination as! NewsDetailViewController
            controller.title = item.title
            controller.link = item.link
        }
    }
    
    
    
}
