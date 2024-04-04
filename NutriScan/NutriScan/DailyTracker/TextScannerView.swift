import SwiftUI
import Vision
import VisionKit

struct TextScannerView: UIViewControllerRepresentable {
    @Binding var recognizedText: String
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, parent: self)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = context.coordinator
        return documentCameraViewController
    }
    
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
        if let image = UIImage(named: "test_document") {
            context.coordinator.recognizeText(from: image)
        }
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var recognizedText: Binding<String>
        var parent: TextScannerView
        
        init(recognizedText: Binding<String>, parent: TextScannerView) {
            self.recognizedText = recognizedText
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let image = scan.imageOfPage(at: 0) // Use the first scanned page
            recognizeText(from: image)
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        // Remove the 'private' access modifier to make this method accessible
        func recognizeText(from image: UIImage) {
            guard let cgImage = image.cgImage else { return }
            
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            let request = VNRecognizeTextRequest { (request, error) in
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                
                let recognizedStrings = observations.compactMap { observation in
                    return observation.topCandidates(1).first?.string
                }
                
                DispatchQueue.main.async {
                    self.recognizedText.wrappedValue = recognizedStrings.joined(separator: "\n")
                }
            }
            request.recognitionLevel = .accurate
            
            try? requestHandler.perform([request])
        }
    }
}
