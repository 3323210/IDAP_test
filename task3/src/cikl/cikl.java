
package cikl;
import java.util.Scanner;
public class cikl {
	public static void main (String [] args){
	int a,b=0;
		System.out.println("�� ����� � �������,� ��������� ���������, � � ��� ��������."+ "\n" + "\n" + "1- ������ �� �������. 2- �������� ��������");
		 Scanner sc1 = new Scanner(System.in);
		 if(sc1.hasNextInt()) 
		 	{ a = sc1.nextInt();
		 		if (a==1) { System.out.println("�� ��������");}
		 		if (a==2) { System.out.println("� �������� ������� ��������"+"\n" + "\n"+"1- ������ �� ������� 2- ������ ��������� � ����");}
		 			Scanner sc2 = new Scanner(System.in);
		 			if(sc2.hasNextInt())
		 				{ b = sc2.nextInt();
		 					if (b==1) { System.out.println("�� ��������"); }
		 					if (b==2) { System.out.println("\n" + "\n" +"�������� ������� ��� ����"+"\n" +"�� ������ �� ������ �����"); }
		 					}
		 				
		 		 System.out.println("�����");}
			    
		}
}		
    

	 
	 

