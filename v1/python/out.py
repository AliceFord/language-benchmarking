import math
import re
class Tests:
 def __init__(self):
  pass
 def run(self):
  suite=bin(int(input())).replace("0b","").zfill(5)
  if suite[0]=="1":
   if self.__a005132(13)!=[1,3,6,2,7,13,20,12,21,11,22,10,23]:
    raise Exception
  if suite[1]=="1":
   if len(self.__a002113(10000000))!=10999:
    raise Exception
  if suite[2]=="1":
   if len(self.__a000040(10000000))!=664579:
    raise Exception
  if suite[3]=="1":
   a005150Ans=[1,2,2,4,6,6,8,10,14,20,26,34,46,62,78,102,134,176,226,302,408,528,678,904,1182,1540,2012,2606,3410,4462,5808,7586,9898,12884,16774,21890,28528,37158,48410,63138,82350,107312,139984,182376,237746]
   for i,c in enumerate(self.__a005150(40)):
    if len(c)!=a005150Ans[i]:
     raise Exception
  if suite[4]=="1":
   if self.__a000045(35)!=[1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765,10946,17711,28657,46368,75025,121393,196418,317811,514229,832040,1346269,2178309,3524578,5702887,9227465,14930352]:
    raise Exception
 def __a005132(self,ntop): 
  def func(n):
   if n==0:
    return 0
   else:
    lst=[func(k)for k in range(n)]
    if(func(n-1)-n<0)or(func(n-1)-n in lst):
     return func(n-1)+n
    else:
     return func(n-1)-n
  rval=[]
  for i in range(1,ntop+1):
   rval.append(func(i))
  return rval
 def __a002113(self,n): 
  output=[]
  for i in range(n+1):
   rstr=str(i)
   if rstr==rstr[::-1]:
    output.append(i)
  return(output)
 def __a000040(self,n): 
  prime=[True for i in range(n+1)]
  p=2
  while p*p<=n:
   if prime[p]:
    for i in range(p*2,n+1,p):
     prime[i]=False
   p+=1
  prime[0]=False
  prime[1]=False
  rval=[]
  for p in range(n+1):
   if prime[p]:
    rval.append(p)
  return rval
 def __a005150(self,ntop): 
  def lookandsay(n,seq=1):
   if n>1:
    return lookandsay(n-1,"".join([str(len(match.group()))+match.group()[0]for matchNum,match in enumerate(re.finditer(r"(\w)\1*",str(seq)))]))
   else:
    return str(seq)
  arr=[]
  for i in range(1,ntop+1):
   arr.append(lookandsay(i))
  return arr
 def __a000045(self,ntop): 
  def F(n):
   if n>1:
    return F(n-1)+F(n-2)
   return 1
  arr=[]
  for i in range(1,ntop+1):
   arr.append(F(i))
  return arr
test=Tests()
test.run()
# Created by pyminifier (https://github.com/liftoff/pyminifier)

