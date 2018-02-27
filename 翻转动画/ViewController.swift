//
//  ViewController.swift
//  翻转动画
//
//  Created by feng on 2017/12/4.
//  Copyright © 2017年 tianlinchun. All rights reserved.
//

import UIKit

/**
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];

 imageView.center = CGPointMake(200, 300);

 UIImage *anotherImage = [UIImage imageNamed:@"image"];

 UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);

 [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds

 cornerRadius:50] addClip];

 [anotherImage drawInRect:imageView.bounds];

 imageView.image = UIGraphicsGetImageFromCurrentImageContext();

 UIGraphicsEndImageContext();

 [self.view addSubview:imageView];
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()



        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        imageView.backgroundColor = UIColor.orange
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 50
        imageView.image = UIImage.init(named: "timg")
        imageView.image?.cornerImage(size: imageView.bounds.size, radius: 50, fillColor: UIColor.white, completion: { (image) in
            imageView.image = image
        })
        imageView.center = self.view.center
        imageView.tag = 100
        imageView.corner(byRoundingCorners: .allCorners, radii: 50)
        self.view.addSubview(imageView)
    }


    @IBAction func animationAction(_ sender: Any) {
        if let view = self.view.viewWithTag(100) {
//            //将整个主视图面板实现一个翻转效果
//            UIView.beginAnimations("animation", context: nil)
//            UIView.setAnimationDuration(2)
//            UIView.setAnimationCurve(.easeInOut)
//            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
//            UIView.commitAnimations()


            let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.x")
            rotationAnimation.fromValue = 0
            rotationAnimation.toValue = 2 * CGFloat.pi
            rotationAnimation.duration = 2
            view.layer.add(rotationAnimation, forKey: nil)

        }

//        //淡出动画
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(2.0)
//        imageView.alpha = 0.0
//        UIView.commitAnimations()
//
//        //淡入动画
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(2.0)
//        imageView.alpha = 1.0
//        UIView.commitAnimations()
//
//        //移动动画
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(2.0)
//        imageView.center = CGPoint(x:250, y:250)
//        UIView.setAnimationCurve(.easeOut) //设置动画相对速度
//        UIView.commitAnimations()
//
//        //大小调整动画
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(2.0)
//        imageView.frame = CGRect(x:100, y:180, width:50, height:50)
//        UIView.commitAnimations()

//        UIView.animate(withDuration: 10, delay: 0, options: .curveLinear, animations: animSpin, completion: nil)
    }

    //旋转动画
    func rotationAnimz() {
        let rotationAnim = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnim.fromValue = 0
        rotationAnim.toValue = CGFloat.pi * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5
        // 这个属性很重要 如果不设置当页面运行到后台再次进入该页面的时候 动画会停止
        rotationAnim.isRemovedOnCompletion = false

        // 3.将动画添加到layer中
        view.layer.add(rotationAnim, forKey: nil)
    }

    func shakeAnimation(){
        //移除self.mineTopView.layer上的所有动画，可以避免多次重复添加
        self.view.layer.removeAllAnimations()
        let momAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        momAnimation.fromValue = NSNumber(value: -0.1) //左幅度
        momAnimation.toValue = NSNumber(value: 0.1) //右幅度
        momAnimation.duration = 0.1
        momAnimation.repeatCount = HUGE //无限重复
        momAnimation.autoreverses = true //动画结束时执行逆动画
//        self.momAnimation.isRemovedOnCompletion = false //切出此界面再回来动画不会停止
//
//        self.momAnimation.delegate = self//CAAnimationDelegate 代理中有动画的开始和结束
//        self.mineTopView.layer.add(momAnimation, forKey: "centerLayer")
    }

//    - (void)Animation
//    {
//    // 设定为缩放
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    // 动画选项设定
//    animation.duration = 2.0; // 动画持续时间
//    animation.repeatCount = HUGE_VALF; // 重复次数(无限)
//    animation.autoreverses = YES; // 动画结束时执行逆动画
//
//    // 缩放倍数
//    animation.fromValue = [NSNumber numberWithFloat:0.9]; // 开始时的倍率
//    animation.toValue = [NSNumber numberWithFloat:1.1]; // 结束时的倍率
//
//    // 添加动画
//    [self.moveView.layer addAnimation:animation forKey:@"scale-layer"];
//    }

//    - (void)transitionAnimation
//    {
//    CGContextRef context=UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//可选
//    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.moveView cache:YES];//UIViewAnimationTransitionCurlUp五种翻转效果可选
//    [UIView setAnimationDelegate:self];
//    [UIView commitAnimations];
//    }

    func animSpin(){
        if let view = self.view.viewWithTag(100) {
            //旋转角度
            view.transform = view.transform.rotated(by: CGFloat(-10))
        }

    }

    
    func imageSetRounded(imageViewBounds bounds: CGRect, image: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        UIBezierPath(roundedRect: bounds, cornerRadius: min(bounds.size.width, bounds.size.height)*0.5).addClip()
        image.draw(in: bounds)
        UIGraphicsEndImageContext()
        return image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIView {

    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

extension UIImage {

    /// 异步设置圆角图片
    ///
    /// - Parameters:
    ///   - size:       图片大小
    ///   - radius:     圆角值
    ///   - fillColor:  裁切区域填充颜色
    ///   - completion: 回调裁切结果图片
    func cornerImage(size:CGSize, radius:CGFloat, fillColor: UIColor, completion:@escaping ((_ image: UIImage)->())) -> Void {

        //异步绘制裁切
        DispatchQueue.global().async {
            //利用绘图建立上下文
            UIGraphicsBeginImageContextWithOptions(size, true, 0)

            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            //设置填充颜色
            fillColor.setFill()
            UIRectFill(rect)

            //利用贝塞尔路径裁切
            let path = UIBezierPath.init(roundedRect: rect, cornerRadius: radius)
            path.addClip()

            self.draw(in: rect)

            //获取结果
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()

            //关闭上下文
            UIGraphicsEndImageContext()

            //主队列回调
            DispatchQueue.main.async {
                completion(resultImage!)
            }
        }
    }
}

