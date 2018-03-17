package package1;
 
import package2.Clas2;
 
public class Clas1 {
	int NumarIntreg;
	String NumeString;
	Clas1 NumeObiect;
	int[] NumeVector;
 
	void functie(int x, int[] Vector) {
		x = 5;
		int[] B = Vector;
		B[2] = 100;
	}
 
	public static void main(String[] args) {
		Clas1 Obiect = new Clas1();
		Obiect.NumarIntreg = 10;
		Obiect.NumeVector = new int[]{1,2,3,4,5};
		System.out.println(Obiect.NumarIntreg);
		System.out.println(Obiect.NumeVector[2]);
		Obiect.functie(Obiect.NumarIntreg, Obiect.NumeVector);
		System.out.println(Obiect.NumarIntreg);
		System.out.println(Obiect.NumeVector[2]);
		Clas2 Test = new Clas2();
	}
}