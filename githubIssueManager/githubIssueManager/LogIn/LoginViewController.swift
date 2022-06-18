import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    private let githubLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Github 계정으로 로그인", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(UIColor.white, for: .normal)
        button.setImage(UIImage(named: "icon_github"), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }
    
    private func addViews() {
        view.addSubview(githubLoginButton)
        githubLoginButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
    }
}

