import PlaygroundSupport
import Foundation
import UIKit

var currentCenter = UILabel()
var doubleCC: Double = 0
var currentDegree = UILabel()
var intCD: Int = 0

/*:
 ## Taylor Series Approximations
 * A Taylor series approximation can be used to represent a function as an infinite sum of terms that are calculated from the values of the function's derivatives at a single point.
 * The general form of a Taylor series expansion can be expressed as:
 
 
 *f(x) = f(a) + f'(a)(x - a) + [f''(a)(x - a)^2]/2! + [f'''(a)(x - a)^3]/3! + ...*
 
 
 * If a Taylor series is centered at 0, it is also known as a Maclaurin series.
 
 
 ### What are Taylor Series Approximations useful for?
 * Taylor series can be used to approximate solutions to differential equations that are difficult to directly solve.
 * They can be used to determine limits and infinite sums.
 * They have extensive applications in mechanical and electrical engineering - for example, they can be used to model fluid motion.
 * Taylor series can be used in physics to represent complicated systems, such as systems exhibiting sinusoidal behavior.
 * They are useful in determining molecular geometry patterns in chemistry.
 * In general, Taylor series approximations can improve our understanding of situations modeled by complex functions by allowing us to work with polynomials.
 
 
 ### User Instructions
 * Displayed in the Assistant Editor is a graph of *f(x) = sin(x)* in the color black.
 * The sine wave is a good function with which to introduce Taylor polynomials to learners.
 * The Taylor series for *f(x) = sin(x)* centered at 0 is:
 
 
 *sin(x) = x - (x^3)/3! + (x^5)/5! - (x^7)/7! + (x^9)/9! - ...*
 
 
 * Thus users should see a change in the shape of the graph every 2 degrees, if the graph is centered at 0.
 * The 0th degree Taylor polynomial centered at *x = 0* (a straight line coinciding with the *x*-axis) is also displayed in the color blue.
 * To modify the center of the polynomial, use the '+' and '-' buttons under the label 'center'.
    * These buttons increment the center of the polynomial by ± 0.1.
 * To modify the degree of the polynomial, use the '+' and '-' buttons under the label 'degree'.
    * These buttons increment the degree of the polynomial by ± 1.
 * To reset either the center or the degree (or both) of the polynomial, use the reset buttons at either lower corner of the screen.
 * At what combinations of center/degree does the blue-colored Taylor polynomial seem to coincide with the black-colored sine wave in the given frame?
 */


/*:
 ### Calculating the factorial of a number *n*:
 *n! = n * (n - 1) * (n - 2) * ... * 2 * 1*
 * For example, 5! = 5 * 4 * 3 * 2 * 1 = 120
    * The factorial of 0 is 1. One way to think of this is factorials represent the number of ways in which a set of items can be arranged. Since there is only 1 way to arrange 0 items, 0! = 1.
 * The factorial function below takes the number *n* with which to calculate a factorial. It uses recursion (the definition of the function contains a call to itself) based on the fact that n! = n * (n - 1)!.
*/
func factorial(n: Int) -> Int {
    if (n == 0) {
        return 1
    }
    return (n * factorial(n: n - 1))
}


/*:
 ### Calculating the derivative of *f(x) = sin(x)* at a point:
 * A derivative is essentially a way of representing the rate of change, or slope, of a function.
 * The sine function demonstrates a pattern in its derivatives.
    * The first derivative of *sin(x)* is *cos(x)*.
    * The second derivative of *sin(x)* is the derivative of *cos(x)*, which is *-sin(x)*.
    * The third derivative of *sin(x)* is the derivative of *-sin(x)*, which is *-cos(x)*.
    * The fourth derivative of *sin(x)* is the derivative of *-cos(x)*, which is *sin(x)*.
    * From there, the pattern repeats.
 * A switch statement can be used to calculate the *n*th derivative of *sin(x)* at a point. The derivative function below takes the x-coordinate of the point and the degree of the derivative as input.
 */
func derivative(x: Double, degree: Int) -> Double {
    let mod = degree % 4
    switch mod {
    case 0:
        return sin(x)
    case 1:
        return cos(x)
    case 2:
        return -1 * sin(x)
    case 3:
        return -1 * cos(x)
    default:
        return 0.0
    }
}


/*:
 ### Graphing the sine function:
 * The graphing function below keeps track of the last *x* and *y* value in order to draw a path from the previous to current coordinate.
 * Before it does this, it initializes the 'lastx' to -2π and 'lasty' to the value of the sine function at *x = -2π*
 * The function then loops through the domain displayed on the graph [-2π, 2π], calculating the value of the sine function at the current *x*-value and drawing a line from the current coordinate to the last one.
 */
