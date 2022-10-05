//
//  Confirmation.swift
//  SprenInternal
//
//  Created by Fernando on 8/22/22.
//

import SwiftUI

struct ConfirmationScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State var inputImage = UIImage()
    @State var finalOutputImage = UIImage()
    @State private var showingOptions = false
    @State private var isImagePickerDisplay = false
    @State private var navigateTo: String?
    @State var showModal = false
    @State private var weight = UserData.default.weight
    @State private var age = UserData.default.age
    @State private var biologicalSex = UserData.default.biologicalSex
    @State private var fitnessLevel = UserData.default.fitnessLevel
    @State private var isPickerVisible = false
    @StateObject var viewModel = HeightScreen.ViewModel()
    
    @State var image: UIImage?
    
    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .white : .black).edgesIgnoringSafeArea(.all)
            
            ZStack {
                Color("AppBackground", bundle: .module).edgesIgnoringSafeArea(.top)
                
                ScrollView {
                    VStack {
                        VStack {
                            HStack {
                                Text("Everything look good?")
                                    .font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 24))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                
                                CloseButton(sizeWidth: Autoscale.convert(12), sizeHeight: Autoscale.convert(12), action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                }, image: "CloseSmall", inline: true, padding: false)
                            }
                            
                            VStack(spacing: Autoscale.convert(4)) {
                                ConfirmationScreenHint(text: "Feet together")
                                ConfirmationScreenHint(text: "Arms out 30-45 degrees from body")
                                ConfirmationScreenHint(text: "Whole body centered in photo")
                            }

                            firstMenu
                            
                            UserImageMasked.default.getFinalImage(
                                inputImage: inputImage,
                                finalOutputImage: finalOutputImage,
                                size: CGSize.init(width: Autoscale.convert(180), height: Autoscale.convert(273)),
                                shouldApplyShadow: true
                            )
                                .frame(height: Autoscale.convert(273))
                            
                            secondMenu

                            ConfirmationScreenParameters(age: age, weight: weight, weightMetric: UserData.default.weightMetric, biologicalSex: biologicalSex, fitnessLevel: fitnessLevel, height: viewModel.selection)

                            Spacer()
                        }.padding(.horizontal, Autoscale.convert(16))
                        button
                    }
                }.onAppear(perform: {
                    inputImage = image!
                    if #available(iOS 15.0, *) {
                        finalOutputImage = UserImageMasked.default.runVisionRequest(inputImage)
                    }
                })
            }
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(onChoose: { img in
                image = img
                
                inputImage = image!
                if #available(iOS 15.0, *) {
                    finalOutputImage = UserImageMasked.default.runVisionRequest(inputImage)
                }
            })
        }
        .sheet(isPresented: $showModal, onDismiss: {
            // Weight
            UserData.default.saveWeight(self.$weight.wrappedValue, UserData.default.weightMetric)
            // Height
            UserData.default.saveHeight(viewModel.selection)
            // Age
            UserData.default.saveAge(self.$age.wrappedValue)
            // Gender
            UserData.default.saveBiologicalSex(self.$biologicalSex.wrappedValue)
            // Fitness Level
            UserData.default.saveFitnessLevel(self.$fitnessLevel.wrappedValue)
        }) {
            editParametersModal
        }
        .navigationBarHidden(true)
        
        NavigationLink(destination: CameraScreen(), tag: "CameraScreen", selection: $navigateTo) { EmptyView() }
    }
    
    var firstMenu: some View {
        HStack {
            Text("Picture").font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 20))
            
            Spacer()
            
            retake
        }.padding(.top, Autoscale.convert(20))
    }
    
    var secondMenu: some View {
        HStack {
            Text("Parameters").font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 20))
            
            Spacer()
            
            Button {
                showModal.toggle()
            } label: {
                Text("Edit").font(Font.custom("Sofia Pro Black", size: Autoscale.scaleFactor * 16))
                    .foregroundColor(Color("AppPink", bundle: .module))
            }
        }.padding(.top, Autoscale.convert(20))
    }
    
    var button: some View {
        ZStack {
            Color(colorScheme == .light ? .white : .black)

            VStack {
                Spacer()
                
                NavigationLink(destination: AnalyzingScreen(image: image)) {
                    PurpleButton(text: "See my results")
                }
            }
            .frame(height: Autoscale.convert(80))
            .padding(.bottom, Autoscale.convert(10)).padding(.horizontal, Autoscale.convert(16))
                
        }
    }
    
    var retake: some View {
        Button {
            showingOptions = true
        } label: {
            Text("Retake").font(Font.custom("Sofia Pro Black", size: Autoscale.scaleFactor * 16))
                .foregroundColor(Color("AppPink", bundle: .module))
        }
        .actionSheet(isPresented: $showingOptions) {
            ActionSheet(
                title: Text("Take a photo or upload one you already have").font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 30)),
                buttons: [
                    .default(Text("Take photo")) {
                        navigateTo = "CameraScreen"
                    },

                    .default(Text("Upload from my device")) {
                        self.isImagePickerDisplay.toggle()
                    },

                    .cancel(Text("Cancel"))
                ]
            )
        }
    }
    
    var editParametersModal: some View {
        VStack {
            ZStack {
                HStack {
                    Text("Edit parameters").font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 16))
                }
                
                HStack {
                    Spacer()
                    Button {
                        showModal.toggle()
                    } label: {
                        Text("Close").font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 16))
                            .foregroundColor(Color("AppPink"))
                    }.padding(.trailing, Autoscale.convert(16))
                }
            }.padding(.top, Autoscale.convert(20)).padding(.bottom, Autoscale.convert(4))
                
            Divider()
            
            VStack {
                Group {
                    HStack {
                        Text("Weight").font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16))
                        Spacer()
                    }
                    WeightInput(weight: $weight, weightMetric: UserData.default.weightMetric, strokeColor: .black)
                }
                
                Group {
                    HStack {
                        Text("Height").font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16))
                        Spacer()
                    }.padding(.top, Autoscale.convert(10))
                    HeightInput(isPickerVisible: $viewModel.isPickerVisible, selection: $viewModel.selection, strokeColor: .black)
                    HeightInputPicker(isPickerVisible: $viewModel.isPickerVisible, selection: $viewModel.selection)
                }
                
                Group {
                    HStack {
                        Text("Age").font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16))
                        Spacer()
                    }.padding(.top, Autoscale.convert(10))
                    AgeInput(age: $age, strokeColor: .black)
                }
                
                Group {
                    HStack {
                        Text("Gender").font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16))
                        Spacer()
                    }.padding(.top, Autoscale.convert(10))
                    GenderInput(biologicalSex: $biologicalSex)
                }
                
                Group {
                    HStack {
                        Text("Recent Activity Level").font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16))
                        Spacer()
                    }.padding(.top, Autoscale.convert(10))
                    FitnessLevelInput(isPickerVisible: $isPickerVisible, fitnessLevel: $fitnessLevel, strokeColor: .black)
                    FitnessLevelInputPicker(isPickerVisible: $isPickerVisible, fitnessLevel: $fitnessLevel)
                }
                
                Spacer()
                
            }.padding(.horizontal, Autoscale.convert(16)).padding(.top, Autoscale.convert(30))
        }
    }
}

struct Confirmation_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationScreen(image: UIImage(named: "Women", in: .module, with: nil))
    }
}
