int fib(int n){
if(n == 0){
	return 5;
}
return fib(n-1);
}
int func() {
	return fib(3);
}
//答え5
