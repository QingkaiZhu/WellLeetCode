#
# @lc app=leetcode id=69 lang=python3
#
# [69] Sqrt(x)
#
# Tags: math, newton-raphson-method

'''
Newton's method:
https://personal.math.ubc.ca/~anstee/math104/newtonmethod.pdf

We want to find the square root of x, thus define the function as
f(y) = y^2 -x = 0
f'(y) = 2y
From this image
https://media.geeksforgeeks.org/wp-content/uploads/20230704172946/Newton-Raphson-Method.png

delta_y = y1 - y0 = y_next - y_current
Tangent = f'(y0) = f(y0) / delta_y, thus delta_y = f(y_current) / f'(y_current)
y_next = y_current - delta_y
       = y_current - f(y_current) / f'(y_current)
       = y_current - f(y_current) / 2y_current
For simplicity, let's use y to represent y_current

y_next = y - f(y) / 2y
       = y - (y^2 - x) / 2y
       = y - y / 2 + x / 2y
       = y / 2 +  x / 2y
'''
# @lc code=start
class Solution:
    def mySqrt(self, x: int) -> int:
        if x < 2:
            return x
        res = x // 2
        while res * res > x:
            res = res / 2 + x / (2 * res)
            res = int(res)
        return res
# @lc code=end

