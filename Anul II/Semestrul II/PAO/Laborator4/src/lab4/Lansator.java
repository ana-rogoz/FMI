package lab4;

import lab4.date.Profesor;
import lab4.date.Student;

import com.neuralsoft.pao.ppldatabase.MainWindow;

public class Lansator {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		MainWindow fereastra = new MainWindow();
		fereastra.addElementType(Student.class);
		fereastra.addElementType(Profesor.class);
		fereastra.show();

	}

}
