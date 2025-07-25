#
# @lc app=leetcode id=69 lang=python3
#
# [69] Sqrt(x)
#
# Tags: math, binary-search

'''
Binary search
'''
# @lc code=start
class Solution:
    def mySqrt(self, x: int) -> int:
        if x < 2:
            return x
        # We use high to store the result, and the result is always less than x//2
        low, high = 1, x//2
        while low <= high:
            mid = (low + high) // 2
            square = mid * mid
            if square == x:
                return mid
            elif square < x:
                low = mid + 1
            else:
                high = mid - 1
        return high
        
# @lc code=end

