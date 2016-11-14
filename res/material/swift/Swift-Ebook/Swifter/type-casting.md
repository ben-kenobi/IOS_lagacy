# 类型转换 {#type-casting}

暂时我们还不太可能脱离 Cocoa 框架，而 Swift 有着较强类型安全特性，其实这本质是和 Objective-C 时代的 Cocoa 框架是不太相符合的。在 Objective-C 里我们可以简单地使用 `id` 指代一切类型，并且在使用时如果我们可以完全确定的话，只需要声明并使用合适类型的指针就可以了。但是在 Swift 里事情就要麻烦一些，我们经常会需要进行向下的类型转换。比如下面这段代码在 Objective-C 中再普通不过了：

```objc
for (UIView *view in [self.view subviews]) {
    // 对 view 进行操作
    // 如果 view 实际上不是 UIView 的话，crash
    view.backgroundColor = [UIColor redColor];
}
```

在 Objective-C 中，因为没有泛型存在，因此虽然可以确信在 Cocoa 框架中 `self.view subviews` 返回的数组中的对象一定都是 `UIView` 的子类，但是在进行传递的时候这个信息并不为编译器所知。虽然在这个例子里对背景颜色的设定一定不可能造成崩溃，但是其实最为安全的写法应该是：

```swift
for (id object in [self.view subviews]) {
    if ([object isKindOfClass:[UIView class]]) {
        // 对 object 进行了判断，它一定是 UIView 或其子类
        UIView * view = (UIView *)object;
        // 对 view 进行操作
        // 因为 view 一定是 UIView，所以绝对安全
        view.backgroundColor = [UIColor redColor];
    }
}
```

在 Swift 中虽然有泛型，但是绝大多数 Cocoa API 并没有对 Swift 进行很好的适配，原来返回 `id` 的地方现在都以 `AnyObject` 或者 `AnyObject?` (如果可能是 `nil` 的话) 替代，而对于像数组这样的结构，除了 `String` 这样的精心打磨的类型以外，也基本是简单暴力地使用 `[AnyObject]` 的形式返回。这就导致了在这种情况下我们无法利用泛型的特性，而需要经常地做类型转换。Swift 中使用 `as!` 关键字做强制类型转换。结合使用 `is` 进行[自省](!!!!!!!intropection)，上面最安全的版本对应到 Swift 中的形式是：

```swift
for object in self.view.subviews {
    if object is UIView {
        let view = object as! UIView
        view.backgroundColor = UIColor.redColor()
    }
}
```

这显然还是太麻烦了，但是如果我们不加检查就转换的话，如果待转换对象 (`object`) 并不是目标类型 (`UIView`) 的话，app 将崩溃，这是我们最不愿意看到的。我们可以利用 Swift 的 Optional，在保证安全的前提下让代码稍微简单一些。在类型转换的关键字 `as` 后面添加一个问号 `?`，可以在类型不匹配及转换失败时返回 `nil`，这种做法显然更有 Swift 范儿：

```swift
for object in self.view.subviews {
    if let view = object as? UIView {
        view.backgroundColor = UIColor.redColor()
    }
}
```

不仅如此，我们还可以对整个 `[AnyObject]` 的数组进行转换，先将其转为 `[UIView]` 再直接使用：

```swift
if let subviews = self.view.subviews as? [UIView] {
    for view in subviews {
        view.backgroundColor = UIColor.redColor()
    }
}
```

注意对于整个数组进行转换这个行为和上面的单个转换的行为并**不是**等同的。整体转换要求数组里的**所有**元素都是目标类型，否则转换的整个结果都将变成 `nil`。

当然，因为这里我们总能保证 `self.view.subviews` 返回的数组里一定是 `UIView`，在这样的自信和这种特定的场景下，我们将代码写成强制的转换也无伤大雅：

```swift
for view in self.view.subviews as! [UIView] {
    view.backgroundColor = UIColor.redColor()
}
```

但是需要牢记，这是以牺牲了一部分类型安全为代价的简化。如果代码稍后发生了意料之外的变化，或者使用者做了什么超乎常理的事情的话，这样的代码是存在崩溃的风险的。
