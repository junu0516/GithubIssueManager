import Foundation

final class LoginViewModel: BasicViewModel {
    
    struct Input {
        let loginButtonTapped = Observable<Bool>(false)
    }
    
    struct Output {
        let loginRequested = Observable<Bool>(false)
    }
    
    let input = Input()
    let output = Output()
    let repository: LoginRepository
    var loginUrl: URL? {
        return repository.getAuthenticationRequestUrl()
    }
    
    init(repository: LoginRepository = LoginRepository()) {
        self.repository = repository
        bind()
    }
    
    private func bind() {
        input.loginButtonTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            self?.output.loginRequested.value = true
        }
    }
}
