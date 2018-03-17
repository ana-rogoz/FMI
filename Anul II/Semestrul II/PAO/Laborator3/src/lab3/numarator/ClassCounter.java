package lab3.numarator;

import java.util.Arrays;

public class ClassCounter {

	private static ClassCounter instance;
	private Pereche[] perechi = new Pereche[0];
	
	// constructorul este private pentru ca vrem sa avem o clasa Singleton.
	private ClassCounter() {
		
	}
	
	// metodele statice pot returna doar obiecte statice.
	// in metodele statice nu exista this. 
	// metodele statice pot accesa doar date statice. 
	public static ClassCounter getInstance() {
		if (instance == null) {
			instance = new ClassCounter();
		} // putea fi alocat si sus, unde am declarat argumentul.
		
		return instance;
	}
	
	// adaugam pentru numeClasa o noua instanta sau formam un nou numeClasa.
	public void instantaNoua(String numeNou) {
		
		for (int i = 0; i < perechi.length; i++) {
			if (perechi[i].getNume().equals(numeNou)) {
				perechi[i].setNumar(perechi[i].getNumar() + 1);	
				return;
			}
		}
	
		perechi = Arrays.copyOf(perechi, perechi.length + 1);
		perechi[perechi.length - 1] = new Pereche();
		perechi[perechi.length - 1].setNumar(1);
		perechi[perechi.length - 1].setNume(numeNou);
	}

	// returnam numarul de instante existe pentru numeClasa.
	public int getNumar(String numeClasa) {

		for (int i = 0; i < perechi.length; i++) {
			if (perechi[i].getNume().equals(numeClasa)) {	
				return perechi[i].getNumar();
			}
		}
		
		return 0;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
