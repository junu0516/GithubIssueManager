import Foundation

struct LoginViewModel: BasicViewModel {
    
    struct Input {
        let loginButtonTapped = Observable<Bool>(false)
    }
    
    struct Output {
        let loginRequested = Observable<Bool>(false)
    }
    
    let input = Input()
    let output = Output()
    let repository: LoginRepository
    
    init(repository: LoginRepository = LoginRepository()) {
        self.repository = repository
        bind()
    }
    
    private func bind() {
        input.loginButtonTapped.bind { _ in
            output.loginRequested.value = true
        }
    }
    
}
