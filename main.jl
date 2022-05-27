@everywhere import Dates
@everywhere import Pkg
@everywhere Pkg.add("Primes")
@everywhere import Primes:isprime,primes
using Base.Threads
using SharedArrays

# creating a Dates object 
@everywhere function Lucas_Lehmer_Test(p)
  s = 4 #S_0の定義
  m = (BigInt(1)<<p) - 1
  
  for n in 2:p-1
    s2=s^2
    s = (s2 & m) + (s2 >> p)
    if s >= m
           s -= m
    end
    s -= 2
  end
  if s==0
        println("p:",p)
        ans=BigInt(2)^p-1
        println("len(2^p-1):",length(string(ans)))
#        println("2^p-1:",ans) 
        println("time:",Dates.now()-start)
  end
  return s==0
end 

start=Dates.now()
#pm=primes(3,100)
@inbounds for p in primes(3,100)
    M=@spawn Lucas_Lehmer_Test(p)
end
#pmap(Lucas_Lehmer_Test,primes(3,100))