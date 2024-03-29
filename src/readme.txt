#详细步骤
一.HOG（Histogram of Oriented Gradients）方向梯度直方图
1、首先把图片灰度化，因为颜色对人脸检测没用
2、分析每个像素以及其周围的像素，根据明暗度画一个箭头，箭头的指向代表了像素逐渐变暗的方向，如果我们重复操作每一个像素，最终像素会被箭头取代。这些箭头被称为梯度(gradients)，它们能显示出图像从明亮到黑暗流动的过程。
3、我们将图像分割成16x16像素的小方块。在每个小方块中，计算出每个主方向有多少个剃度（有多少指向上，指向右上，指向右等）。然后用指向性最强的那个方向箭头来代替原来那个小方块。


二.面部特征点估计（face landmark estimation）的算法
1、这一算法的基本思路是找到68个人脸上普遍存在的点（称为特征点， landmark）。
2、有了这68个点，我们就可以轻松的知道眼睛和嘴巴在哪儿了，后续我们将图片进行旋转，缩放和错切，使得眼睛和嘴巴尽可能的靠近中心。


三.我们还有个核心的问题没有解决， 那就是如何区分不同的人脸。
最简单的方法就是把我们第二步中发现的未知人脸与我们已知的人脸作对比。当我们发现未知的面孔与一个以前标注过的面孔看起来相似的时候，就可以认定他们是同一个人。
    训练一个深度卷积神经网络，训练让它为脸部生成128个测量值。每次训练要观察三个不同的脸部图像：
         加载一张已知的人的面部训练图像
         加载同一个人的另一张照片
         加载另外一个人的照片
然后，算法查看它自己为这三个图片生成的测量值。再然后，稍微调整神经网络，以确保第一张和第二张生成的测量值接近，而第二张和第三张生成的测量值略有不同。我们要不断的调整样本，重复以上步骤百万次。


四.最后一步要做的就是：找到数据库中与我们的测试图像的测量值最接近的那个人。
如何做呢，我们利用一些现成的数学公式，计算两个128D数值的欧氏距离。
这样我们得到一个欧式距离值，然后我们给它一个认为是同一个人欧氏距离的阀值，即超过这个阀值我们就认定他们是 同 (失) 一 (散) 个 (兄) 人 (弟)。
