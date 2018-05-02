package lab7;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public class Lansator {

	static Carte[] carti;
	
	public static void salveaza() throws IOException, NotebookToSaleException{
		if(carti.length == 0 || carti == null) {
				throw new NotebookToSaleException();
				
		}
		try(FileOutputStream fout = new FileOutputStream("date.out");
				ObjectOutputStream oos = new ObjectOutputStream(fout);) {	
			oos.writeObject(carti);
		}
	}
	public static void main(String arg0[]) throws IOException, NotebookToSaleException, ClassNotFoundException{
		
		
		carti = new Carte[1];
		//carti[0] = new Carte();
		carti[0] = new Revista();
		carti[0].setCoperta(new Coperta());
		carti[0].setTitlu("carte");
	
		try {
			
			salveaza();
		}
		catch(FileNotFoundException ex1) {
			
		}
		catch(NullPointerException e) {
			System.out.println("NullPointerException");
		}
		//catch(IOException ex2) {
		
		//}
		//catch(NotebookToSaleException e) {
		//}
		
		//catch(NullPointerException e) {
			//System.out.println("NullPointerExceptioni");
		//}
		
		Carte[] citit;
		try(ObjectInputStream ois = new ObjectInputStream(new FileInputStream("date.out"));) {	
			citit = (Carte[]) ois.readObject();
			System.out.println(citit[0].getClass().getSimpleName());
		}
		
		System.out.println(citit[0].getTitlu());
	}
}
