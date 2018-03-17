package lab2;

import java.util.*;


import lab2.date.*;

public class Magazin {

	private Client[] clienti = new Client[0];
	private ProdusCumparat[][] produseCumparate = new ProdusCumparat[0][]; 
	private Date ultimaAchizitie = new Date();
	
	public Client[] getClienti() {
		return this.clienti;
	}
	
	public int gasesteClient(String Nume) {
	
		for (int i = 0; i < clienti.length; i++)
			if (Nume.equals(clienti[i].getNume())) {
				return i;
			}
		return -1;
		
	}
	
	public Client userNou(String Nume) {
		
		this.produseCumparate = Arrays.copyOf(this.produseCumparate, this.produseCumparate.length + 1);
		this.produseCumparate[this.produseCumparate.length - 1] = new ProdusCumparat[0];
		
		this.clienti = (Client[]) Arrays.copyOf(this.clienti, this.clienti.length + 1);
		this.clienti[this.clienti.length - 1] = new Client();
		this.clienti[this.clienti.length - 1].setNume(Nume);
		
		return this.clienti[this.clienti.length - 1];
	}
	
	
	public void clientCumpara(String Nume, String NumeProdus, int Cantitate) {
		int pozitie = gasesteClient(Nume);
		boolean flag = false;
		if (pozitie < 0) {
			userNou(Nume);
		}
		System.out.println(pozitie);
		pozitie = produseCumparate.length - 1;
		for (int i = 0; i < produseCumparate[pozitie].length; i++)
			if (NumeProdus.equals(produseCumparate[pozitie][i].getNume())) {
				produseCumparate[pozitie][i].setCantitate(Cantitate);
				ultimaAchizitie = Calendar.getInstance().getTime();
				flag = true;
				break;
			}

		if(flag == false) {
			produseCumparate[pozitie] = (ProdusCumparat[]) Arrays.copyOf(produseCumparate[pozitie], produseCumparate[pozitie].length + 1);
			int lungime = produseCumparate[pozitie].length - 1; 
			produseCumparate[pozitie][lungime] = new ProdusCumparat();
			produseCumparate[pozitie][lungime].setCantitate(Cantitate);
			produseCumparate[pozitie][lungime].setNume(Nume);
		}
			
	}
	public static void main(String[] args) {
		
		Magazin magazin = new Magazin();
		Scanner scanner = new Scanner(System.in);
		
		magazin.userNou("Bogdan");
		magazin.userNou("Andrei");
		System.out.print("1=Afisare clienti\n2=Adaugare cumparaturi\n3=Adaugare client");
		
		while(true) {
			
			int optiune = scanner.nextInt();
		
			if (optiune == 1) {
			
				Client[] clienti_aux = (Client[]) Arrays.copyOf(magazin.clienti, magazin.clienti.length);
				Arrays.sort(clienti_aux, new Comparator<Client>() {
					  public int compare(Client obiect1, Client obiect2) {
					    if (obiect1.getNume().compareTo(obiect2.getNume()) < 0) 
					    	return -1;
					    return 0;
					  }});
				for (int i = 0; i < clienti_aux.length; i++)
					System.out.println(clienti_aux[i].getNume());
			}
			else
			if (optiune == 2) {
				
				System.out.println("Cine cumpara?");
				String nume =  scanner.next();
				System.out.println("Ce cumpara?");
				String produs = scanner.next();
				System.out.println("Cat cumpara?");
				int cantitate = scanner.nextInt();
				magazin.clientCumpara(nume, produs, cantitate);
			}
			else
			if (optiune == 3) {
				
				System.out.println("Introduceti numele clientului");
				magazin.userNou(scanner.next());
				
			} else {
				
				scanner.close();
				return;
			}
			
		} // while 
	} // main
} // clasa 


