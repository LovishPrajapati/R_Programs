var = readline(prompt = "Enter any number : "); 
var = as.integer(var);
sum1<-0
for(i in 1:var){
  sum1<-sum1+(i^3)+4*(i^2)
}
print(sum1)

i<-readline(prompt = "Enter value of i: ");
i<-as.integer(i)
j<-readline(prompt = "Enter value of j: ");
j<-as.integer(j)
sum2<-0
counti<-1
countj<-1
repeat{
  if(counti>i || countj>j)
    break
  sum2<-sum2+(i^4)/(3+j)
  counti<-counti+1
  countj<-countj+1
}

print(sum2)