func graphSine() {
    let context1 = UIGraphicsGetCurrentContext()
    var j: Double
    var k: Double
    var lastx: Double = -6.28
    var lasty: Double = 0
    for i in stride(from: -6.28, to: 6.28, by: 0.1) {
        
        j = Double(i)
        k = sin(j)
        
        context1?.setStrokeColor(UIColor.black.cgColor)
        context1?.setLineWidth(1.25)
        context1?.beginPath()
        context1?.move(to: CGPoint(x: lastx * 50 + 314.5, y: -1 * lasty * 100 + 300))
        context1?.addLine(to: CGPoint(x: i * 50 + 314.5, y: -1 * k * 100 + 300))
        context1?.strokePath()
        
        lastx = i
        lasty = k
    }
}


/*:
 ### Graphing the Taylor polynomial:
 * The graphing function below keeps track of the last *x* and *y* value in order to draw a path from the previous to current coordinate.
    * Before it does this, it initializes the 'lastx' to -2π and 'lasty' to the value of the Taylor polynomial at *x = -2π*
 * The function then loops through the domain displayed on the graph [-2π, 2π], calculating the value of the Taylor polynomial at the current *x*-value and drawing a line from the current coordinate to the last one.
 */
func graphPoly() {
    let context2 = UIGraphicsGetCurrentContext()
    print("center: \(doubleCC)")
    print("degree: \(intCD)")
    
    var approxy: Double = 0
    var lastx: Double = -6.28
    var lasty: Double = 0
    for j in 0...intCD {
        lasty += (((derivative(x: Double(doubleCC), degree: j)) * pow((-6.28 - Double(doubleCC)), Double(j))) / Double(factorial(n: j)))
    }
    for i in stride(from: -6.28, to: 6.28, by: 0.1) {
        
        for j in 0...intCD {
            approxy += (((derivative(x: Double(doubleCC), degree: j)) * pow((i - Double(doubleCC)), Double(j))) / Double(factorial(n: j)))
        }
        
        context2?.setStrokeColor(UIColor.blue.cgColor)
        context2?.setLineWidth(1.25)
        context2?.beginPath()
        context2?.move(to: CGPoint(x: lastx * 50 + 314.5, y: -1 * lasty * 100 + 300))
        context2?.addLine(to: CGPoint(x: i * 50 + 314.5, y: -1 * approxy * 100 + 300))
        context2?.strokePath()
        
        lastx = i
        lasty = approxy
        approxy = 0
    }
}


/*:
 ### Updating the graph based on user changes:
 * Using a property observer, changes to the center or degree are monitored so that the polynomial can be redrawn accordingly.
 */
class updatePoly {
    var c: Double! {
        didSet {
            print("value for center was updated to \(doubleCC)")
            graphPoly()
        }
    }
    var d: Int! {
        didSet {
            print("value for degree was updated to \(intCD)")
            graphPoly()
        }
    }
}


/*:
 Setting up the background:
 * The view consists of a white rectangle of width 628 and height 600.
 * The *x*- and *y*- axes go through the center of the view.
 * The graphs will be modified to scale.
 * The final graph displayed to the user goes from *x = -2π* to *x = 2π* and *y = -3* to *y = 3*.
 * Labels at the top of the view show the current center and degree of the polynomial.
 * Users can adjust the center and degree using the '+' and '-' buttons, and reset either the center or the degree to 0 using the 'reset' buttons.
 */
class ViewController: UIView {
    
    let userMonitor = updatePoly()
    
