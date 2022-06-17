import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    private let githubLoginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .black
        config.image = UIImage(named: "icon_github")
        config.imagePadding = 8
        config.imagePlacement = .leading
        config.title = "GitHub 계정으로 로그인"
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config)
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
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
    }
}

