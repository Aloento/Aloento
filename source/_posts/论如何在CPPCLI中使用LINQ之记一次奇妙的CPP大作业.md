---
title: 论如何在C++/CLI中使用LINQ：记一次奇妙的C++大作业
date: 2021-12-03 15:15:37
toc: true
categories:
  - [Program, C++, CLI]
  - [Diary]
tags: [编程, C++, CLI, LINQ, C#, .NET, OrderBy, 笔记]
---

```txt
“救我，你一定要救我啊！” 我的同学对我如是说
“¿”
“C++要考试了！我整不来啊，我感觉挺简单的题”
“......”
“请你吃顿饭”
“彳亍”
```

然后我就收到了这么两道题目：

<!-- more -->

### 准备

---

#### 生成 20 个可被 2 或 5 整除，介于 1 至 100 之间的无重复随机数

> Write a program (in C++) that generates and calculates 20 different random numbers that can be divided by 2 or 5. Random numbers must be generated from 1 to 200,the same number cannot be included in the array! The random number generation should be written in a function, i.e. the return value of the function should be an array!

#### 随机产生 50 个人的工资表，并列出平均、最高低工资

> Given a list in which the wages of 50 people are stored (in EUR). Write a program (in C++) that determines what the average wage is, who has the highest wage, who has the lowest wage, and who has the wages below average.

---

乍一看感觉这题确实就是初学者的题目，不过如果我使用普通的方法完成这题  
就不能称之为 “奇妙” 的大作业了，所以在犹豫一阵后我决定，使用 `C++/CLI` 来完成  
_~~顺带再期待一下老师如果看到一堆 `CLI` 代码会作何反应（~~_

#### 什么是 `C++/CLI`

`C++/CLI` 是 `C++` 的扩展，让我们可以同时享受 `C#` 和 `C++` 的特性，是微软的  
就我个人而言，如果能用 `C++/CLI` 的话那我绝对不会用传统的 `C++`  
而且这玩意据我了解在中国没多少人用，或者说老外也不怎么用  
因为这玩意不上不下的，说实话 `C#` 的 `unsafe` 已经足够了

而且就目前为止，它仍然不能跨平台，`Core` 以后也无法生成独立程序了 _~~寄~~_

> There isn’t currently a template for C++/CLI console or Windows applications that can be used with .NET Core.
> Instead you must put application entry point outside of the C++/CLI code.

所以作业是用 `.NET Framework`，不过本文使用 `.NET Core`  
所以查个资料，学习起来着实有点费力，以后有空可以专门讲讲

在撰写这篇文章时我目前心目中的优先级：  
`C#` > `Go` > `Rust` > `C++/CLI` > `TS` > `Java` > `Python` > `JS` > `C++` > `C`  
_~~一天到晚只想用托管类语言的我已经是个废物了~~_

话费不多的请直接跳到文章最后看结果  
接下来我会一点点讲述我的心路历程

---

### 做题

---

#### 准备项目

- 用 `VS 2022` 创建一个新的 `C# .NET Core` 解决方案
- 在解决方案中添加一个 `C++/CLI .NET Core` **类库**项目

这里如果使用空白项目的话需要自己配置很多东西  
而且微软对 `C++/CLI` 的支持是越来越不好了  
**注意**：`CLI` 项目更改以后需要**生成**一下才能在 `C#` 中看到变化

---

#### Func: `GetRandoms`

首先我们来实现生成随机数的函数  
既然两个题目都要求了随机数的产生  
那么我们就专门做一个函数出来复用

尽可能多的复用我认为是一件非常好的习惯  
无论是在写代码，还是在生活中

##### 函数定义

```cpp
using namespace System;
using namespace Collections::Generic;

namespace Aloento::CLILinq {
	public ref class CLILinq {
	public:
	  static List<int>^ GetRandoms(int min, int max, int num) {
		  return nullptr;
	  }
};
```

这就是我的格式习惯，一股子 `Java` 味  
让我们来分析一下这个代码

- 这是在一个 `.h` 头文件里面的代码
- 声明函数的写法就是传统的 `C++`
- `namespace` 和 `using` 都和 `C#` 一样，只不过把 `.` 变成 `::`
- `public` 是为了让 `C#` 可以访问
- `ref` 表明这是一个托管类
- `static` 在我这里是 `Helper` 的统一写法
- `List<int>^` 返回一个 **托管的 ^** `List<int>` 类型

托管类型都是从 `C#` 来的  
用 `C++/CLI` 托管的代码可以无缝在 `C#` 中使用，反之亦然

---

##### 基本功能

```cpp
static List<int>^ GetRandoms(int min, int max, int num) {
	auto random = Random::Shared;
	auto res = gcnew List<int>(num);

	for (auto i = 0; i < num;) {
		auto r = random->Next(min, max);
		if (!res->Contains(r) && (r % 2 == 0 || r % 5 == 0)) {
			i++;
			res->Add(r);
		}
	}

	return res;
}
```

- `Random::Shared` 说明了我们现在在使用 **.NET Core**
- `gcnew` 表明了我们要生成一个 **托管的** 对象
- `if` 语句用来排除重复的随机数，并且确保是 2 和 5 的倍数
- `i++` 表明我们已经得到了目标，所以我们要让 `i` 加一，不可以让 for 语句来完成

至此，有一些编程基础的都应该轻松看懂  
除了一些 `CLI` 的独特语法以外，其余的和传统 `C++` / `C#` 并无太大区别

---

##### 数据验证

我们写代码的时候还是不要过于相信用户会按照你的想法来使用它  
毕竟 _~~一个测试工程师走进一家酒吧，啥也没干酒吧就炸了~~_

所以我们简单的加一句：

```cpp
if (max / 2 + max / 5 - (min / 2 + min / 5) < num)
	throw gcnew ArgumentOutOfRangeException();
```

这里我没有写具体的说明，不过正式写代码的时候，报错一定要**写清楚原因**

---

##### 完全体

```cpp
#pragma once
using namespace System;
using namespace Collections::Generic;

namespace Aloento::CLILinq {
	public ref class CLILinq sealed {
	public:
		static List<int>^ GetRandoms(const int min, const int max, const int num) {
			if (max / 2 + max / 5 - (min / 2 + min / 5) < num) {
				throw gcnew ArgumentOutOfRangeException();
			}

			auto random = Random::Shared;
			auto res = gcnew List<int>(num);

			for (auto i = 0; i < num;) {
				auto r = random->Next(min, max);
				if (!res->Contains(r) && (r % 2 == 0 || r % 5 == 0)) {
					i++;
					res->Add(r);
				}
			}

			return res;
		}
	};
}
```

---

#### Func: `GetWagesList`

我是把两道题一起做的，所以在这个 `CLILinq` 类里应该还有第二题的方法  
这个方法用来产生一些随机的 <Name:Wages> 键值对  
由于时间关系，我们这里生成的名字就直接按 `ASCII` 取了

```cpp
static Dictionary<Char, double>^ GetWagesList() {
	auto random = Random::Shared;
	auto dictionary = gcnew Dictionary<Char, double>();
	Char c = 65;

	for (auto i = 0; i < 50; i++) {
		auto wage = random->NextDouble() * 1000;
		dictionary->Add(c++, wage);
	}

	return dictionary;
}
```

因为比较简单，所以直接上代码  
这里不用 `char` 而是 `Char`，这样可以直接被 `C#` 转字符串，方便输出

---

#### 调用：第一题

第一题的调用比较无脑，直接用就行了

```cpp
static void Invoke() {
	auto randomList = GetRandoms(1, 200, 20);
	for each (auto num in randomList) {
		Console::WriteLine(num);
	}
}
```

---

#### LINQ：第二题

第二题的实际逻辑就在这里  
也是 `LINQ` 出场的地方 _（原谅我前面瞎扯了那么多）_

我们先看实现代码

```cpp
static void Invoke() {
	auto wageDic = GetWagesList();
	auto v = wageDic->Values;

	double sum = 0;
	for each (auto num in v) {
		sum += num;
	}
	auto avg = sum / 50;

	auto c = System::Globalization::CultureInfo::CultureInfo::CreateSpecificCulture("eu-ES");
	Console::WriteLine("Average: " + avg.ToString("C", c) + "\n");

	auto ordered = Enumerable::OrderBy(wageDic, gcnew Func<KeyValuePair<Char, double>, double>(Select));
	for each (auto one in ordered) {
		Console::WriteLine(one.Key + ": " + one.Value.ToString("C", c));
	}
}
```

`for each (auto num in v)` 这部分其实就是 `Enumerable.Aggregate` 的简单实现  
毕竟要交作业，不能写的那么高级 _~~（其实是嫌麻烦）~~_

`CultureInfo` 就是设置个格式化区域，这里转成欧洲的货币格式  
`avg.ToString("C", c)` 就是把 `avg` 转成 `Currency`

##### LINQ

接下来就是 `Enumerable.OrderBy` 的实现  
为了搞懂如何传入这个方法需要的参数，我搞了一个多小时到处找资料和 debug...

由于 `C++ 11` 之前就没有 `lambda` 表达式，后面有了也非常奇怪  
所以 `LINQ` 压根就没有提供类似的调用方式  
所以我们必须使用 `gcnew Func()` 的方式传递一个委托

---

首先，我们必须清楚 `Func` 的泛型类型到底是什么  
`C++/CLI` 在这里 `IDE` 是完全没有代码提示的，所以我们需要自行分析  
最好的方式就是在 `C#` 里面写同样的代码，然后看它们的类型

在这里，`Dictionary<Char, double>` 的单个元素的类型是 `KeyValuePair<Char, double>`  
所以很显然我们需要 `Func<KeyValuePair<Char, double>, double>`  
现在我们就有了它的类型，然后我们需要实现这个委托

---

这个委托是一个选择器，它的作用是从类型中选择出一个对象来作为排序的依据  
在我们这里，就是要从 `KeyValuePair` 中把 `Value` 选出来

随后就有了以下代码

```cpp
static double Select(KeyValuePair<Char, double> a) {
	return a.Value;
}
```

非常简单，在特定情况下，你也可以尝试直接内联它  
之后的事情就非常简单了，该调用调用，该输出输出

---

### 实际上

先贴一堆代码，可以粗略看看

```cs
namespace Aloento.SCLILinq;
using System.Globalization;

public sealed class SCLILinq {
    public static List<int> GetRandoms(int min, int max, int num) {
        Random random = null;
        List<int> list = null;
        if (max / 2 + max / 5 - (min / 2 + min / 5) < num) {
            throw new ArgumentOutOfRangeException();
        }

        random = Random.Shared;
        list = new List<int>(num);
        int num2 = 0;
        while (num2 < num) {
            int num3 = random.Next(min, max);
            if (!list.Contains(num3) && (num3 % 2 == 0 || num3 % 5 == 0)) {
                num2++;
                list.Add(num3);
            }
        }

        return list;
    }

    public static Dictionary<char, double> GetWagesList() {
        Random random = null;
        Dictionary<char, double> dictionary = null;
        random = Random.Shared;
        dictionary = new Dictionary<char, double>();
        char c = 'A';
        for (int i = 0; i < 50; i++) {
            double value = random.NextDouble() * 1000.0;
            char key = c;
            c = (char)(c + 1);
            dictionary.Add(key, value);
        }

        return dictionary;
    }

    public static double Select(KeyValuePair<char, double> a) {
        return a.Value;
    }

    public static void Invoke() {
        List<int> list = null;
        Dictionary<char, double> dictionary = null;
        Dictionary<char, double>.ValueCollection valueCollection = null;
        CultureInfo cultureInfo = null;
        IOrderedEnumerable<KeyValuePair<char, double>> orderedEnumerable = null;
        IEnumerator<KeyValuePair<char, double>> enumerator = null;
        list = GetRandoms(1, 200, 20);
        List<int>.Enumerator enumerator2 = list.GetEnumerator();
        while (enumerator2.MoveNext()) {
            int current = enumerator2.Current;
            Console.WriteLine(current);
        }

        Console.WriteLine("\n-------------------------------\n");
        dictionary = GetWagesList();
        valueCollection = dictionary.Values;
        double num = 0.0;
        Dictionary<char, double>.ValueCollection.Enumerator enumerator3 = valueCollection.GetEnumerator();
        while (enumerator3.MoveNext()) {
            double current2 = enumerator3.Current;
            num += current2;
        }

        double num2 = num / 50.0;
        cultureInfo = CultureInfo.CreateSpecificCulture("eu-ES");
        string str = "\n";
        double num3 = num2;
        string str2 = num3.ToString("C", cultureInfo);
        Console.WriteLine(string.Concat("Average: " + str2, str));
        orderedEnumerable = Enumerable.OrderBy(dictionary, new Func<KeyValuePair<char, double>, double>(Select));
        enumerator = orderedEnumerable.GetEnumerator();
        try {
            while (enumerator.MoveNext()) {
                KeyValuePair<char, double> current3 = enumerator.Current;
                double value = current3.Value;
                string format = "C";
                string str3 = value.ToString(format, cultureInfo);
                string arg = ": ";
                Console.WriteLine(string.Concat(current3.Key + arg, str3));
            }
        } finally {
            IEnumerator<KeyValuePair<char, double>> enumerator4 = enumerator;
            if (enumerator4 != null) {
                enumerator4.Dispose();
                long num4 = 0L;
            } else {
                long num4 = 0L;
            }
        }
    }
}
```

这是直接对 `C++/CLI` 生成的库反编译的结果  
我们可以发现，这就相当于是写了一堆 `C#` 而已  
如果带指针之类的，就是 `unsafe`  
所以：没必要，别用 `C++/CLI`

---

#### 适用范围

- 如果你想 Wrapper 一个 `C / C++` 的库给 `C#` 用
- 如果你想让 `.NET` 与其他语言一起工作
- 让 `C++` 享受 `.NET` 的生态
- 如果你闲得慌想找点事情干

在大部分情况下，`C++/CLI` 的存在  
都是为了高效的让 `C#` 与 `C / C++` 交互而使用  
使用它可以让你的 `.NET `项目享受到 `C++` 全套的生态，反之亦然  
毕竟 `P/Invoke` 并不优雅

在托管类语言中，`C++/CLI` 在一定程度上  
让 `C#` 成了最容易与 `C / C++` 交互的语言  
进而让它也更容易与能够和 `C / C++` 交互的语言交互

使用它，你需要同时掌握 `C#` 和 `C++`  
而且在很多时候，`IDE` 不会给你有效的提示  
所以学习它需要很多时间来尝试

---

### 结论

```cpp
using namespace System;
using namespace Linq;
using namespace Collections::Generic;

namespace Aloento::CLILinq {
	public ref class CLILinq sealed {
	public:
		static List<int>^ GetRandoms(const int min, const int max, const int num) {
			if (max / 2 + max / 5 - (min / 2 + min / 5) < num) {
				throw gcnew ArgumentOutOfRangeException();
			}

			auto random = Random::Shared;
			auto res = gcnew List<int>(num);

			for (auto i = 0; i < num;) {
				auto r = random->Next(min, max);
				if (!res->Contains(r) && (r % 2 == 0 || r % 5 == 0)) {
					i++;
					res->Add(r);
				}
			}

			return res;
		}

		static Dictionary<Char, double>^ GetWagesList() {
			auto random = Random::Shared;
			auto dictionary = gcnew Dictionary<Char, double>();
			Char c = 65;

			for (auto i = 0; i < 50; i++) {
				auto wage = random->NextDouble() * 1000;
				dictionary->Add(c++, wage);
			}

			return dictionary;
		}

		static double Select(KeyValuePair<Char, double> a) {
			return a.Value;
		}

		static void Invoke() {
			auto randomList = GetRandoms(1, 200, 20);
			for each (auto num in randomList) {
				Console::WriteLine(num);
			}

			Console::WriteLine("\n-------------------------------\n");

			auto wageDic = GetWagesList();
			auto v = wageDic->Values;

			double sum = 0;
			for each (auto num in v) {
				sum += num;
			}
			auto avg = sum / 50;

			auto c = System::Globalization::CultureInfo::CultureInfo::CreateSpecificCulture("eu-ES");
			Console::WriteLine("Average: " + avg.ToString("C", c) + "\n");

			auto ordered = Enumerable::OrderBy(wageDic, gcnew Func<KeyValuePair<Char, double>, double>(Select));
			for each (auto one in ordered) {
				Console::WriteLine(one.Key + ": " + one.Value.ToString("C", c));
			}
		}
	};
}
```

---
