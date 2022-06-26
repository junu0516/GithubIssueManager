import UIKit

class TableViewCell: UITableViewCell {

    static var identifier: String { .init(describing: self) }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setAttributes()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func addViews() {}
    
    private func setAttributes() {
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
}
