package lab6;

import java.util.Arrays;
import java.util.Comparator;
import java.util.function.Function;
import java.util.function.ToDoubleFunction;
import java.util.function.ToIntFunction;
import java.util.function.ToLongFunction;

public class Lansator {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		Persoana[] persoane = new Persoana[10];
		
		Arrays.sort(persoane, new Comparator() {

			public int compare(Object arg0, Object arg1) {
				return 0;
				//putem face if-uri pt fiecare arg0 si arg1, pe cazuri
			}			
		}); // se foloseste interfata comparable, metoda compareTo

	}

}
