import Foundation

final class LoginViewModel: BasicViewModel {
    
    struct Input {
        let loginButtonTapped = Observable<Bool>()
    }
    
    struct Output {
        let loginUrl = Observable<URL>()
    }
    
    let input = Input()
    let output = Output()
    let repository: LoginRepository
    
    init(repository: LoginRepository = LoginRepository()) {
        self.repository = repository
        bind()
    }
    
    private func bind() {
        input.loginButtonTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            self?.output.loginUrl.value = self?.repository.getAuthenticationRequestUrl()
        }
    }
}
