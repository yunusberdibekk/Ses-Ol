//
//  AuthValidator.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import RegexBuilder

extension String {
    var isValidPhone: Bool {
        guard count > 8 else {
            return false
        }

        let phoneRegex = Regex {
            One("+")
            One("0"..."9")
            One("0"..."9")
            OneOrMore {
                CharacterClass("0"..."9")
            }
        }

        return wholeMatch(of: phoneRegex) != nil
    }

    var isValidEmail: Bool {
        let emailRegex = Regex {
            OneOrMore {
                CharacterClass(
                    .anyOf("._%+-"),
                    "A"..."Z",
                    "0"..."9",
                    "a"..."z"
                )
            }
            "@"
            OneOrMore {
                CharacterClass(
                    .anyOf("-"),
                    "A"..."Z",
                    "a"..."z",
                    "0"..."9"
                )
            }
            "."
            Repeat(2...64) {
                CharacterClass(
                    "A"..."Z",
                    "a"..."z"
                )
            }
        }
        return self.wholeMatch(of: emailRegex) != nil
    }
}
