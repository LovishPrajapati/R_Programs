add<-function(a,b){
  cat("Addition:",a,' + ',b," = ",(a+b),"\n")
}
sub<-function(a,b){
  cat("Difference:",a,' - ',b," = ",(a-b),"\n")
}
mul<-function(a,b){
  cat("Product:",a,' * ',b," = ",(a*b),"\n")
}
div<-function(a,b){
  print(a/b)
}
exp<-function(a,b){
  cat("Result:",a,'^',b," = ",(a^b),"\n")
}
rem<-function(a,b){
  cat("Remainder:",a,'/',b," = ",(a%%b),"\n")
}
repeat{
  cat("\n---------------------------\n 1.Add \n 2.Sub  \n 3.Mul  \n 4.Div \n 5.Exp \n 6.Rem \n 7.Exit \n---------------------------\n")
  choice<-readline(prompt = "Enter choice : \n");
  choice<-as.integer(choice)
  if(choice==7)
    break
  i<-readline(prompt = "Enter first number: ");
  i<-as.integer(i)
  j<-readline(prompt = "Enter second third: ");
  j<-as.integer(j)
  if(choice==4){
    while(j==0){
      cat("Denominator cannot be zero\n")
      j<-readline(prompt = "Enter second third: ");
      j<-as.integer(j)
    }
  }
  switch(choice,add(i,j),sub(i,j),mul(i,j),div(i,j),exp(i,j),rem(i,j))
}



