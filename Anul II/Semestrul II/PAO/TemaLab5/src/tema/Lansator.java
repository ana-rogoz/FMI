package tema;

import java.util.Stack;

import com.neuralsoft.pao.lab5.InputWindow;
import com.neuralsoft.pao.lab5.MyMatcher;
import com.neuralsoft.pao.lab5.Splitter;

public class Lansator {

	public static void main(String[] arg) {
		InputWindow.getInstance().setSplitHandler(new Splitter(){
	
			@Override
			public String[] split(String string, String pattern) {
				return string.split(pattern);
			}
		});
		
		InputWindow.getInstance().setMatcherHandler(new MyMatcher(){
	
			@Override
			public boolean matches(String string, String pattern) {
				String [] tags = string.split(pattern);
				int n = tags.length;
				Stack stivaTags = new Stack();
				if (n % 2 == 1)
					return false;
				else {
					for (int index = 0; index < n; index ++) {
						System.out.println(tags[index].charAt(1));
						if (tags[index].charAt(1) == '/') {
							tags[index] = new StringBuilder(tags[index]).deleteCharAt(1).toString();
							if(tags[index].equals((String)stivaTags.peek()) == false)
								return false;
							else
								stivaTags.pop();
							//System.out.println(tags[index] + "a dat pop");
						}
						else {
							stivaTags.push(tags[index]);				
							//System.out.println(tags[index] + "a dat push");
						}
					}
				}
				
				if (stivaTags.empty() == true)
					return true;
				else
					return false;
			}
		});
	}
}
