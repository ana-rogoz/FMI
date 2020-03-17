import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;

public class Test {
	public static void main(String[] args) {
		new SpecialBulk();
	
	}

	public void functie(OutputStream os) {
		PrintWriter print = new PrintWriter(os);
	    String a = "aaa";
	    String b = "bb";
	    String c = "c";
	    Date data = new Date();
	    print.write(a);
	    print.write(b);
	    print.write(c);
	    print.write(data.toString());
	    
	    print.close();
	}
}
