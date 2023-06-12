//
//  ErrorManager.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 22.05.2023.
//

import Foundation
import Alamofire
import SwiftUI

enum CitizienErrors: String {
    case emptyName = "Dikkat kullanıcı adı alanı boş geçilemez." //Eğer kullanıcı giriş yaparken name yerini boş bırakırsa.
    case emptySurname = "Dikkat kullanıcı soyadı alanı boş geçilemez." //Eğer kullanıcı giriş yaparken surname yerini boş bırakırsa.
    case emptyPassword = "Dikkat kullanıcı şifre alanı boş geçilemez." //Eğer kullanıcı giriş yaparken password yerini boş bırakırsa.
    case emptyPhone = "Dikkat kullanıcı telefon alanı boş geçilemez" //Eğer kullanıcı giriş yaparken phone yerini bırakırsa.
    case emptyCountry = "Dikkat kullanıcı ülke alanı boş geçilemez." //Eğer kullanıcı giriş yaparken country yerini boş bırakırsa.
    case emptyCity = "Dikkat kullanıcı şehir alanı boş geçilemez." //Eğer kullanıcı giriş yaparken city yerini boş bırakırsa.
    case emptyDistrict = "Dikkat kullanıcı ilçe alanı boş geçilemez." //Eğer kullanıcı giriş yaparken district yerini boş bırakırsa.
    case emptyFullAdress = "Dikkat kullanıcı açık adres alanı boş geçilemez." //Eğer kullanıcı giriş yaparken fulladrees yerini boş bırakırsa.

    case urlError = "Lütfen yeniden deneyin." //Url işleminde hata olursa.
    case error = "Hata meydana gelmemiştir."//Json işleminde hata olursa.
}

enum UnionErrors: String {
    case emptyName = "Dikkat kurum adı alanı boş geçilemez." //Eğer kullanıcı giriş yaparken name yerini boş bırakırsa.
    case emptyPassword = "Dikkat kurum şifre alanı boş geçilemez." //Eğer kullanıcı giriş yaparken password yerini boş bırakırsa.
    case emptyPhone = "Dikkat kurum telefon alanı boş geçilemez" //Eğer kullanıcı giriş yaparken phone yerini bırakırsa.
    case emptyWebSite = "Dikkat kurum web site alanı boş geçilemez." //Eğer kullanıcı giriş yaparken country yerini boş bırakırsa.
    case emptyEmail = "Dikkat kurum email alanı boş geçilemez." //Eğer kullanıcı giriş yaparken city yerini boş bırakırsa.
    
    
    case urlError = "Lütfen yeniden deneyin." //Url işleminde hata olursa.
    case error = "Hata meydana gelmemiştir."//Json işleminde hata olursa.
    }

class ErrorManager: ObservableObject {
    @Published var showAlert: Bool = false
    
    @Published var unionErrorMessage: String = ""
    @Published var citizienErrorMessage: String = ""

}

