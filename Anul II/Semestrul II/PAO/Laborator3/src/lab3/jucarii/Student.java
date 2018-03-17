package lab3.jucarii;

import lab3.numarator.ClassCounter;

public class Student {

	private String Nume;
	private String Prenume;
	private Student Prieten; 
	
	public Student() {
		ClassCounter.getInstance().instantaNoua("Student");
	}
	
	public String toString() {
		return "Studentul se numeste " + Nume + " " + Prenume;
	}

	public Student(Student studentNou) {
		this.Nume = studentNou.Nume;
		this.Prenume = studentNou.Prenume;
		// Shallow copy. -- trebuie verificat daca studentNou.Prieten nu e null; poate genera la infinit altfel. 
		this.Prieten = studentNou.Prieten; // daca schimb datele prietenului
										  // se schimba numele si in original
										 // si in copie; daca schimb nume sau
										// prenume in copie sau original, 
										// nu se mai schimba si in celalalt;
										// argumentul Prieten pointeaza si 
										// in copie si in original spre acelasi
										//camp.
		
		// Deep copy.
		// this.Prieten = new Student(); si copiem cele doua campuri unul cate unul.
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
