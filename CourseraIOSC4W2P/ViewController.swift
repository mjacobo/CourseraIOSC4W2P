//
//  ViewController.swift
//  CourseraIOSC4W2P
//
//  Created by Leyenda Software on 11/19/16.
//  Copyright © 2016 Mauricio Jacobo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var cancionPortada: UIImageView!
    @IBOutlet weak var cancionTitulo: UILabel!
    @IBOutlet weak var cancionSelector: UIPickerView!
    @IBOutlet weak var cancionShuffleButton: UIButton!
    @IBOutlet weak var cancionPlayButton: UIButton!
    @IBOutlet weak var cancionPauseButton: UIButton!
    @IBOutlet weak var cancionStopButton: UIButton!
    @IBOutlet weak var cancionVolumenControl: UISlider!
    private var reproductor: AVAudioPlayer!
    var pickerData: [String] = [String]()
    var carrousel: [cancion] = []
    var songNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.cancionSelector.delegate   = self
        self.cancionSelector.dataSource = self
        initCarrousel()
        
        for i in 0 ..< carrousel.count {
            pickerData.append(carrousel[i].titulo)
        }
        cancionTitulo.text = carrousel[0].titulo
        cancionPortada.image = UIImage.init(imageLiteralResourceName: carrousel[0].portada)
        let audioFileURL = Bundle.main.url(forResource: carrousel[0].cancionArch, withExtension: "m4a")!
       
        do {
            reproductor = try AVAudioPlayer(contentsOf: audioFileURL)
            playMySong()
            reproductor.volume = 0.25
        } catch {
            // couldn't load file :(
            print("Not file  found: " + carrousel[0].cancionArch)
        }
        
    }

    @IBAction func cancionShuffle() {
        songNumber = randomInt(min: 0, max:9)
        animateButton(myButton: cancionShuffleButton)
        cancionSelector.selectRow(songNumber, inComponent: 0, animated: true)
        cancionTitulo.text = carrousel[songNumber].titulo
        cancionPortada.image = UIImage.init(imageLiteralResourceName: carrousel[songNumber].portada)
        let audioFileURL = Bundle.main.url(forResource: carrousel[songNumber].cancionArch, withExtension: "m4a")!
        stopMySong()
        
        do {
            reproductor = try AVAudioPlayer(contentsOf: audioFileURL)
            playMySong()
            adjustVolume()
        } catch {
            // couldn't load file :(
            print("Not file  found: " + carrousel[songNumber].cancionArch)
        }
    }
    
    @IBAction func cancionPlay() {
        animateButton(myButton: cancionPlayButton)
        if !reproductor.isPlaying {
            playMySong()
            adjustVolume()
        }
    }
    
    @IBAction func cancionPausa() {
        animateButton(myButton: cancionPauseButton)
        if reproductor.isPlaying {
            reproductor.pause()
        }
    }
    
    @IBAction func cancionStop() {
        animateButton(myButton: cancionStopButton)
        stopMySong()
    }

    @IBAction func cancionVolumen() {
        adjustVolume()
    }

    func initCarrousel() {
        carrousel.append(cancion.init(portada:"capomo", titulo: "Flor de capomo - Carlos y Jose", cancionArch: "CARLOS Y JOSE....... FLOR DE CAPOMO"))
        carrousel.append(cancion.init(portada: "counting_down", titulo: "Counting Down The Days - Above & Beyond feat. Gemma Hayes", cancionArch: "Above & Beyond feat. Gemma Hayes Counting Down The Days (Official Video)"))
        carrousel.append(cancion.init(portada: "eres", titulo: "Eres Tú - Carla Morrison", cancionArch: "Carla Morrison - Eres Tú (letra)"))
        carrousel.append(cancion.init(portada: "is_this_love", titulo: "Is this Love - Bob Marley", cancionArch: "Is This Love - Bob Marley . Sub al español"))
        carrousel.append(cancion.init(portada: "misil", titulo: "Un Misil en mi Placard - Soda Stereo", cancionArch: "Soda Stereo - Un misil en mi placard"))
        carrousel.append(cancion.init(portada: "oops", titulo: "Oops - Martin Garrix", cancionArch: "Oops - Martin Garrix (Unofficial Video Game Inspired Clip)"))
        carrousel.append(cancion.init(portada: "que-sera", titulo: "Que Sera - Wax Tailor", cancionArch: "Wax Tailor - Que Sera (HQ)"))
        carrousel.append(cancion.init(portada: "rivers", titulo: "I Follow Rivers - Lykke Li", cancionArch: "Lykke Li - I Follow Rivers (Director- Tarik Saleh)"))
        carrousel.append(cancion.init(portada: "sirenito", titulo: "El Sirenito - Rigo Tovar", cancionArch: "El Sirenito - Rigo Tovar y su Conjunto Costa Azul (Remasterizado)."))
        carrousel.append(cancion.init(portada: "tous", titulo: "Marche pour la cérémonie des Turcs - Jordi Savall", cancionArch: "01. Marche pour la cérémonie des Turcs"))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cancionTitulo.text = carrousel[row].titulo
        cancionPortada.image = UIImage.init(imageLiteralResourceName: carrousel[row].portada)
        let audioFileURL = Bundle.main.url(forResource: carrousel[row].cancionArch, withExtension: "m4a")!
        stopMySong()
        
        do {
            reproductor = try AVAudioPlayer(contentsOf: audioFileURL)
            playMySong()
            adjustVolume()
        } catch {
            // couldn't load file :(
            print("Not file  found: " + carrousel[row].cancionArch)
        }
        songNumber=row
    }
    
    func animateButton(myButton: UIButton){
        UIView.animate(withDuration: 0.4, animations: {
            myButton.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
        }, completion: { (finish) in UIView.animate(withDuration: 0.4, animations: {
            myButton.transform = CGAffineTransform.identity
        })
        })
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }

    func playMySong(){
        if !reproductor.isPlaying {
            reproductor.play()
        }
    }
    
    func stopMySong(){
        if reproductor.isPlaying {
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
    }
    
    func adjustVolume(){
        reproductor.volume = cancionVolumenControl.value
    }
}

