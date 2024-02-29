---
title: Morgan Stanley 的面试题
date: 2024-02-29 10:00:00
toc: true
categories:
  - [Program]
tags: [编程, Java, Python, C++, 面试]
---

~~TMD，跟资本拼了~~

卷入资本的大潮  
踩在浪尖上的就是巅峰  
踩不上的就卷到大海里  
走上人生巅峰了属于是

<!-- more -->

摩根士丹利在我们学校招聘，提供了一些公开的习题，我也来做做看

# Java

## Filter

```java
import hava.util.stream.Stream;

class Main {
  public static void main(String[] args) {
    Stream<String> stream = Stream.of(
      "Morgan", "Stanley", "Investment", "Managment"
    );

    stream.filter(
      str -> "AEIOU".indexOf(Character.toUpperCase(str.charAt(0))) != -1)
      .forEach(System.out::println);
  }
}
```

## OOP

```java
abstract class Animal {
  public void sound() {
    System.out.println("sound ");
  }
}

class Dog extends Animal {
  public void sound() {
    super.sound();
  }
}

class SleepingDog extends Dog {
  public void sound() {
    System.out.println("silence ");
  }
}

class Main {
  public static void main(String[] args) {
    Animal rex = new Dog();
    Animal spike = new SleepingDog();

    rex.sound();
    System.out.println("of ");
    spike.sound();
  }
}
```

## Recursive

```java
public class Main extends Thread {
  public static int result = 1;

  private int n;
  Main(int x) {
    n = x;
  }

  public void fac() {
    if (n <= 1) {
      result *= 1;
      return;
    }

    result *= n;
    Main thread = new Main(n - 1);
    thread.start();
  }

  public void run() {
    fac();
  }

  public static void main(String[] args) throws InterruptedException {
    Main thread = new Main(5);
    thread.fac();
    System.out.println(result);
  }
}
```

## Concept

1. You can define static functions outside classes.
2. There are 4 different access modifiers in Java.
3. A Java class can extend multiple classes.
4. A Java interface can extend multiple interfaces.

| Type    | Size  |
| ------- | ----- |
| byte    | 1 bit |
| boolean | 1 bit |
| char    | 2 bit |
| int     | 4 bit |
| double  | 8 bit |

# Python

## Syntax

1. `[] * 42`
2. `[_ for _ in range(66) if not _]`
3. `[[i for i in range(2)] if i is 1]`
4. `['Why?' for why in ['Yes', 'Indeed', 'Sure']]`

## For

```python
for i in range(1, 3):
  if not i % 3:
    print("Found: ", i, end=', ')
    break
  else:
    pass
else:
  print("Invalid", end=', ')
```

## Equality

```python
str1 = "equality in Python".upper()
str2 = "EQUALITY IN PYTHON"
print(str1 == str2, str1.__eq__(str2), str1 is str2)
```

## OOP

```python
class A:
  def a(self):
    return 'a'
  def b(self):
    return 'b'

d = dir(A())

for fun in d:
  if not fun.startswith('__'):
    result = getattr(A(), fun)()
    print(result, end='')
```

## Numpy

```python
import numpy as np
a = np.array([[1, 2], [3, 4]])
print(int(np.linalg.det(a)))
```

# C++

## Size

How many bits in a C++ byte?

4 / 8 / 8+ / depends on system

## Flush

Which of the following will flush the output buffer?

1. `std::cout << "Please flush!" << '\n';`
2. `std::cout << "Please flush!" << std::endl;`
3. `std::cout << "Please flush!" << std::flush;`
4. `printf("Please flush!");`

## Pointer

```cpp
int arr[3] = {1, 2, 3};
int *p = arr;
std::cout << *p++ << " " << * p << std::endl;
```

## Virtual

1. The member function to call is resolved at compile time based on the type of the pointer or reference to the object.
2. The member function to call is resolved at runtime time based on the type of the pointer or reference to the the object.
3. The member function to call is resolved at runtime time based on the type of object
   (not the pointer or reference to the object), by checking the v-table realted to the object instance.
4. The member function to call is resolved at runtime time based on the type of object
   (not the pointer or reference to the object), by checking the v-table associated with the object class.
