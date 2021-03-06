import Dates
# creating a Dates object 

function Lucas_Lehmer_Test(p)
  s = 4 #S_0の定義
  m = (BigInt(1)<<p) - 1
  
  for n in 2:p-1
    s2=BigInt(s)^2
    s = (s2 & m) + (s2 >> p)
    if s >= m
           s -= m
    end
    s -= 2
  end
  return s==0
end

    
#M=0
start=Dates.now()
const first=3
const step=2
const last=50000
for i in first:step:last
  M=Lucas_Lehmer_Test(i)
  if M==true
        println("p:",i)
#        ans=BigInt(2)^i-1
#println("len(2^p-1):",length(string(ans)))
#        println("2^p-1:",ans) 
    println("time:",Dates.now()-start)
  end
end

