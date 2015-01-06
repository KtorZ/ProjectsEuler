import java.util.Stack;
import java.util.ArrayList;
import java.lang.reflect.Array;

public class Solver{
	public static Rule[] rules;
	public static Stack<Permutation>[] permutations;
	public static int step = 0;

	public static synchronized void incr_step(){
		step++;
	}

	public static synchronized int get_step(){
		return step;
	}
	public static void parallel_solve(final Referee referee, final int floor, int nb_thread){
		final long start = System.currentTimeMillis();
		final Rule rule = rules[floor];
		Stack<Permutation> moves = referee.purge(permutations[rule.getWeight()-1], rule.getNumber());
		int nb_moves = moves.size();
		final ArrayList<Stack<Permutation>> list_moves = new ArrayList<Stack<Permutation>>();
		for(int i = 0; i < nb_thread; i++){
			list_moves.add(i, new Stack<Permutation>());
		}

		for(int k = 0; k < nb_moves/nb_thread; k++){
			for(int i = 0; i < nb_thread; i++){
				list_moves.get(i).push(moves.pop());
			}
		}
		for(int i = 0; i < nb_thread; i++){
			System.out.println(list_moves.get(i));
		}

		for(int i = 0; i < nb_thread; i++){
			final int num_thread = i;
			new Thread(new Runnable(){
				public void run(){
					Permutation move;
					Stack<Permutation> moves = list_moves.get(num_thread);
					while(!moves.empty()){
						move = moves.pop();
						System.out.println(move);
						Referee referee_child = referee.clone();
						referee_child.choose(move, rule.getNumber());
						Number number = solve(referee_child, floor+1);
						if(number != null){
							System.out.println(number);
							System.out.println((System.currentTimeMillis()-start)+"ms et "+get_step()+" itérations.");
							return;
						}
					}
				}
			}).start();
		}
	}

	public static Number solve(Referee referee, int floor){
		incr_step();

		if(floor >= rules.length){return referee.getChoosen();}
		Rule rule = rules[floor];
		Stack<Permutation> moves = referee.purge(permutations[rule.getWeight()-1], rule.getNumber());
		if(floor == 0){System.out.println(moves);}
		Permutation move;
		while(!moves.empty()){
			move = moves.pop();
			if(floor == 0){System.out.println(move);}
			Referee referee_child = referee.clone();
			referee_child.choose(move, rule.getNumber());
			Number number = solve(referee_child, floor+1);
			if(number != null){
				// System.out.println("Floor #"+floor);
				// System.out.println(referee);
				// System.out.println(rule);
				// System.out.println(move);
				// System.out.println("\n");
				return number;
			}
		}
		return null;
	}

	public static Rule[] parseRules(String data){
		String[] lines = data.split(" correct");
		Rule[] rules = new Rule[lines.length];
		String[] splited;
		for(int i = 0; i < lines.length; i++){
			splited = lines[i].split(" ;");
			rules[i] = new Rule(new Number(splited[0]), Character.getNumericValue(splited[1].charAt(0)));
		}
		return rules;
	}

	public static void main(String args[]){
		String data = "5616185650518293 ;2 correct"+ 
			"3847439647293047 ;1 correct"+ //-----------
			"5855462940810587 ;3 correct"+
			"9742855507068353 ;3 correct"+
			"4296849643607543 ;3 correct"+
			"3174248439465858 ;1 correct"+ //-----------
			"4513559094146117 ;2 correct"+
			"7890971548908067 ;3 correct"+
			"8157356344118483 ;1 correct"+ //-----------
			"2615250744386899 ;2 correct"+ //-----------
			"8690095851526254 ;3 correct"+
			"6375711915077050 ;1 correct"+
			"6913859173121360 ;1 correct"+
			"6442889055042768 ;2 correct"+
			"2321386104303845 ;0 correct"+
			"2326509471271448 ;2 correct"+
			"5251583379644322 ;2 correct"+
			"1748270476758276 ;3 correct"+
			"4895722652190306 ;1 correct"+
			"3041631117224635 ;3 correct"+
			"1841236454324589 ;3 correct"+
			"2659862637316867 ;2 correct";

		// data = "90342 ;2 correct"+
		// "70794 ;0 correct"+
		// "39458 ;2 correct"+
		// "34109 ;1 correct"+
		// "51545 ;2 correct"+
		// "12531 ;1 correct";

		rules = parseRules(data);
		Referee referee = new Referee(rules[0].getNumber().getSize());
		Stack<Rule> buffer = new Stack<Rule>();
		int max_weight = 0; int weight;
		for(int i = 0; i < rules.length; i++){
			weight = rules[i].getWeight();
			if(weight == 0){
				referee.choose(rules[i].getNumber());
			}else{
				max_weight = (weight > max_weight) ? weight : max_weight;
				buffer.push(rules[i]);
			}
		}
		rules = new Rule[buffer.size()];
		for(int i = 0; i < rules.length; i++){
			rules[i] = buffer.pop();
		}

		//PréCalcul des permutations
		try{
			permutations = (Stack<Permutation>[]) Array.newInstance(Class.forName("java.util.Stack"), max_weight);
			for(int i = 0; i < max_weight; i++){
				permutations[i] = Permutation.generate(rules[0].getNumber().getSize(), i+1);
			}
		}catch(Exception e){e.printStackTrace();}

		// parallel_solve(referee, 0, 1);
		solve(referee, 0);
	}
}
