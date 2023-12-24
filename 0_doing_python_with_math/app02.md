[]{#page_221}**[B]{.big}** **Overview of Python Topics** {#app02 .h2}
--------------------------------------------------------

::: {.image1}
![image](graphics/common-01.jpg)
:::

The aim of this appendix is twofold: to provide a quick refresher on
some Python topics that weren't thoroughly introduced in the chapters
and to introduce topics that will help you write better Python programs.

### **if \_\_name\_\_ == \'\_\_main\_\_\'** {#app02lev1sec01 .h3}

Throughout the book, we've used the following block of code, where
[func()]{.literal} is a function we've defined in the program:

if \_\_name\_\_ == \'\_\_main\_\_\':\
    \# Do something\
    func()

This block of code ensures that the statements within the block are
executed only when the program is run on its own.

[]{#page_222}When a program runs, the special variable
[\_\_name\_\_]{.literal} is set to [\_\_main\_\_]{.literal}
automatically, so the [if]{.literal} condition evaluates to
[True]{.literal} and the function [func()]{.literal} is called. However,
[\_\_name\_\_]{.literal} is set differently when you import the program
into another program (see "[Reusing Code](app02.html#app02lev1sec07)" on
[page 235](app02.html#page_235)).

Here's a quick demonstration. Consider the following program, which
we'll call *factorial.py*:

   \# Find the factorial of a number\
   def fact(n):\
       p = 1\
       for i in range(1, n+1):\
           p = p\*i\
       return p\
\
[➊]{.ent} print(\_\_name\_\_)\
\
   if \_\_name\_\_ == \'\_\_main\_\_\':\
       n = int(input(\'Enter an integer to find the factorial of: \'))\
       f = fact(n)\
       print(\'Factorial of {0}: {1}\'.format(n, f))

The program defines a function, [fact()]{.literal}, that calculates the
factorial of the integer passed to it. When you run it, it prints
[\_\_main\_\_]{.literal}, which corresponds to the [print]{.literal}
statement at [➊]{.ent}, because [\_\_name\_\_]{.literal} is
automatically set to [\_\_main\_\_]{.literal}. Then, it asks an integer
to be entered, calculates the factorial, and prints it:

\_\_main\_\_\
Enter an integer to find the factorial of: 5\
Factorial of 5: 120

Now, say you need to calculate the factorial in another program. Instead
of writing the function again, you decide to reuse this function by
importing it:

from factorial import fact\
if \_\_name\_\_ == \'\_\_main\_\_\':\
    print(\'Factorial of 5: {0}\'.format(fact(5)))

Note that both the programs must be in the same directory. When you run
this program, you'll get the following output:

factorial\
Factorial of 5: 120

When your program is imported by another program, the value of the
variable [\_\_main\_\_]{.literal} is set to that program's filename,
without the extension. In this case, the value of
[\_\_name\_\_]{.literal} is [factorial]{.literal} instead of
[\_\_main\_\_]{.literal}. Because the condition [\_\_name\_\_ ==
\'\_\_main\_\_\']{.literal} now evaluates to [False]{.literal}, the
program doesn't ask for the user's input anymore. Remove the condition
to see for yourself what happens!

[]{#page_223}To summarize, it's good practice to use [if \_\_name\_\_ ==
\'\_\_main\_\_\']{.literal} in your programs so that the statements you
want executed when your program is run as a standalone are also *not*
executed when your program is imported into another program.

### **List Comprehensions** {#app02lev1sec02 .h3}

Let's say we have a list of integers and we want to create a new list
containing the squares of the elements of the original list. Here's one
way that we could do this that's already familiar to you:

   \>\>\> [x = \[1, 2, 3, 4\]]{.codestrong}\
   \>\>\> [x\_square = \[\]]{.codestrong}\
[➊]{.ent} \>\>\> [for n in x:]{.codestrong}\
[➋]{.ent}         [x\_square.append(n\*\*2)]{.codestrong}\
   \>\>\> [x\_square]{.codestrong}\
   \[1, 4, 9, 16\]

Here, we used a code pattern that we've used in various programs
throughout the book. We create an empty list, [x\_square]{.literal}, and
then successively append to it as we calculate the square. We can do
this in a more efficient way using *list comprehensions*:

[➌]{.ent} \>\>\> [x\_square = \[n\*\*2 for n in x\]]{.codestrong}\
   \>\>\> [x\_square]{.codestrong}\
   \[1, 4, 9, 16\]

The statement at [➌]{.ent} is referred to as a *list comprehension* in
Python. It consists of an expression---here,
[n\*\*2]{.literal}---followed by a [for]{.literal} loop, [for n in
x]{.literal}. Note that it basically allows us to combine the two
statements at [➊]{.ent} and [➋]{.ent} into one to create a new list in
one statement.

As another example, consider one of the programs we wrote in "[Drawing
the Trajectory](ch02.html#ch02lev3sec05)" on [page
51](ch02.html#page_51) to draw the trajectory of a body in projectile
motion. In these programs, we have the following block of code to
calculate the *x*- and *y*-coordinates of the body at each time instant:

\# Find time intervals\
intervals = frange(0, t\_flight, 0.001)\
\# List of x and y coordinates\
x = \[\]\
y = \[\]\
for t in intervals:\
    x.append(u\*math.cos(theta)\*t)\
    y.append(u\*math.sin(theta)\*t - 0.5\*g\*t\*t)

Using list comprehension, you can rewrite the block of code as follows:

\# Find time intervals\
intervals = frange(0, t\_flight, 0.001)\
\# List of x and y coordinates\
[]{#page_224}\
x = \[u\*math.cos(theta)\*t for t in intervals\]\
y = \[u\*math.sin(theta)\*t - 0.5\*g\*t\*t for t in intervals\]

The code is more compact now, as you didn't have to create the empty
lists, write a [for]{.literal} loop, and append to the lists. List
comprehension lets you do this in a single statement.

You can also add conditionals to a list comprehension in order to
selectively choose which list items are evaluated in the expression.
Consider, once again, the first example:

\>\>\> [x = \[1, 2, 3, 4\]]{.codestrong}\
\>\>\> [x\_square = \[n\*\*2 for n in x if n%2 == 0\]]{.codestrong}\
\>\>\> [x\_square]{.codestrong}\
\[4, 16\]

In this list comprehension, we use the [if]{.literal} condition to
explicitly tell Python to evaluate the expression [n\*\*2]{.literal}
only on the even list items of [x]{.literal}.

### **Dictionary Data Structure** {#app02lev1sec03 .h3}

We first used a Python dictionary in [Chapter 4](ch04.html#ch04) while
implementing the [subs()]{.literal} method in SymPy. Let's explore
Python dictionaries in more detail. Consider a simple dictionary:

\>\>\> [d = {\'key1\': 5, \'key2\': 20}]{.codestrong}

This code creates a dictionary with two keys---[\'key1\']{.literal} and
[\'key2\']{.literal}---with values [5]{.literal} and [20]{.literal},
respectively. Only strings, numbers, and tuples can be keys in a Python
dictionary. These data types are referred to as *immutable* data
types---once created, they can't be changed---so a list can't be a key
because we can add and remove elements from a list.

We already know that to retrieve the value corresponding to
[\'key1\']{.literal} in the dictionary, we need to specify it as
[d\[\'key1\'\]]{.literal}. This is one of the most common use cases of a
dictionary. A related use case is checking whether the dictionary
contains a certain key, [\'x\']{.literal}. We can check that as follows:

\>\>\> [d = {\'key1\': 5, \'key2\': 20}]{.codestrong}\
\>\>\> [\'x\' in d]{.codestrong}\
False

Once we create a dictionary, we can add a new key-value pair to it,
similar to how we can append elements to a list. Here's an example:

\>\>\> [d = {\'key1\': 5, \'key2\': 20}]{.codestrong}\
\>\>\> [if \'x\' in d:]{.codestrong}\
        [print(d\[\'x\'\])]{.codestrong}\
[else:]{.codestrong}\
        [d\[\'x\'\] = 1]{.codestrong}\
[]{#page_225}\
\>\>\> [d]{.codestrong}\
{\'key1\': 5, \'x\': 1, \'key2\': 20}

This code snippet checks whether the key [\'x\']{.literal} already
exists in the dictionary, [d]{.literal}. If it does, it prints the value
corresponding to it; otherwise, it adds the key to the dictionary with
[1]{.literal} as the corresponding value. Similar to Python's behavior
with sets, Python can't guarantee a particular order of the key-value
pairs in a dictionary. The key-value pairs can be in any order,
irrespective of the order of insertion.

Besides specifying the key as an index to the dictionary, we can also
use the [get()]{.literal} method to retrieve the value corresponding to
the key:

\>\>\> [d.get(\'x\')]{.codestrong}\
1

If you specify a nonexistent key to the [get()]{.literal} method,
[None]{.literal} is returned. On the other hand, if you do so while
using the index style of retrieving, you'll get an error.

The [get()]{.literal} method also lets you set a default value for
nonexistent keys:

\>\>\> [d.get(\'y\', 0)]{.codestrong}\
0

There's no key [\'y\']{.literal} in the dictionary [d]{.literal}, so
[0]{.literal} is returned. If there is a key, however, the value is
returned instead:

\>\>\> [d\[\'y\'\] = 1]{.codestrong}\
\>\>\> [d.get(\'y\', 0)]{.codestrong}\
1

The [keys()]{.literal} and [values()]{.literal} methods each return a
list-like data structure of all the keys and values, respectively, in a
dictionary:

\>\>\> [d.keys()]{.codestrong}\
dict\_keys(\[\'key1\', \'x\', \'key2\', \'y\'\])\
\>\>\> [d.values()]{.codestrong}\
dict\_values(\[5, 1, 20, 1\])

To iterate over the key and value pairs in a dictionary, use the
[items()]{.literal} method:

\>\>\> [d.items()]{.codestrong}\
dict\_items(\[(\'key1\', 5), (\'x\', 1), (\'key2\', 20), (\'y\', 1)\])

This method returns a *view* of tuples, and each tuple is a key-value
pair. We can use the following code snippet to print them nicely:

\>\>\> [for k, v in d.items():]{.codestrong}\
        [print(k, v)]{.codestrong}\
[]{#page_226}\
key1 5\
x 1\
key2 20\
y 1

Views are more memory efficient than lists, and they don't let you add
or remove items.

### **Multiple Return Values** {#app02lev1sec04 .h3}

In the programs we've written so far, most of the functions return a
single value, but functions sometimes return multiple values. We saw an
example of such a function in "[Measuring the
Dispersion](ch03.html#ch03lev1sec04)" on [page 71](ch03.html#page_71),
where in the program to find the range, we returned three numbers from
the [find\_range()]{.literal} function. Here's another example of the
approach we took there:

import math\
def components(u, theta):\
    x = u\*math.cos(theta)\
    y = u\*math.sin(theta)\
    return x, y

The [components()]{.literal} function accepts a velocity, [u]{.literal},
and an angle, [theta]{.literal}, in radians as parameters, and it
calculates the [x]{.literal} and [y]{.literal} components and returns
them. To return the calculated components, we simply list the
corresponding Python labels in the return statement separated by a
comma. This creates and returns a tuple consisting of the items
[x]{.literal} and [y]{.literal}. In the calling code, we receive the
multiple values:

if \_\_name\_\_ == \'\_\_main\_\_\':\
    theta = math.radians(45)\
    x, y = components(theta)

Because the [components()]{.literal} function returns a tuple, we can
retrieve the returned values using tuple indices:

c = components(theta)\
x = c\[0\]\
y = c\[1\]

This has advantages because we don't have to know all the different
values being returned. For one, you don't have to write [x,y,z =
myfunc1()]{.literal} when the function returns three values or [a,x,y,z
= myfunc1()]{.literal} when the function returns four values, and so on.

In either of the preceding cases, the code calling the
[components()]{.literal} function must know which of the return values
correspond to which component of the velocity, as there's no way to know
that from the values themselves.

[]{#page_227}A user-friendly approach is to return a dictionary object
instead, as we saw in the case of SymPy's [solve()]{.literal} function
when used with the [dict=True]{.literal} keyword argument. Here's how we
can rewrite the preceding components function to return a dictionary:

import math\
\
def components(theta):\
    x = math.cos(theta)\
    y = math.sin(theta)\
\
    return {\'x\': x, \'y\': y}

Here, we return a dictionary with the keys [\'x\']{.literal} and
[\'y\']{.literal} referring to the [x]{.literal} and [y]{.literal}
components and their corresponding numerical values. With this new
function definition, we don't need to worry about the order of the
returned values. We just use the key [\'x\']{.literal} to retrieve the
[x]{.literal} component and the key [\'y\']{.literal} to retrieve the
[y]{.literal} component:

if \_\_name\_\_ == \'\_\_main\_\_\':\
    theta = math.radians(45)\
    c = components(theta)\
    y = c\[\'y\'\]\
    x = c\[\'x\'\]\
    print(x, y)

This approach eliminates the need to use indices to refer to a specific
returned value. The following code rewrites the program to find the
range (see "[Measuring the Dispersion](ch03.html#ch03lev1sec04)" on
[page 71](ch03.html#page_71)) so that the results are returned as a
dictionary instead of a tuple:

   \'\'\'\
   Find the range using a dictionary to return values\
   \'\'\'\
   def find\_range(numbers):\
       lowest = min(numbers)\
       highest = max(numbers)\
       \# Find the range\
       r = highest-lowest\
       return {\'lowest\':lowest, \'highest\':highest, \'range\':r}\
\
   if \_\_name\_\_ == \'\_\_main\_\_\':\
       donations = \[100, 60, 70, 900, 100, 200, 500, 500, 503, 600, 1000, 1200\]\
       result = find\_range(donations)\
[➊]{.ent}     print(\'Lowest: {0} Highest: {1} Range: {2}\'.\
              format(result\[\'lowest\'\], result\[\'highest\'\], result\[\'range\'\]))

The [find\_range()]{.literal} function now returns a dictionary with the
keys [lowest]{.literal}, [highest]{.literal}, and [range]{.literal} and
with the lowest number, highest number, and the range as their
corresponding values. At [➊]{.ent}, we simply use the corresponding key
to retrieve the corresponding value.

[]{#page_228}If we were just interested in the range of a group of
numbers and we didn't care about the lowest and highest numbers, we'd
just use [result\[\'range\'\]]{.literal} and not worry about what other
values were returned.

### **Exception Handling** {#app02lev1sec05 .h3}

In [Chapter 1](ch01.html#ch01), we learned that trying to convert a
string such as [\'1.1\']{.literal} to an integer using the
[int()]{.literal} function results in a [ValueError]{.literal}
exception. But with a [try\...except]{.literal} block, we can print a
user-friendly error message:

\>\>\> [try:]{.codestrong}\
        [int(\'1.1\')]{.codestrong}\
[except ValueError:]{.codestrong}\
        [print(\'Failed to convert 1.1 to an integer\')]{.codestrong}\
\
Failed to convert 1.1 to an integer

When any statement in the [try]{.literal} block raises an exception, the
type of exception raised is matched with the one specified by the
[except]{.literal} statement. If there's a match, the program resumes in
the [except]{.literal} block. If the exception doesn't match, the
program execution halts and displays the exception. Here's an example:

\>\>\> [try:]{.codestrong}\
        [print(1/0)]{.codestrong}\
[except ValueError:]{.codestrong}\
        [print(\'Division unsuccessful\')]{.codestrong}\
\
Traceback (most recent call last):\
  File \"\<pyshell\#66\>\", line 2, in \<module\>\
    print(1/0)\
ZeroDivisionError: division by zero

This code block attempts a division by 0, which results in a
[ZeroDivisionError]{.literal} exception. Although the division is
carried out in a [try\...except]{.literal} block, the exception type is
incorrectly specified, and the exception isn't handled correctly. The
correct way to handle this exception is to specify
[ZeroDivisionError]{.literal} as the exception type.

#### ***Specifying Multiple Exception Types*** {#app02lev2sec01 .h4}

You can also specify multiple exception types. Consider the function
[reciprocal()]{.literal}, which returns the reciprocal of the number
passed to it:

def reciprocal(n):\
    try:\
        print(1/n)\
    except (ZeroDivisionError, TypeError):\
        print(\'You entered an invalid number\')

[]{#page_229}We defined the function [reciprocal()]{.literal}, which
prints the reciprocal of the user's input. We know that if the function
is called with 0, it'll cause a [ZeroDivisionError]{.literal} exception.
If you pass a string, however, it'll cause a [TypeError]{.literal}
exception. The function considers both these cases as invalid input and
specifies both [ZeroDivisionError]{.literal} and [TypeError]{.literal}
in the [except]{.literal} statement as a tuple.

Let's try calling the function with a valid input---that is, a nonzero
number:

\>\>\> [reciprocal(5)]{.codestrong}\
0.2

Next, we call the function with 0 as the argument:

\>\>\> [reciprocal(0)]{.codestrong}\
Enter an integer: [0]{.codestrong}\
You entered an invalid number

The [0]{.literal} argument raises the [ZeroDivisionError]{.literal}
exception, which is in the tuple of exception types specified to the
[except]{.literal} statement, so the code prints an error message.

Now, let's enter a string:

\>\>\> [reciprocal(\'1\')]{.codestrong}

In this case, we entered an invalid number, which raises the
[TypeError]{.literal} exception. This exception is also in the tuple of
specified exceptions, so the code prints an error message. If you want
to give a more specific error message, we can just specify multiple
[except]{.literal} statements as follows:

[def reciprocal(n):]{.codestrong}\
    [try:]{.codestrong}\
        [print(1/n)]{.codestrong}\
    [except TypeError:]{.codestrong}\
        [print(\'You must specify a number\')]{.codestrong}\
    [except ZeroDivisionError:]{.codestrong}\
        [print(\'Division by 0 is invalid\')]{.codestrong}\
\
\>\>\> [reciprocal(0)]{.codestrong}\
Division by 0 is invalid\
\>\>\> [reciprocal(\'1\')]{.codestrong}\
You must specify a number

In addition to [TypeError]{.literal}, [ValueError]{.literal}, and
[ZeroDivisionError]{.literal}, there are a number of other built-in
exception types. The Python documentation at
*<https://docs.python.org/3.4/library/exceptions.html#bltin-exceptions>*
lists the builtin exceptions for Python 3.4.

#### []{#page_230}***The else Block*** {#app02lev2sec02 .h4}

The [else]{.literal} block is used to specify which statements to
execute when there's no exception. Consider an example from the program
we wrote to draw the trajectory of a projectile (see "[Drawing the
Trajectory](ch02.html#ch02lev3sec05)" on [page 51](ch02.html#page_51)):

   if \_\_name\_\_ == \'\_\_main\_\_\':\
       try:\
           u = float(input(\'Enter the initial velocity (m/s): \'))\
           theta = float(input(\'Enter the angle of projection (degrees): \'))\
       except ValueError:\
           print(\'You entered an invalid input\')\
[➊]{.ent}     else:\
           draw\_trajectory(u, theta)\
           plt.show()

If the input for [u]{.literal} or [theta]{.literal} couldn't be
converted to a floating point number, it doesn't make sense for the
program to call the [draw\_trajectory()]{.literal} and
[plt.show()]{.literal} functions. Instead, we specify these two
statements in the [else]{.literal} block at [➊]{.ent}. Using
[try\...except\...else]{.literal} will let you manage different types of
errors during runtime and take appropriate action when there is an error
or when there is none:

1\. If there's an exception and there's an [except]{.literal} statement
corresponding to the exception type raised, the execution is transferred
to the corresponding [except]{.literal} block.

2\. If there's no exception, the execution is transferred to the
[else]{.literal} block.

### **Reading Files in Python** {#app02lev1sec06 .h3}

Opening a file is the first step to reading data from it. Let's start
with a quick example. Consider a file that consists of a collection of
numbers with one number per line:

100\
60\
70\
900\
100\
200\
500\
500\
503\
600\
1000\
1200

[]{#page_231}We want to write a function that reads the file and returns
a list of those numbers:

   def read\_data(path):\
       numbers = \[\]\
[➊]{.ent}     f = open(path)\
[➋]{.ent}     for line in f:\
           numbers.append(float(line))\
       f.close()\
       return numbers

First, we define the function [read\_data()]{.literal} and create an
empty list to store all of the numbers. At [➊]{.ent}, we use the
[open()]{.literal} function to open the file whose location has been
specified via the argument path. An example of the path would be
*/home/username/mydata.txt* on Linux, *C:\\mydata.txt* on Microsoft
Windows, or */Users/Username/mydata.txt* on OS X. The [open()]{.literal}
function returns a file object, which we use the label [f]{.literal} to
refer to. We can go over each line of the file using a [for]{.literal}
loop at [➋]{.ent}. Because each line is returned as a string, we convert
it into a number and append it to the list [numbers]{.literal}. The loop
stops executing once all the lines have been read, and we close the file
using the [close()]{.literal} method. Finally, we return the
[numbers]{.literal} list.

This is similar to how we read the numbers from a file in [Chapter
3](ch03.html#ch03), although we didn't have to close the file explicitly
because we used a different approach there. Using the approach we took
in [Chapter 3](ch03.html#ch03), we would rewrite the preceding function
as follows:

   def read\_data(path):\
       numbers = \[\]\
[➊]{.ent}     with open(path) as f:\
           for line in f:\
               numbers.append(float(line))\
[➋]{.ent}     return numbers

The key statement here is at [➊]{.ent}. It's similar to writing [f =
open(path)]{.literal} but only partially. Besides opening the file and
assigning the file object returned by [open()]{.literal} to
[f]{.literal}, it also sets up a new *context* with all the statements
in that block---in this case, all the statements before the
[return]{.literal} statement. When all the statements in the body have
been executed, the file is automatically closed. That is, when the
execution reaches the statement at [➋]{.ent}, the file is closed without
needing an explicit call to the [close()]{.literal} method. This method
also means that if there are any exceptions while working with the file,
it'll still be closed before the program exits. This is the preferred
approach to working with files.

#### []{#page_232}***Reading All the Lines at Once*** {#app02lev2sec03 .h4}

Instead of reading the lines one by one to build a list, we can use the
[readlines()]{.literal} method to read all the lines into a list at
once. This results in a more compact function:

   def read\_data(path):\
       with open(path) as f:\
[➊]{.ent}         lines = f.readlines()\
       numbers = \[float(n) for n in lines\]\
       return numbers

We read all the lines of the file into a list using the
[readlines()]{.literal} method at [➊]{.ent}. Then, we convert each of
the items in the list into a floating point number using the
[float()]{.literal} function and list comprehension. Finally, we return
the list [numbers]{.literal}.

#### ***Specifying the Filename as Input*** {#app02lev2sec04 .h4}

The [read\_data()]{.literal} function takes the file path as an
argument. If your program allows you to specify the filename as an
input, this function should work for any file as long as the file
contains data we expect to read. Here's an example:

if \_\_name\_\_==\'\_\_main\_\_\':\
    data\_file = input(\'Enter the path of the file: \')\
    data = read\_data(data\_file)\
    print(data)

Once you've added this code to the end of the [read\_data()]{.literal}
function and run it, it'll ask you to input the path to the file. Then,
it'll print the numbers it reads from the file:

Enter the path of the file [/home/amit/work/mydata.txt]{.codestrong}\
\[100.0,60.0,70.0,900.0,100.0,200.0,500.0,500.0,503.0,600.0,1000.0,1200.0\]

#### ***Handling Errors When Reading Files*** {#app02lev2sec05 .h4}

There are a couple of things that can go wrong when reading files: (1)
the file can't be read, or (2) the data in the file isn't in the
expected format. Here's an example of what happens when a file can't be
read:

Enter the path of the file: [/home/amit/work/mydata2.txt]{.codestrong}\
Traceback (most recent call last):\
  File \"read\_file.py\", line 11, in \<module\>\
    data = read\_data(data\_file)\
  File \"read\_file.py\", line 4, in read\_data\
    with open(path) as f:\
FileNotFoundError: \[Errno 2\] No such file or directory: \'/home/amit/work/\
mydata2.txt\'

[]{#page_233}Because I entered a file path that doesn't exist, the
[FileNotFoundError]{.literal} exception is raised when we try to open
the file. We can make the program display a user-friendly error message
by modifying our [read\_data()]{.literal} function as follows:

def read\_data(path):\
    numbers = \[\]\
    try:\
        with open(path) as f:\
            for line in f:\
                numbers.append(float(line))\
    except FileNotFoundError:\
        print(\'File not found\')\
    return numbers

Now, when you specify a nonexistent file path, you'll get an error
message instead:

Enter the path of the file: [/home/amit/work/mydata2.txt]{.codestrong}\
File not found

The second source of errors can be that the data in the file isn't what
your program expects to read. For example, consider a file that has the
following:

10\
20\
3o\
1/5\
5.6

The third line in this file isn't convertible to a floating point number
because it has the letter [o]{.literal} in it instead of the number
[0]{.literal}, and the fourth line consists of [1/5]{.literal}, a
fraction in string form, which [float()]{.literal} can't handle.

If you supply this data file to the earlier program, it'll produce the
following error:

Enter the path of the file: [bad\_data.txt]{.codestrong}\
Traceback (most recent call last):\
  File \"read\_file.py\", line 13, in \<module\>\
    data = read\_data(data\_file)\
  File \"read\_file.py\", line 6, in read\_data\
    numbers.append(float(line))\
ValueError: could not convert string to float: \'3o\\n\'

The third line in the file is [3o]{.literal}, not the number
[30]{.literal}, so when we attempt to convert it into a floating point
number, the result is [ValueError]{.literal}. There are two approaches
you can take when such data is present in a file. The first
[]{#page_234}is to report the error and exit the program. The modified
[read\_data()]{.literal} function would appear as follows:

   def read\_data(path):\
       numbers = \[\]\
       try:\
           with open(path) as f:\
               for line in f:\
[➊]{.ent}               try:\
[➋]{.ent}                   n = float(line)\
                 except ValueError:\
                     print(\'Bad data: {0}\'.format(line))\
[➌]{.ent}                   break\
[➍]{.ent}               numbers.append(n)\
       except FileNotFoundError:\
           print(\'File not found\')\
       return numbers

We insert another [try\...except]{.literal} block in the function
starting at [➊]{.ent}, and we convert the line into a floating point
number at [➋]{.ent}. If the program raises the [ValueError]{.literal}
exception, we print an error message with the offending line and exit
out of the [for]{.literal} loop using [break]{.literal} at [➌]{.ent}.
The program then stops reading the file. The returned list,
[numbers]{.literal}, contains all the data that was successfully read
before encountering the bad data. If there's no error, we append the
floating point number to the [numbers]{.literal} list at [➍]{.ent}.

Now when you supply the file *bad\_data.txt* to the program, it'll read
only the first two lines, display the error message, and exit:

Enter the path of the file: [bad\_data.txt]{.codestrong}\
Bad data: 3o\
\
\[10.0, 20.0\]

Returning partial data may not be desirable, so we could just replace
the break statement at [➌]{.ent} with [return]{.literal} and no data
would be returned.

The second approach is to ignore the error and continue with the rest of
the file. Here's a modified [read\_data()]{.literal} function that does
this:

   def read\_data(path):\
       numbers = \[\]\
       try:\
           with open(path) as f:\
               for line in f:\
                   try:\
                       n = float(line)\
                   except ValueError:\
                       print(\'Bad data: {0}\'.format(line))\
[➊]{.ent}                     continue\
                   numbers.append(n)\
       except FileNotFoundError:\
           print(\'File not found\')\
       return numbers

[]{#page_235}The only change here is that instead of breaking out of the
[for]{.literal} loop, we just continue with the next iteration using the
[continue]{.literal} statement at [➊]{.ent}. The output from the program
is now as follows:

Bad data: 3o\
\
Bad data: 1/5\
\
\[10.0, 20.0, 5.6\]

The specific application where you're reading the file will determine
which of the above approaches you want to take to handle bad data.

### **Reusing Code** {#app02lev1sec07 .h3}

Throughout this book, we've used classes and functions that were either
part of the Python standard library or available after installing
third-party packages, such as matplotlib and SymPy. Now we'll look at a
quick example of how we can import our own programs into other programs.

Consider the function [find\_corr\_x\_y()]{.literal} that we wrote in
"[Calculating the Correlation Between Two Data
Sets](ch03.html#ch03lev1sec05)" on [page 75](ch03.html#page_75). We'll
create a separate file, *correlation.py*, which has only the function
definition:

\'\'\'\
Function to calculate the linear correlation coefficient\
\'\'\'\
\
def find\_corr\_x\_y(x,y):\
    \# Size of each set\
    n = len(x)\
\
    \# Find the sum of the products\
    prod=\[\]\
    for xi,yi in zip(x,y):\
        prod.append(xi\*yi)\
\
    sum\_prod\_x\_y = sum(prod)\
    sum\_x = sum(x)\
    sum\_y = sum(y)\
    squared\_sum\_x = sum\_x\*\*2\
    squared\_sum\_y = sum\_y\*\*2\
\
    x\_square=\[\]\
    for xi in x:\
        x\_square.append(xi\*\*2)\
    x\_square\_sum = sum(x\_square)\
\
    y\_square=\[\]\
    for yi in y:\
        y\_square.append(yi\*\*2)\
    y\_square\_sum = sum(y\_square)\
\
    numerator = n\*sum\_prod\_x\_y - sum\_x\*sum\_y\
    denominator\_term1 = n\*x\_square\_sum - squared\_sum\_x\
    denominator\_term2 = n\*y\_square\_sum - squared\_sum\_y\
    denominator = (denominator\_term1\*denominator\_term2)\*\*0.5\
\
    correlation = numerator/denominator\
\
    return correlation

[]{#page_236}Without the *.py* file extension, a Python file is referred
to as a module. This is usually reserved for files that define classes
and functions that'll be used in other programs. The following program
imports the [find\_corr\_x\_y()]{.literal} function from the correlation
module we just defined:

from correlation import find\_corr\_x\_y\
if \_\_name\_\_ == \'\_\_main\_\_\':\
    high\_school\_math = \[83, 85, 84, 96, 94, 86, 87, 97, 97, 85\]\
    college\_admission = \[85, 87, 86, 97, 96, 88, 89, 98, 98, 87\]\
    corr = find\_corr\_x\_y(high\_school\_math, college\_admission)\
    print(\'Correlation coefficient: {0}\'.format(corr))

This program finds the correlation between the high school math grades
and college admission scores of students we considered in [Table
3-3](ch03.html#ch3tab3) on [page 80](ch03.html#page_80). We import the
[find\_corr\_x\_y()]{.literal} function from the correlation module,
create the lists representing the two sets of grades, and call the
[find\_corr\_x\_y()]{.literal} function with the two lists as arguments.
When you run the program, it'll print the correlation coefficient. Note
that the two files must be in the same directory---this is strictly to
keep things simple.