    // Setting Up Background
    public override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0,y: 0, width: 628, height: 600))
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        // Setting Up Coordinate Axes
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(0.85)
        context?.beginPath()
        context?.move(to: CGPoint(x: 314, y: 0))
        context?.addLine(to: CGPoint(x: 314, y: 600))
        context?.strokePath()
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(1)
        context?.beginPath()
        context?.move(to: CGPoint(x: 0, y: 300))
        context?.addLine(to: CGPoint(x: 628, y: 300))
        context?.strokePath()
        
        // Setting Up Labels Displaying Current Center & Degree
        let centerInstructions = UILabel()
        centerInstructions.text = "center:"
        let degreeInstructions = UILabel()
        degreeInstructions.text = "degree:"
        currentCenter.text = String(doubleCC)
        currentDegree.text = String(intCD)
        addSubview(centerInstructions)
        addSubview(degreeInstructions)
        addSubview(currentCenter)
        addSubview(currentDegree)
        centerInstructions.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([centerInstructions.topAnchor.constraint(equalTo: topAnchor, constant: 20), centerInstructions.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)])
        degreeInstructions.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([degreeInstructions.topAnchor.constraint(equalTo: topAnchor, constant: 20), degreeInstructions.trailingAnchor.constraint(equalTo: currentDegree.leadingAnchor, constant: -20)])
        currentCenter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([currentCenter.topAnchor.constraint(equalTo: topAnchor, constant: 20), currentCenter.leadingAnchor.constraint(equalTo: centerInstructions.trailingAnchor, constant: 20)])
        currentDegree.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([currentDegree.topAnchor.constraint(equalTo: topAnchor, constant: 20), currentDegree.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
        
        // Setting Up X- and Y- Axis Labels
        let xLeft = UILabel()
        let xRight = UILabel()
        let yLower = UILabel()
        let yUpper = UILabel()
        xLeft.text = "-2π"
        xLeft.font = UIFont.systemFont(ofSize: 10)
        xRight.text = "2π"
        xRight.font = UIFont.systemFont(ofSize: 10)
        yLower.text = "-3"
        yLower.font = UIFont.systemFont(ofSize: 10)
        yUpper.text = "3"
        yUpper.font = UIFont.systemFont(ofSize: 10)
        addSubview(xLeft)
        addSubview(xRight)
        addSubview(yLower)
        addSubview(yUpper)
        xLeft.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([xLeft.topAnchor.constraint(equalTo: centerYAnchor, constant: 7.5), xLeft.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)])
        xRight.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([xRight.topAnchor.constraint(equalTo: centerYAnchor, constant: 7.5), xRight.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)])
        yLower.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([yLower.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10), yLower.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 7.5)])
        yUpper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([yUpper.topAnchor.constraint(equalTo: topAnchor, constant: 10), yUpper.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 11)])
        
        // Setting Up Buttons Allowing Users to Adjust Center & Degree
        let centerPlus = UIButton(type: .system)
        centerPlus.setTitle("+", for: .normal)
        centerPlus.addTarget(self, action: #selector(plusCenter), for: .touchUpInside)
        addSubview(centerPlus)
        centerPlus.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([centerPlus.topAnchor.constraint(equalTo: centerInstructions.lastBaselineAnchor, constant: 20), centerPlus.leadingAnchor.constraint(equalTo: centerInstructions.leadingAnchor)])
        let centerMinus = UIButton(type: .system)
        centerMinus.setTitle("-", for: .normal)
        centerMinus.addTarget(self, action: #selector(minusCenter), for: .touchUpInside)
        addSubview(centerMinus)
        centerMinus.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([centerMinus.topAnchor.constraint(equalTo: currentCenter.lastBaselineAnchor, constant: 20), centerMinus.leadingAnchor.constraint(equalTo: centerInstructions.trailingAnchor)])
        let degreePlus = UIButton(type: .system)
        degreePlus.setTitle("+", for: .normal)
        degreePlus.addTarget(self, action: #selector(plusDegree), for: .touchUpInside)
        addSubview(degreePlus)
        degreePlus.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([degreePlus.topAnchor.constraint(equalTo: degreeInstructions.lastBaselineAnchor, constant: 20), degreePlus.leadingAnchor.constraint(equalTo: degreeInstructions.leadingAnchor)])
        let degreeMinus = UIButton(type: .system)
        degreeMinus.setTitle("-", for: .normal)
        degreeMinus.addTarget(self, action: #selector(minusDegree), for: .touchUpInside)
        addSubview(degreeMinus)
        degreeMinus.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([degreeMinus.topAnchor.constraint(equalTo: currentDegree.lastBaselineAnchor, constant: 20), degreeMinus.leadingAnchor.constraint(equalTo: degreeInstructions.trailingAnchor)])
        
        // Setting Up Reset Center & Degree Buttons
        let resetc = UIButton(type: .system)
        resetc.setTitle("reset center", for: .normal)
        resetc.tintColor = UIColor.red
        resetc.addTarget(self, action: #selector(resetCenter), for: .touchUpInside)
        addSubview(resetc)
        resetc.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resetc.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20), resetc.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)])
        let resetd = UIButton(type: .system)
        resetd.setTitle("reset degree", for: .normal)
        resetd.tintColor = UIColor.red
        resetd.addTarget(self, action: #selector(resetDegree), for: .touchUpInside)
        addSubview(resetd)
        resetd.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resetd.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20), resetd.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
        
        graphSine()
        graphPoly()
        
    }
    
    @objc func plusCenter() {
        doubleCC += 0.1
        userMonitor.c = doubleCC
        currentCenter.text = String(doubleCC)
        setNeedsDisplay()
    }
    @objc func minusCenter() {
        doubleCC -= 0.1
        userMonitor.c = doubleCC
        currentCenter.text = String(doubleCC)
        setNeedsDisplay()
    }
    @objc func plusDegree() {
        intCD += 1
        userMonitor.d = intCD
        currentDegree.text = String(intCD)
        setNeedsDisplay()
    }
    @objc func minusDegree() {
        if (intCD - 1 >= 0) {
            intCD -= 1
        } else {
            intCD = 0
        }
        userMonitor.d = intCD
        currentDegree.text = String(intCD)
        setNeedsDisplay()
    }
    @objc func resetCenter() {
        doubleCC = 0
        userMonitor.c = doubleCC
        currentCenter.text = String(doubleCC)
        setNeedsDisplay()
    }
    @objc func resetDegree() {
        intCD = 0
        userMonitor.d = intCD
        currentDegree.text = String(intCD)
        setNeedsDisplay()
    }
}


PlaygroundPage.current.liveView = ViewController()


