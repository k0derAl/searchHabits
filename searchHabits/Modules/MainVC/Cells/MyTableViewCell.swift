

import UIKit
import SnapKit

class MyTableViewCell: UITableViewCell {
    static let identifier = "cellIdentifier"
    
    let numberLabel: UILabel = {
        let nl = UILabel()
        nl.textColor = .black
        nl.font = UIFont.boldSystemFont(ofSize: 15)
        nl.textAlignment = .left
        nl.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        nl.layer.borderWidth = 0.4
        //nl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return nl
    }()
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = .black
        tl.font = UIFont.boldSystemFont(ofSize: 15)
        tl.textAlignment = .left
        tl.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        tl.layer.borderWidth = 0.4
        //tl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tl
    }()
    
    let idLabel: UILabel = {
        let il = UILabel()
        il.textColor = .black
        il.font = UIFont.boldSystemFont(ofSize: 15)
        il.textAlignment = .left
        il.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        il.layer.borderWidth = 0.4
        //il.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return il
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(numberLabel)
        addSubview(idLabel)
        addSubview(titleLabel)
        numberLabel.snp.makeConstraints { (make) in
            
            make.height.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.2)
            make.leading.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
        
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.8)
            make.trailing.equalTo(idLabel).offset(0)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.height.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.2)
            make.trailing.equalTo(self).offset(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(item: Habit, index: Int, first: Bool) {
        numberLabel.text = first ? " #" : " " + String(index)
        titleLabel.text = " " + item.title
        idLabel.text = " " + item.id
        
    }
    
}
