# CALayer-CAAnimation_usage

# 今日小结

- CALayer包含在CoreGraphic(QuartzCore)中，是跨平台的。所以我们不能直接用UIKit中的对象给它赋值。最常见的UIImage，需转换成CGImageRef。

- CALayer属性 doubleSided：决定图层背面是否显示，Default YES

- CALayer中通常不使用frame，因为不支持动画效果。一把用bounds和position来代替

- 根图层self.view.layer无法使用动画。一般我们会自定义图层，或新建图层。

- CATransform3D CATransform3DMakeRotation (CGFloat angle, CGFloat x,

  ​    CGFloat y, CGFloat z)。图层的@property CATransform3D transform属性值。表示：以一个layer的position为中心点，把它放进一个三维坐标系。angle为旋转角度，x,y,z分别表示在x,y,z坐标系中，相对angle之后所旋转的角度。

- 在-drawLayer: inContext:代理中通过void CGContextDrawImage(CGContextRef cg_nullable c, CGRect rect, CGImageRef cg_nullable image)方法绘制的图片默认是上下颠倒的。

- 解决上述颠倒问题的方法：

  > layer.transform = CATransform3DMakeRotation(M_PI, 1, 0 ,0 );
  >
  > 或者用KVC来设置transform属性：
  >
  > [layer setValue:@M_PI forKeyPath:@"transform.rotation.x"]

  > 或者不用代理来绘制图片，直接用layer.contents = CGImageRef;

- CATransition：过渡动画，一般叫做转场动画。主要通过滤镜进行动画效果的设置。主要用于从一个场景以动画的形式过渡到另一个场景。

- 基础动画在设置时可以忽略初始值。

- self.window.layer.speed = 0.1；可以减速主窗口上添加的任何动画的时间。

- CABasicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"myCustomizeKey"，给animation添加一个自定义的键值对。后面可以通过valueForKey:@"myCustomizeKey"]来取出。

- 绘制可以用 UIBezierPath和CGPathRef。

- 推荐看2片文章来入门：[1111](http://www.cnblogs.com/kenshincui/p/3972100.html)、[2222](http://www.jianshu.com/p/92a0661a21c6)

- self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]]; 可以以一张图片作为背景颜色

