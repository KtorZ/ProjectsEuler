# Sommer deux vecteurs représentant des nombres en base 3
def add3(digits, terme)
    # S'assurer que les deux vecteurs sont de même taille, s'il ne le sont pas, 
    # Empiler des 0 en tête
    diff = digits.length - terme.length
    diff.times{ terme.unshift(0) } if diff > 0
    diff.abs.times{ digits.unshift(0) } if diff < 0

    # Calculer la somme terme à terme des deux vecteurs
    sum = [digits, terme].transpose.map{|a| a.reduce(:+)}

    # Rendre le vecteur conforme, c'est à dire ne présentant que des chiffres < 3
    # Parcourir chaque indice en partant de la fin (poids faibles d'abord)
    for i in 1..sum.length
        # Tant le chiffre courant est strict. supérieur à 2, enlever 3 et ajouter 1 au chiffre précédent
        while sum[-i] > 2
            sum[-i] -= 3
            # Dans le cas ou il n'y a pas de précédent, on vient empiler la retenue
            if i + 1 > sum.length
                sum.unshift(1)
            else
                sum[-i - 1] += 1
            end
        end
    end
    # Retourner la somme
    return sum
end

# Convertir un vecteur représentant un nombre binaire en base 3
def bto3(digits)
    # Out => nombre en base 3 de sortie
    # Diz => valeur courante de la "dizaine" en base 3 ( 2^0 => 001, 2^1 => 002, 2^2 => 011 etc...)
    out = [0]; diz = [1]; length = digits.length
    # Parcourir chaque chiffre en partant de la fin (poids faibles d'abord)
    for i in 1..length
        # Afficher la progression parce qu'on se fait iech pendant le calcul
        print ((i.to_f/length)*100).round(2).to_s + "%\r"
        # Ajouter la valeur de la dizaine courante à notre nombre de sortie. Même principe qu'en base 10, dizaine * chiffre, avec ici
        # le chiffre égal à 1 ou 0
        out = add3(out, diz) if digits[-i] == 1
        # Passer à la dizaine suivante, c-a-d au multiple de 2 suivant. Ce qui revient à s'ajouter à soi-même
        diz = add3(diz, diz)
    end
    # Retourner le vecteur de sortie
    return out
end

digits = []
time = Time.now
# Générer un nombre binaire random
1000.times { digits.push([0,1].shuffle.first) }
p bto3(digits)
puts ((Time.now - time)).to_s + "s"