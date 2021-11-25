//
//  SignUpView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 20/08/2021.
//

import SwiftUI




struct SignUpView: View {
    
    // MARK:- PROPERTIES
    @State private var email = String()
    @State private var fullName = String()
    @State private var password = String()
    @State private var password_again = String()
    @State private var secured: Bool = true
    @State private var isCalledApi: Bool = true
    @State private var isEmailValid : Bool   = true
    @State private var movetoSingUpLink: Bool = false
    @State private var isShowingLoader = false
    @State private var fitnessLvelPicker = false
    @State private var fitneslvl = String()
    @State private var moveToDash = false
    @State var model: BannerData?
    @ObservedObject var myGoogle = GoogleStuff()
    @ObservedObject var SignUp = SignUpViewModel()
    static var uniqueKey: String {
            UUID().uuidString
        }
    static let options: [DropdownOption] = [
            DropdownOption(key: uniqueKey, value: "Cardiovascular Endurance"),
            DropdownOption(key: uniqueKey, value: "Muscular Strength"),
            DropdownOption(key: uniqueKey, value: "Muscular endurance"),
            DropdownOption(key: uniqueKey, value: "Flexibility"),
            DropdownOption(key: uniqueKey, value: "Body Composition"),
            
        ]
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private var movetoSignUp: some View {
        NavigationLink(
            destination: DashboardView(),
            isActive: $moveToDash,
            label: {
                Text("")
            })
    }
    
    var body: some View {
        loadView()
            .modifier(BannerModifier(model: $SignUp.model))
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

//    MARK:- View Extension
extension SignUpView {
    
    func loadView() -> some View {
        LoadingView(isShowing: $SignUp.loading) {
                VStack(alignment: .center) {
                    ScrollView(showsIndicators: false){
                    
                    VStack (spacing: 30) {
                        LogoData()
                        SingInTextField() //:VStack TextField
                    }
//
                        movetoSignUp
                     //ZStack: Gmail Button
                    SignIn() //VStack: Forgot Password
                }
                    
                }.onChange(of: myGoogle.doneGettingData, perform: { value in
                    if value{
                        let name = myGoogle.googleFirstName
                        let email = myGoogle.googleEmail
                        let token = myGoogle.googleIdToken
                        myGoogle.doneGettingData = false
                        SignUp.APISocialLogin(social_key: "google", email: email, name: name, social_token: token)
                    }
                }).padding()
                .navigationBarHidden(true)
                
            
        }
    }
    
    fileprivate func LogoData () -> some View {
        
        VStack(spacing: 20) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72, alignment: .center)
            VStack(spacing: 5) {
                Text("Let’s Get Started")
                    .font(.custom("Poppins-Bold", size: 16))
                
                Text("Create an new account")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color.gray)
            }
            
        }
    }
    
    fileprivate func SingInTextField() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                    
                    HStack {
                        Image("User")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                            .padding([.leading], 20)
                        
                        TextField("Full Name", text: $fullName)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                } // :ZStack Email
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                    
                    HStack {
                        Image("Message")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                            .padding([.leading], 20)
                        
                        TextField("Your Email", text: $email)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom])
                            .font(.custom("Poppins-Regular", size: 14)).onChange(of: email, perform: { value in
                                //                        check is email formate is valid.
                                if self.textFieldValidatorEmail(value) {
                                    self.isEmailValid = true
                                } else {
                                    self.isEmailValid = false
                                }
                            })
                    }
                    
                } // :ZStack Password
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                    
                    HStack {
                        Image("Password")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                            .padding([.leading], 20)
                        
                        SecureField("Password", text: $password)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                } // :ZStack Email
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                    
                    HStack {
                        Image("Password")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                            .padding([.leading], 20)
                        
                        TextField("Password Again", text: $password_again)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                }
               
                ZStack(alignment: .top){
                    VStack{
              
                            DropdownSelector(
                                placeholder: "Fitness Level",
                                options: SignUpView.options,
                                onOptionSelected: { option in
                                    print(option)
                                    fitneslvl = option.value
                                }).zIndex(1)
//                            .padding(.horizontal)
   
                   SignInButton()
                        OR_Divider()
                        GmailButton()
                    }
                }
                
                
                
            }
    }
    
    fileprivate func SignInButton() -> some View {
         Button(action: {
            
            if is_field_are_empty{
                SignUp.ApiCalling(name: fullName, email: email, password: password, FitnesLvl: fitneslvl)
            }
           
            
        }, label: {
            Text("Sign Up")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 16))
                
                .foregroundColor(Color.white)
              
            
            
        })
         .background(Color("fg"))
         .cornerRadius(10)
         .frame( height: 50)
         .padding([.top], 25)
    }
    
    fileprivate func OR_Divider () -> some View {
        HStack {
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color("light"))
            
            Text("OR")
                .font(.custom("Poppins-Bold", size: 16))
                .foregroundColor(Color("light"))
                .padding([.leading, .trailing])
            
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color("light"))
        } //: HStack OR with Line
        .padding([.top], 23)
    }
    
    fileprivate func GmailButton() -> some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color("light"), lineWidth: 0.2)
                )
            
            HStack {
                
                Button(action: {
                    print("google button")
                }, label: {
                    HStack{
                        Image("Google")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Spacer()
                        Text("Login with Google")
                            .font(.custom("Poppins-Bold", size: 15))
                            .foregroundColor(Color("light"))
                            .padding([.leading], -30)
                        
                        Spacer()
                        
                    }
                }).padding()
                
                
            } //HStack: Gmail Login
            
            
        }
    }
    
    fileprivate func SignIn() -> some View {
        VStack(spacing: 8) {
            
            HStack {
                Text("have a account?")
                    .font(.custom("Poppins-Regular", size: 13))
                    .foregroundColor(Color("light"))
                    .padding([.trailing], -15)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Sign In")
                        .font(.custom("Poppins-Bold", size: 13))
                        .foregroundColor(Color("fg"))
                }).padding() //: Register Button
                
            }
        }.padding()
    }
    
}

// MARK: CUTSOM FUNCTION EXTENSION
extension SignUpView {
    
    var is_field_are_empty:  Bool {
        
        if  email.isEmpty || password.isEmpty  {
            SignUp.model = BannerData(title: "Error", message: "Please fill all the fields", color: .red, image: "error")
            return false
        } else {
            //      If all fields are filled then check the check the email and password fields
            if self.isEmailValid {
                //                if email is valid then check that both passwords filed are same
                if is_password_length_satisfied() {
                    return true
                    
                    
                    
                    //movetoSingUpLink.toggle()
                    //                    callLoginApi()
                }
                
            } else {
                //                if email formate is not valid.
                SignUp.model = BannerData(title: "Error", message: "Email formate incorrect", color: .red, image: "error")
                return false
            }
            
        }
        return false
    }
        
        func is_password_length_satisfied() -> Bool {
            //        This function check either both text fileds are empty of filled
            //                now check the lenght is greater then 6 or not
            if password.count > 5 {
                if password == password_again{
                    return true
                }else{
                    SignUp.model = BannerData(title: "Error", message: "Password not matched", color: .red, image: "error")
                    return false
                }
               
                
            } else {
                SignUp.model = BannerData(title: "Error", message: "Please enter atleast 6 character of password", color: .red, image: "error")
                return false
            }
        
    }
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
        //        Email validator
        
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}

