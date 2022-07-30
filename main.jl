import Dates
import Pkg
Pkg.add("Primes")
import Primes:isprime,primes

function sub(s::BigInt,m::BigInt,p::Int)
    s2=s^2
    s = (s2 & m) + (s2 >> p)
    if s >= m
           s -= m
    end
    s -= 2
end

function Lucas_Lehmer_Test(p::Int)
  s = BigInt(4) #S_0の定義
  m = (BigInt(1)<<p) - 1
  
  @inbounds @simd for _ in 2:p-1
    s=sub(s,m,p)
  end
  return s==0
end

    
#M=0
startNumber=3
endNumber=1000000
#p=startNumber
@inbounds @simd for p in primes(startNumber,endNumber)
  start=Dates.now()
    M=Lucas_Lehmer_Test(p)
  if M==true
        println("p:",p)
        ans=BigInt(2)^p-1
        println("Digits of (2^p-1):",length(string(ans)))
#        println("2^p-1:",ans) 
        println("time:",Dates.now()-start)
    
  end
end

