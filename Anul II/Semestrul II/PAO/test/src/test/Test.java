package test;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Serializable;
import java.net.Socket;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.function.Predicate;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class Test{
	
	
	/*public int metoda() {
		return 0;
		return 1;
	}*/
	
	
	public List<Double> transforma(List<Integer> listaInitiala) {
		
		List<Double> solutie = new ArrayList<Double>();
		for(Integer obj: listaInitiala) {
			Double obj2 = obj.doubleValue();
			solutie.add(obj2);
		}
		return solutie;
	}
	public int metoda2(Connection myConn, int nr) {
		
	int nrStudenti = 0;
	try(PreparedStatement ps = myConn.prepareStatement("SELECT * FROM student");
		ResultSet rs = ps.executeQuery();) {
			 
	        while(rs.next()!=false) {
	        	int nrPrezente = rs.getInt("prezente");
	        	if(nrPrezente > 5)
	        		nrStudenti ++;
	        }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	return nrStudenti;
	}
	
	public void scrie(List<Integer> listaNumere) throws IOException {
		
		OutputStream os = new FileOutputStream("myFile.txt");
		PrintWriter scaner = new PrintWriter(os);
		for (Integer obj: listaNumere) { 
			scaner.write(Integer.toString(nr) + ",");
		}
		scaner.close();
		os.close();
	}
	
	
	// Test 1 
	public List<Object> functie(String numeFisier) throws IOException, ClassNotFoundException {
		InputStream fis = new FileInputStream(numeFisier);
		ObjectInputStream ois = new ObjectInputStream(fis);
		Object objCurent = new Object();  
		List <Object> rezultat = new ArrayList<Object>();
		
		while(true) {
			objCurent = ois.readObject();
			if (objCurent instanceof Object)//Terminator)
				break;
			rezultat.add(objCurent);
		}
		
		ois.close();
		return rezultat;
		
	}
	
	public Integer SUMA(Integer rezultat, int a, int b) {
		rezultat = a + b;
		return rezultat;
	} // nu merge fara return 
	
	private Socket socket; 
	public int citesteByte() throws IOException {
		InputStream in = socket.getInputStream();
		return in.read();
		// putem face int ob = in.read();
		// in.close();
		// return ob;
		// socket nu e configurat, si nici inchisa resursa 
	}
	
	
	public Connection connection; 
	
	public void testJDBC() throws SQLException {
		
		PreparedStatement st = connection.prepareStatement("SELECT * FROM users WHERE password=?");
		ResultSet rs = st.executeQuery();
		while(rs.next()) {
			System.out.println(rs.getString("username"));
		}
		
		// Erori: nu sunt inchise resursele: PreparedStatement, ResultSet, Connection
		// nu a fost data valoare parametrului password
		// nu stim daca conexiunea s-a configurat 
	}
	 
	
	// Scrieti o metoda care primeste ca parametru un nume de fisier si doua numere max si count.
	public void scrie(String numeFisier, int max, int count) throws IOException {
		Random random = new Random();
		
		OutputStream os = new FileOutputStream(numeFisier);
		PrintWriter scaner = new PrintWriter(os);
		for (int i = 1; i < count; i++) {
			int nr = random.nextInt(max); 
			scaner.write(Integer.toString(nr) + ",");
		}
			
		scaner.close();
	}
	
	
	/*public static int ADEVARAT = 1;
    public static int FALS = 0;
    public boolean metoda(int value) {
    	switch(value) {
    	case ADEVARAT: return true;
    	case FALS: return false; 
    	}
    }*/
	
	public String showData(Object obj) {
		return obj.toString();
	}
	
	// Metoda thread safe
	static int nr;
	public void threadSafe(int x) throws InterruptedException {
		for(int i = 1; i <= x; i++) {
			Runnable runnable = new Runnable() {
				@Override
				public void run() {
					synchronized(Test.class) {
						nr ++;
						System.out.println(nr);
					}
					
				}
			};
			
			Thread thread = new Thread(runnable);
			thread.start();
			thread.sleep(5000);
			
		}
	}
	
	// Lambda expresie
	
	Predicate<String> criteriu = p -> p.length() <= 6; 
	
	public List<String> filtru(List<String> lista, Predicate<String> tester) {
		List<String> rezultat = new ArrayList<String>();
		for(String obj: lista) 
			if(tester.test(obj))
				rezultat.add(obj);
	return rezultat;
	}
	
	void testLambda() {
		
		List<String> multime = new ArrayList<String>();
		multime.add("anaanaaa");
		multime.add("aa");
		multime.add("alex");
		List<String> rezultat = filtru(multime, criteriu);
		System.out.println(rezultat);
	}
	
	// Sfarsit Test1 
	
	
	// Testul2
	
	public boolean method(List<Serializable> colectie, Predicate<Serializable> test, String filename) {
		
		OutputStream os = null;
		try {
			os = new FileOutputStream(filename);
		} catch (FileNotFoundException e2) {
			// TODO Auto-generated catch block
			return false;
		}
		
		ObjectOutputStream oos = null;
		try {
			oos = new ObjectOutputStream(os);
			for(Serializable obj: colectie)
				if(test.test(obj) == true)
						oos.writeObject(obj);
			
		}catch (IOException e1) {
			// TODO Auto-generated catch block
			return false;
		}
		return true;
	}
	
	public JFrame createFrame(String title) {
		
		JFrame frame = new JFrame(title);
		JPanel pane = new JPanel(new GridBagLayout());
		frame.setSize(500,500);
	
		JButton button;
		JLabel text = new JLabel("Text");
		pane.setLayout(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.HORIZONTAL;

		button = new JButton("Button 1");
		c.weightx = 0.5;
		c.fill = GridBagConstraints.HORIZONTAL;
		c.gridx = 0;
		c.gridy = 0;
		pane.add(button, c);

		button = new JButton("Button 2");
		c.fill = GridBagConstraints.HORIZONTAL;
		c.weightx = 0.5;
		c.gridx = 1;
		c.gridy = 0;
		pane.add(button, c);
		
		c.fill = GridBagConstraints.HORIZONTAL;
		c.weightx = 1;
		c.gridx = 0;
		c.gridy = 1;
		pane.add(text, c);
		
		button.addActionListener(new  ActionListener() {

			@Override
			public void actionPerformed(ActionEvent arg0) {
				text.setText("Click!");
			}
		});
		
		frame.setContentPane(pane);
		frame.setVisible(true);
		
		return frame;
	}
	
	
	
	
	// Sfarsit Test2
	public static void modifica(int[] vector) {
		vector[1] = 10;
		System.out.println(vector[1] + " " + vector[0]);
	}
	
	
	public List<Object> functie(Iterable obj, String s)
	{
		List<Object> aux = new ArrayList<Object>();
		for (Object o:obj)
		{
			System.out.println(o);
			if(o.toString().length()<s.length())
				aux.add(o);
		}
		
		return aux;
	}

	
	public static void main(String[] args) throws IOException, InterruptedException {
		/*int[] vector = new int[10];
		modifica(vector);
		System.out.println(vector[1]);
		
		int[][] matrice = new int[10][];
		System.out.println(matrice[1]);
		matrice[1] = new int[10];
		System.out.println(matrice[1][1]); */
		/*
		Test t=new Test();
	    List<String> names = new ArrayList<String>();
	    names.add("Alexandra");
	    names.add("Ana");
	    names.add("A");
	    names.add("Elenaa");
	    
	    List<Integer> numere = new ArrayList<Integer>();
	    numere.add(19);
	    numere.add(194444);
	    numere.add(1);
	    
	    //System.out.println( t.functie(names, "Maria"));
	    System.out.println( t.functie(numere, "Maria"));
	    
	    Integer rez = 0;
	    Integer s = t.SUMA(rez, 3, 5);
	    System.out.println(s + " " + rez);
	    
	    Random random = new Random();
	    System.out.println(random.nextInt(10) + 1);
	    
	    //t.scrie("text.txt", 20, 5);
	    //t.threadSafe(10);
	    t.testLambda();
	    
	    //JFrame frame = t.createFrame("Test");
		return;*/
		
		new Test().showData(4);
	}
}
