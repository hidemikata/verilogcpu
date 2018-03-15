int fib(int n){
if(n == 0){
	return 1;
}
return fib(n-1) + fib(n-1);
}
int func() {
	return fib(5);
}
//答え32
