//
//  BarcodeVC.swift
//  Deeplinks
//
//  Created by Kitiwat Chanluthin  on 21/11/2562 BE.
//  Copyright © 2562 Stanislav Ostrovskiy. All rights reserved.
//

import UIKit
import QRCodeReader
import AVFoundation
import AudioToolbox

class BarcodeVC: UIViewController  {

    @IBOutlet weak var txt: UITextField!
    
    var codes:[String] = []
    
    @IBOutlet weak var previewView: QRCodeReaderView! {
      didSet {
        previewView.setupComponents(with: QRCodeReaderViewControllerBuilder {
          $0.reader                 = reader
          $0.showTorchButton        = false
          $0.showSwitchCameraButton = false
          $0.showCancelButton       = false
          $0.showOverlayView        = true
          $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        })
      }
    }
    lazy var reader: QRCodeReader = QRCodeReader(metadataObjectTypes: [.qr,.code128])


    // MARK: - Actions

    private func checkScanPermissions() -> Bool {
      do {
        return try QRCodeReader.supportsMetadataObjectTypes()
      } catch let error as NSError {
        let alert: UIAlertController

        switch error.code {
        case -11852:
          alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)

          alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
            DispatchQueue.main.async {
              if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(settingsURL)
              }
            }
          }))

          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        default:
          alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }

        present(alert, animated: true, completion: nil)

        return false
      }
    }

    private func vibrate(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    private func beep(){
        let id = 1002
        AudioServicesPlaySystemSound(SystemSoundID(id))
    }

    @IBAction func scanInPreviewAction(_ sender: Any) {
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reader.stopScanningWhenCodeIsFound = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("view will appear")
        print("when party is over")
        startScan()
    }
    
    private func startScan(){
        guard checkScanPermissions(), !reader.isRunning else { return }
        
        reader.didFindCode = { result in
            print("Completion with result: \(result.value) of type \(result.metadataType)")
            self.beep()
            self.vibrate()
            let alert = UIAlertController(title: "Found QR", message: "data:\(result.value)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            //      self.reader.stopScanning()
        }
        
        reader.startScanning()
    }
    
}


extension BarcodeVC: QRCodeReaderViewControllerDelegate{
    
    private func testDif(){
        print("test diff")
    }
    
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()

        dismiss(animated: true) { [weak self] in
          let alert = UIAlertController(
            title: "QRCodeReader",
            message: String (format:"%@ (of type %@)", result.value, result.metadataType),
            preferredStyle: .alert
          )
          alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

          self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()

           dismiss(animated: true, completion: nil)
    }
    
    
}
