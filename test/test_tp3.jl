
@testset "Tests TP3" begin
    
    # donnees
    cheminTP3 = "../src/TP3/"
    fleurs = ["pensees","oeillets","chrysanthemes"]
    donnees   = matread(cheminTP3*"mat/donnees.mat")
    tol_erreur = 1e-5
    include(cheminTP3*"couleur_moyenne.jl")
    include(cheminTP3*"estimation_mu_sigma.jl")
    include(cheminTP3*"vraisemblance.jl")
    include(cheminTP3*"moyenne_amelioree.jl")

    include(cheminTP3*"exercice_1.jl")
    include(cheminTP3*"exercice_2.jl")
    include(cheminTP3*"exercice_3.jl")
    include(cheminTP3*"exercice_3_bis.jl")
    include(cheminTP3*"exercice_4.jl")

    # tester l'exercice 1
    @testset "Tests exo 1" begin
        tp3_exercice1(false,cheminTP3)
        solutions = matread(cheminTP3*"mat/solutions-ex1.mat")

        @testset "couleur_moyenne" for fleur in fleurs
            @testset "X_$fleur" for i = 1:Integer(donnees["nb_images_$fleur"])
                im = donnees[fleur[1:2] * string(i)]
                @test solutions["X_$fleur"][i,:] ≈ tp3_couleur_moyenne(im) atol = tol_erreur
            end
        end

    end

    # tester l'exercice 2
    @testset "Tests exo 2" begin 
        tp3_exercice2(false,cheminTP3)
        solutions = matread(cheminTP3*"mat/solutions-ex2.mat")

        r = solutions["r"][:]
        v = solutions["v"][:]

        @testset "vraisemblance et estimation: $fleur" for fleur in fleurs  
            mu, Sigma        = tp3_estimation_mu_sigma(solutions["X_"*fleur])
            vr, denominateur = tp3_vraisemblance([r v], solutions["mu_"*fleur], solutions["Sigma_"*fleur], -1)
            @test solutions["mu_"*fleur]                   ≈ mu  atol = tol_erreur
            @test solutions["Sigma_"*fleur]                ≈ Sigma  atol = tol_erreur              
            @test solutions["V_"*fleur]                    ≈ vr atol = tol_erreur
            @test solutions["denominateur_classe_"*fleur]  ≈ denominateur  atol = tol_erreur
        end
    end

    # tester l'exercice 3
    @testset "Tests exo 3" begin 
        @test 76.67 ≈ tp3_exercice3(false,cheminTP3) atol = 1
        @test 83.33 ≈ tp3_exercice3bis(false,cheminTP3,[.5, .3, .2]) atol = 1
        solutions_ex2 = matread(cheminTP3*"mat/solutions-ex2.mat")
        solutions_ex3 = matread(cheminTP3*"mat/solutions-ex3.mat")
        
        # nous allons tester juste par rapport à la première classe
        X = solutions_ex2["X_pensees"]
        
        fleur = fleurs[2]
        mu = solutions_ex2["mu_"*fleur]
        Sigma = solutions_ex2["Sigma_"*fleur]
        denominateur = solutions_ex2["denominateur_classe_"*fleur]

        for i in 1:Integer(donnees["nb_images_"*fleur])            
            V_classe,_ = tp3_vraisemblance(X[i,:],mu,Sigma,denominateur)
            @test solutions_ex3["V_classe_"*fleur][i] ≈ V_classe atol = tol_erreur
        end 
    end

    # tester l'exercice 4
    @testset "Tests exo 4" begin
        solutions = matread(cheminTP3*"mat/solutions-ex4.mat")
        @test 100. ≈ tp3_exercice4(false,cheminTP3) atol = 1 # test accuracy == 100 %               
        @testset "couleur moyenne: $fleur" for fleur in fleurs  
            for i = 1:Integer(donnees["nb_images_$fleur"])
                im = donnees[fleur[1:2] * string(i)]
                @test solutions["X_$fleur"][i,:] ≈ tp3_moyenne_amelioree(im) atol = tol_erreur
            end
        end
    end
    rm(cheminTP3*"mat/resultats-ex1.mat",force = true)
    rm(cheminTP3*"mat/resultats-ex2.mat",force = true)

end