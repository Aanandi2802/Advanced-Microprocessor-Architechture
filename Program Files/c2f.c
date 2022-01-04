int tempc=81,tempf;
extern int c2f(int c);
void main()
{
clrscr();
printf("Name        : Aanandi Pankhania\n");
printf("Roll_no     : IT 081\n");
printf("C2f is defined in Assembly Program.\n");
tempf=c2f(tempc);
printf("Celsius     : %d\nFahrenheit  : %d \n",tempc,tempf);
getch();
}
