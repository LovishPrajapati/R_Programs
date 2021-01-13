fact<-function(number){
  if(number>=0){
    if(number==0){
      cat("Factorial is: ",1,"\n")
    }
    else{
      pro<-1
      for(i in 1:number)
        pro<-pro*i
      cat("Factorial is: ",pro,"\n")
    }
  }else{
    cat("Number should be non-negative\n")
  }
}


isPrime<-function(number){
  if(number>1){
    flag<-0
    for(i in 2:(number-1)){
      if(number%%i == 0){
        flag<-1
        break
      }
    }
    if(number==2)
      return(TRUE)
    if(flag==1){
      return(FALSE)
    }else{
      return(TRUE)
    }
  }
  else{
    return(FALSE)
  }
}

sumOfDigits<-function(number){
  sum1<-0
  while(number!=0){
    sum1<-sum1+number%%10
    number<-number%/%10
  }
  cat("Sum of digits is: ",sum1,"\n")
}

productOfDigits<-function(number){
  pro<-1
  while(number!=0){
    pro<-pro*number%%10
    number<-number%/%10
  }
  cat("Product of digits is: ",pro,"\n")
}

primeTill<-function(number){
  if(number>1){
    cat("Prime numbers till", number,"\n")
    for(j in 2:(number-1)){
      if(isPrime(j)){
        print(j)
      }
    }
  }else{
    cat("No prime numbers\n")
  }
  
}

repeat{
  cat("---------------------------\n 1.Factorial \n 2.Check if number is prime  \n 3.Sum of digits of number  \n 4.Product of digits of number \n 5.Prime number till given number \n 6. Exit \n--------------------------\n")
  choice<-readline(prompt = "Enter choice : \n");
  choice<-as.integer(choice)
  if(choice==6)
    break
  number<-readline(prompt = "Enter a number: ");
  number<-as.integer(number)
  if(choice == 1){
    fact(number)
  }else if(choice==2){
    if(isPrime(number)){
      print("Number is  prime")
    }else{
      print("Number is not prime")
    }
  }else if(choice == 3){
    sumOfDigits(number)
  }else if(choice == 4){
    productOfDigits(number)
  }else if(choice == 5){
    primeTill(number)
  }else{
    print("Be in limits")
  }
}

