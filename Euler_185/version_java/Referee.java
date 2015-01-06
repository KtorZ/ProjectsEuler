import java.util.Stack;

public class Referee{
	private boolean[] forbidden;
	private int[] choosen;

	public Referee(int size){
		forbidden = new boolean[size*10];
		choosen = new int[size];
		for(int i = 0; i < size; i++){
			choosen[i] = -1;
			for(int j = 0; j < 10; j++){
				forbidden[i*10+j] = false;
			}
		}
	}

	public void choose(Number number){
		//Tous les autres digits du nombre sont aussi interdits
		for(int i = 0; i < number.getSize(); i++){
			forbidden[i*10 + number.digitAt(i)] = true;
		}
	}

	public void choose(Permutation permutation, Number number){
		//On met à jour les digits choisis
		//Pour chaque position choisie, tous les autres digits deviennent interdits
		int[] indices = permutation.getIndices();
		for(int i = 0; i < indices.length; i++){
			for(int k = 0; k < 10; k++){forbidden[indices[i]*10+k] = true;}
			choosen[indices[i]] = number.digitAt(indices[i]);
		}
		choose(number);
	}

	private boolean isForbidden(int position, int value){
		return choosen[position] != value && forbidden[position*10+value];
	}
	
	public Stack<Permutation> purge(Stack<Permutation> permutations, Number number){
		Stack<Permutation> purged = new Stack<Permutation>();
		boolean wrong; int[] indices; int inserted; int similarity;
		for(Permutation permutation : permutations){
			indices = permutation.getIndices();
			wrong = false; inserted = 0;
			for(int i = 0; i < indices.length; i++){
				wrong = wrong || isForbidden(indices[i], number.digitAt(indices[i]));
				if(choosen[indices[i]] != number.digitAt(indices[i])){inserted++;} 
			}
			similarity = 0;
			for(int i = 0; i < number.getSize(); i++){
				if(number.digitAt(i) == choosen[i]){similarity++;}
			}
			wrong = wrong || similarity+inserted != indices.length;
			if(!wrong){purged.push(permutation);}
		}
		return purged;
	}

	public Number getChoosen(){
		//Recherche des cases restantes non encore définies
		for(int i = 0; i < choosen.length; i++){
			if(choosen[i] == -1){
				for(int k = 0; k < 10; k++){if(!isForbidden(i,k)){choosen[i] = k;}}
			}
		}
		return new Number(choosen);
	}

	public Referee clone(){
		Referee clone = new Referee(choosen.length);
		clone.forbidden = this.forbidden.clone();
		clone.choosen = this.choosen.clone();
		return clone;
	}

	public String toString(){
		String str = "Choosen : "+getChoosen()+"\n";
		for(int j = 0; j < 10; j++){
			for(int i = 0; i < choosen.length; i++){
				if(forbidden[i*10+j]){str += j;
				}else{str += "_";}
			}
			str+="\n";
		}
		return str;
	}
}