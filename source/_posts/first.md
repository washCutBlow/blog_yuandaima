title: '算法1[斗牛]'
date: 2016-08-31 21:55:59
tags:
categories: go算法
---
go语言实现斗牛
<!-- more -->
```
// 5张牌为一手牌，定义一手牌结构体
type hands [5] int
// 将T字符和花牌进行牌点值的转换
func (h *hands) transfer2SingleChar()  {
	for i:=0;i<5 ;i++  {
		if h[i] == 84/*'T'*/ || h[i] == 74/*'J'*/ || h[i] == 81/*'Q'*/ || h[i] == 75/*'K'*/ {
			h[i] = 10
		}
		if h[i] == 65/*'A'*/ {
			h[i] = 1 // 设A的值为1
		}
	}
}
// 把5张牌分成两部分，第一部分表示是否含有牛、第二部分是剩余的两张副牌的和对10的模值
// 如果第一部分返回true 说明有牛，如果第二部分返回 0 说明是牛牛
//
func (h *hands) cutTwoPart() (bool,int)  {
	total := h[0]+h[1]+h[2]+h[3]+h[4]
	if total%10 == 0 {
		return true,0	// 牛牛
	}

	for i:=0; i<5; i++ {
		for j:=i+1;j<5;j++ {
			fupai:= h[i]+h[j]
			if (total-fupai)%10 == 0 {
				return true,fupai%10
			}
		}
	}
	return false,-1	// 当没有牛时，第二个参数可以随便返回，反正我们不关心
}
// 如果两手牌都没有牛就比较大小
func compareWithoutNiu(h1,h2 hands) int {
	sort.Ints(h1[0:])
	sort.Ints(h2[0:])
	for i:=4;i>=0;i-- { // 从最大的牌开始比较
		if h1[i]>h2[i] {
			return 1
		} else if h1[i]<h2[i] {
			return -1
		} else {
			continue
		}
	}
	return 0	// 表示相等
}

func Niu(h1,h2 hands) int {
	// 首先对输入牌点进行转换
	h1.transfer2SingleChar()
	h2.transfer2SingleChar()
	// 判断是否有牛和副牌之和
	niu1,fu1 := h1.cutTwoPart()
	niu2,fu2 := h2.cutTwoPart()
	// 比较大小
	// 如果都有牛
	if niu1 && niu2 {
		if fu1==0 && fu2==0 { // 都是牛牛
			return 0
		}
		if fu1==0 {
			return 1
		}
		if fu2==0 {
			return -1
		}
		if fu1 > fu2 {
			return 1
		} else if fu1 < fu2 {
			return  -1
		} else {
			return 0
		}
	}
	// 1有牛 2没牛
	if niu1 && !niu2 {
		return 1
	}
	// 1没牛 2有牛
	if !niu1 && niu2 {
		return -1
	}


	// 如果没有牛，进行常规比较
	return compareWithoutNiu(h1,h2)
}
```

