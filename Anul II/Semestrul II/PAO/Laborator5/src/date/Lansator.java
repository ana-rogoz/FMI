package date;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.neuralsoft.pao.lab5.InputWindow;
import com.neuralsoft.pao.lab5.MyMatcher;
import com.neuralsoft.pao.lab5.Splitter;

public class Lansator {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		/*Persoana[] persoane = new Persoana[4];
		persoane[0] = new Admin();
		persoane[1] = new Medic();
		persoane[2] = new Inginer();
		persoane[3] = new Profesor();
		*/
		
		// Exercitiul 2.
		String csv = "a,bg,234,asdg";
		String[] exploded = csv.split(",");

		for (String s: exploded) {
			System.out.println(s);
		}
		
		
		InputWindow.getInstance().setSplitHandler(new Splitter(){

			@Override
			public String[] split(String string, String pattern) {
				return string.split(pattern);
			}
		});
		
		InputWindow.getInstance().setMatcherHandler(new MyMatcher(){

			@Override
			public boolean matches(String string, String pattern) {
				Pattern pat = Pattern.compile(pattern);
				System.out.println(pat);
				Matcher mat = pat.matcher(string);
				System.out.println(mat);
				return mat.find();
			}
		});
	}

}
