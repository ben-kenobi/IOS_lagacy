# Playground 限制 {#playground-limit}

虽然 Playground 给了我们很多的便利，但是因为运行环境和特点的原因，在 Playground 中进行代码的实验还是有所限制的。

### 性能限制

最明显的就是性能限制，我们在 Playground 中书写的代码本身并没有什么特殊之处，都会以 `.swift` 的格式被放在 Playground 包中。以 iOS 为例子，在运行的时候整个 Playground 将被加载到 64 位的 iPhone 模拟器中。首先这些代码没有经过 `-O` 的编译器优化，仅仅只是 `-Onone` 的调试代码；另外，因为每一句代码都会需要记录和互动输出，因此大量的时间被消耗在了时间轴或者侧栏的输出中。我们**不应该**在 Playground 中测试我们代码的性能。在 Xcode 6 中一个合适并且被推荐的测试代码性能的工具是 XCTest 测试套件中新加入的 block 测试，在 Playground 中，我们更多的应该做的是检查代码的逻辑和步骤是否正确。

不过虽然无法测试代码性能，我们还是可以方便的观察某个方法调用的次数的 -- Playground 会为我们忠实地记录下这个数据。在大多数算法开发中，其实调用次数直接影响或者决定了性能的好坏，所以在这种情况下，我们通过观察某个关键方法的调用次数，也能大概了解算法效率情况，十分方便。

### 内存管理

Playground 里是不会释放内存的，比如这样一段代码：

    class ClassA {
        deinit {
            println("deinit A")
        }
    }

    class ClassB {
        deinit {
            println("deinit B")
        }
    }

    var a: AnyObject = ClassA()
    a = ClassB()


理论上在将 `obj` 设置为 `ClassB` 的实例后，之前 `ClassA` 的实例应该被释放掉，`deinit` 方法应该被调用。但是 `ClassA` 的 `deinit` 中的输出并没有出现在控制台中。这并不是说 Swift 的 ARC 内存管理出现了什么问题，而是因为 Playground 的运行环境也持有了这些变量。

不论在侧边的结果栏中，还是在辅助编辑器的时间轴上，我们都有可能在整个 Playground 的代码执行完毕后再去点击或者查看。这就要求 Playground 本身持有每个变量，这些变量变化的过程，以及每次调用的结果。这导致在 Playground 中重新开始一次运行之前，内存是无法释放的。如果我们把这段代码移到一个工程文件中，就可以在控制台观察到正确的内存管理行为了：

    func application(application: UIApplication!,
        didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.

        var a: AnyObject = ClassA()
        a = ClassB()

        return true
    }

    // 输出:
    // deinit A
    // deinit B

所以说，不要尝试在 Playground 中学习或者测试像是 [weak 或者 unowned](!!!!!!!retain-cycle) 的标注这样的内存管理相关的代码，你是不能得到正确的结果的。
