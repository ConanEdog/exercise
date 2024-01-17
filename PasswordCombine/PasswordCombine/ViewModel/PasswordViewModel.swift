//
//  PasswordViewModel.swift
//  PasswordCombine
//
//  Created by 方奎元 on 2024/1/17.
//

import Foundation
import Combine

class PasswordViewModel {
    
    struct Input {
        let newPasswordPublisher: AnyPublisher<String, Never>
        let confirmPasswordPublisher: AnyPublisher<String, Never>
    }
    
    struct Output {
        let updatePublisher: AnyPublisher<Result, Never>
        let resultPublisher: AnyPublisher<Result, Never>
    }
    
    var newPasswordValidate: Bool = false
    var confirmPasswordValidate: Bool = false
    
    func transform(input: Input) -> Output {
        
        let updatePublisher = input.newPasswordPublisher.flatMap { [unowned self] newPassword in
            
            print("newPassword: \(newPassword)")
            // Empty text
            guard  !newPassword.isEmpty else {
                return Just(Result(validate: false, message: "Enter your password", text: newPassword)).eraseToAnyPublisher()
            }
            
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard newPassword.rangeOfCharacter(from: invalidSet) == nil else {
                return Just(Result(validate: false, message: "Enter valid special chars (.,@:?!()$\\/#) with no spaces", text: newPassword)).eraseToAnyPublisher()
            }
            
            // Criteria met
            if !self.validate(newPassword) {
                return Just(Result(validate: false, message: "Your password must meet the requirements below", text: newPassword)).eraseToAnyPublisher()
            }
            
            return Just(Result(validate: true, message: "", text: newPassword)).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
        
        let resultPublisher = Publishers.CombineLatest(input.newPasswordPublisher, input.confirmPasswordPublisher).flatMap {   (newPassword, confirmPassword) in
            
            guard !confirmPassword.isEmpty else {
                return Just(Result(validate: false, message: "Enter your password", text: confirmPassword)).eraseToAnyPublisher()
            }
            
            guard confirmPassword == newPassword else {
                return Just(Result(validate: false, message: "Password do not match.", text: confirmPassword)).eraseToAnyPublisher()
            }
            
            return Just(Result(validate: true, message: "", text: "")).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
        
        return Output(updatePublisher: updatePublisher, resultPublisher: resultPublisher)
    }
    
    func validate(_ text: String) -> Bool {
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        // Check for 3 of 4 criteria
        let checkable = [uppercaseMet, lowercaseMet, digitMet, specialCharacterMet]
        let metCriteria = checkable.filter { $0 } // because itself is already boolean, same as { $0 == true }
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        
        if lengthAndNoSpaceMet && metCriteria.count >= 3 {
            return true
        }
        return false
    }
}
