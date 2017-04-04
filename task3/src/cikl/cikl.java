
package cikl;
import java.util.Scanner;
public class cikl {
	public static void main (String [] args){
	int a,b=0;
		System.out.println("Вы вошли в комнату,с бассейном посредине, а в нем крокодил."+ "\n" + "\n" + "1- бежать из комнаты. 2- подойтик бассейну");
		 Scanner sc1 = new Scanner(System.in);
		 if(sc1.hasNextInt()) 
		 	{ a = sc1.nextInt();
		 		if (a==1) { System.out.println("Вы спаслись");}
		 		if (a==2) { System.out.println("В бассейне большой крокодил"+"\n" + "\n"+"1- бежать из комнаты 2- ткнуть крокодила в глаз");}
		 			Scanner sc2 = new Scanner(System.in);
		 			if(sc2.hasNextInt())
		 				{ b = sc2.nextInt();
		 					if (b==1) { System.out.println("Вы спаслись"); }
		 					if (b==2) { System.out.println("\n" + "\n" +"Крокодил откусил вам ногу"+"\n" +"Вы умерли от потери крови"); }
		 					}
		 				
		 		 System.out.println("КОНЕЦ");}
			    
		}
}		
    

	 
	 

