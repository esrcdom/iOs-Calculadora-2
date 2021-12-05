//
//  HomeViewController.swift
//  iOs Calculadora 2
//
//  Created by Marcelo Dominguez on 28/08/2021.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: Outlets
    
    
    
    // Result
    @IBOutlet weak var resultLabel: UILabel!
    
    // Numbers
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    
    
    // Operators
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorPercent: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operatorAddition: UIButton!
    @IBOutlet weak var operatorSubstraccion: UIButton!
    @IBOutlet weak var operatorMultiplication: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    
    // MARK: Variables
    
    private var total: Double = 0          // Total
    private var temp: Double = 0          // Valor por pantalla
    private var operating = false        // Indicar si se ha seleccionado un operador
    private var decimal = false         // Indicar si el valor es decimal
    private var operation: OperationType = .none // Operación actual
    
    // MARK: Constantes
    
    private let kDecimalSeparator = Locale.current.decimalSeparator!            //en swift le ponemos 'k'delante de las contantes
    private let kMaxLenght = 9
    private let kMaxValue: Double = 999999999
    private let kMinValue: Double = 0.00000001
    private let kTotal = "total"
    
    
    public enum OperationType{   // cambie de private a public
        case none, addiction, substraction, multiplication, division
    }
    
    // Formateo de valores auxiliar
    
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator =  locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
        
}()
    
    // Formateo de valores auxiliares totales
    private let auxTotalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
}()
    
    // Formateo de valores por pantalla por defecto
    
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
        
}()
  
    
    
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        total = UserDefaults.standard.double(forKey: kTotal)
       
    }

   // MARK: Button Actions
    @IBAction func operatorACAction(_ sender: UIButton) {
        
        clear()
        
        sender.shine()
    }
    
    @IBAction func operatorPlusMinusAction(_ sender: UIButton) {
        
        temp = temp * (-1)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        sender.shine()
    }
    
    @IBAction func operatorPercentAction(_ sender: UIButton) {
        
        temp = temp / 100
        
        operating = true
       result()
        
        sender.shine()
    }
    
    @IBAction func operatorResultAction(_ sender: UIButton) {
        
        result()
    
        sender.shine()
    }
    
    @IBAction func operatorAdditionAction(_ sender: UIButton) {
        
      
        operating = true
        operation = .addiction
        
        sender.shine()
    }
    
    @IBAction func operatorSubstraccionAction(_ sender: UIButton) {
        
    
        operating = true
        operation = .substraction
        
        sender.shine()
    }
    
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
        
        
               
        operating = true
        operation = .multiplication
       
               
        sender.shine()
    }
    
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
           operating = true
           operation = .division
       
             
           sender.shine()
    }
    
   
    
    @IBAction func numberAction(_ sender: UIButton) {
        
        operatorAC.setTitle("C", for: .normal)
        
        var currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count >= kMaxLenght {
            return
        }
        // seleccio operación
        if operating {
            total = total == 0 ? temp : total
            resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        
        // seleccion decimales
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        
        
      
        
        sender.shine()
    }
    
    // Limpia los valores
        private func clear() {
            if operation == .none {
                total = 0
            }
            operation = .none
            operatorAC.setTitle("AC", for: .normal)
            if temp != 0 {
                temp = 0
                resultLabel.text = "0"
            } else {
                total = 0
                result()
            }
        }
    
    // Obtiene el resultado final
    private func result() {
        switch operation {
        
        case .none:
            // No hacemos nada
            break
        case .addiction:
            total = total + temp
            break
        case .substraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        }
  
        actualizarResult(result: total)
        operation = .none
        print( total)
        
        
    }
    
    func formatearResultado(resultado: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        let number = NSNumber(value: resultado)
        return formatter.string(from: number)!
    }
    
    
    
    func actualizarResult(result: Double) {
        resultLabel.text = formatearResultado(resultado: result)
        
    }
    
    
}
