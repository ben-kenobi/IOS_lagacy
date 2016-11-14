# 方法参数名称省略 {#func-naming}

Objective-C 在方法命名上可能不太讨初学者喜欢，但是往往有一定经验的 Objective-C 开发者都会爱上它的方法命名方式。因为详细的参数名和几乎完整及标准的英文可以将方法准确地描述出来，很多时候进行 Objective-C 开发只需要依赖 IDE 的补全，甚至连文档都可以不看。比如 Objective-C 里的 `NString` 类里有个这样的方法：

    - (BOOL)writeToFile:(NSString *)path 
             atomically:(BOOL)useAuxiliaryFile 
               encoding:(NSStringEncoding)enc 
                  error:(NSError **)error

不仅是定义的时候很清楚，在实际使用时，因为我们是需要把方法名写完整的，所以在阅读时也完全没有查阅文档的必要，我们就可以很清楚明白地指出每个参数的意义：

    [str writeToFile:aPath atomically:YES 
            encoding:NSUTF8StringEncoding error:&err];

这个方法读作 “将 str 写入到 aPath 这个文件中，使用原子写入的方式并将编码设定为 UTF，如果出现错误则存储到 err 中去”。

Swift 的方法命名继承和发扬了这个优点，上面这个方法在 Swift 中的定义是：

    func writeToFile(_ path: String,
          atomically useAuxiliaryFile: Bool,
            encoding enc: UInt,
               error error: NSErrorPointer) -> Bool


同样的 API 在 Objective-C 和 Swift 中的声明除了必要的类型的切换以外，其余基本保持了一致。而我们注意到 Swift 版本中的第一个参数的前面加了下划线 `_`，这代表在调用这个方法时，我们不应该把这个参数名显式地写出来。于是，在 Swift 中对该方法的调用是：

    str.writeToFile(aPath, atomically:true, 
                    encoding:NSUTF8StringEncoding, error: &err)

为了方便对比，我们把刚才的 Objective-C 的调用再写一遍：

    [str writeToFile:aPath atomically:YES 
                    encoding:NSUTF8StringEncoding error:&err];

两者从形式和结构上都保持了高度一致，可以说，为了达到这样的视觉效果，Apple 特意将第一个参数的名称给省略掉，然后保留了其他参数的名称并与 Cocoa 框架保持一致。

实际上，即使是我们不在参数前加任何标记来显式地表明是否需要写名称的情况下，对于何时强制需要名称标签，何时强制不要名称标签，也是有规则的。在类型的 `init` 方法中是需要加入标签的，比如下面例子的 `color` 和 `weight` 都不能省略：

    class Car {
        init(color: UIColor, weight: Int) {
            //...
        }
    }

    let car = Car(color: UIColor.redColor(), weight: 10)

而对于实例方法来说，我们对其调用时 Swift 将忽略第一个参数的标签，而强制要求之后的参数名称：

    extension Car {
        func moveToX(x: Int, y: Int) {
            //...
        }
    }

    car.moveToX(10, y: 20)

对于类方法，也是如此：

    extension Car {
        class func findACar(name: String, color: UIColor) -> Car? {
            var result: Car?
            //...
            return result
        }
    }

    let myPorsche = Car.findACar("Porsche", color: UIColor.yellowColor())

但是有一个例外，那就是如果这个方法是一个全局方法的话，参数名称默认是省略掉的：

    // 注意，现在不在 Car 中，而是在一个全局作用域
    func findACar(name: String, color: UIColor) -> Car? {
        var result: Car?
        //...
        return result
    }

    let myFerrari = findACar("Ferrari", UIColor.redColor())

为什么要设定成全局方法和局部的方法在默认的参数标签上要有这样的区别呢？这当然不是 Chris Lattner 在做这块的时候高兴随手写的。其实这是因为很多原来的底层 C 函数都是声明在全局范围内的，因此全部用匿名参数才符合原来的调用方式。

各种不同作用域下的方法/函数调用的参数名称虽然有严格的规定，但是各不相同所造成的后果是面试的时候用 Swift 写白板代码的话可能不太容易一次写对。

当然，以上种种我们都可以通过添加 `#`，`_` 或者是显式地加上标签名称来在调用时强制要求添加或者不添加参数名称。但是我们在实践中最好是遵循 Swift 的默认规则。在大多数时候，我们需要的是普通方法调用和初始化方法调用：对于普通方法，匿名第一个参数，并强制要求其他的参数名称；对于初始化方法，强制要求所有参数使用命名 (除非有特殊情况或完全没有歧义的情况下可以省略名称)。这样做有助于保证写出来的方法风格与整个平台统一，并且在调用时保持原有的“代码即文档”的优良特性。


