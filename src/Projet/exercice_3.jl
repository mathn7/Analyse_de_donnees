
donnees = MAT.matread("donnees.mat")
vars = MAT.matread("exercice_2.mat")

figure("Name","Image tiree aleatoirement","Position",[0.2*L,0.2*H,0.6*L,0.5*H])

# Seuil de reconnaissance a regler convenablement
s = 1.0e+00

# Pourcentage d"information 
per = 0.95

# Tirage aleatoire d"une image de test :
individu = randi(37)
posture = randi(6)
chemin = "./Images_Projet_2018"
fichier = [chemin "/" string(individu+3) "-" string(posture) ".jpg"]
Im=importdata(fichier)
I=rgb2gray(Im)
I=im2double(I)
image_test=I(:)'
 

# Affichage de l'image de test :
colormap gray
imagesc(I)


# Nombre N de composantes principales a prendre en compte 
# [dans un second temps, N peut etre calcule pour atteindre le pourcentage
# d"information avec N valeurs propres] :
N = 8

# N premieres composantes principales des images d"apprentissage :
...

# N premieres composantes principales de l"image de test :
...

# Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
...

# Affichage du resultat :
if ...
	individu_reconnu = ...
	title({["Posture numero " string(posture) " de l'individu numero "
        string(individu+3)]...
		["Je reconnais l'individu numero "string(individu_reconnu+3)]},"FontSize",20)
else
	title({["Posture numero " string(posture) " de l'individu numero "
        string(individu+3)]...
		"Je ne reconnais pas cet individu !"},"FontSize",20)
end