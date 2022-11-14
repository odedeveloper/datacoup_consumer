const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_fYEt9i1WK",
                        "AppClientId": "3t1p8tcn6a3kvhl29jq51uh1gs",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "domain-dc.auth.us-east-1.amazoncognito.com",
                            "AppClientId": "3t1p8tcn6a3kvhl29jq51uh1gs",
                            "SignInRedirectURI": "https://www.odeinfinity.com/",
                            "SignOutRedirectURI": "https://www.odeinfinity.com/",
                            "Scopes": [
                                "email",
                                "openid",
                                "phone",
                                "profile"
                            ]
                        },
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [],
                        "signupAttributes": [],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": [
                                "REQUIRES_LOWERCASE",
                                "REQUIRES_UPPERCASE",
                                "REQUIRES_NUMBERS",
                                "REQUIRES_SYMBOLS"
                            ]
                        },
                        "mfaConfiguration": "OPTIONAL",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL",
                            "PHONE_NUMBER"
                        ]
                    }
                }
            }
        }
    }
}''';