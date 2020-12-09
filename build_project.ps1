# Script de création de projet symfony : build_project v1.1
# Par Nassim AHMED ALI - @Neguro

$projectPath = Read-Host "Ou voulez vous créer votre projet ? "
Set-Location $projectPath
$projectName  = Read-Host "Entrez le nom de votre projet symfony "
$symfonyVersion = Read-Host "Version de symfony a installer "
$symfonyProject = Read-Host "skeleton ou website "

if ($symfonyProject -eq "skeleton")
{
     composer create-project symfony/skeleton:~$symfonyVersion $projectName

     # Installation des recipes 
     Set-Location $projectName
     Write-Host "============= Installation des Recipes ============"

     composer require symfony/maker-bundle
     composer require symfony/apache-pack
     composer require sensio/framework-extra-bundle 
     composer require symfony/profiler-pack
     composer require symfony/twig-bundle
     composer require symfony/asset 
     composer require symfony/form			
     composer require symfony/validator 
     composer require symfony/orm-pack
     composer require symfony/security-bundle

}
elseif ($symfonyProject -eq "website")
{
     composer create-project symfony/website-skeleton:~$symfonyVersion $projectName
     Set-Location $projectName
}


$installRecipes = Read-Host "Voulez vous installer des recipes supplementaire (y ou n) ?"
if ($installRecipes -eq "y")
{
     while($recipes = Read-Host "Nom de la recipe a installer (ex : symfony/form)")
     {
          composer require $packages
     }
}
elseif ($installRecipes -eq "n")
{
     Write-Host "Aucune recipe supplémentaire ne sera installer `n"
}

Write-Host "============= Installation de symfony terminer ============ `n"

# Création du dépot git et premier commit
Write-Host "============ Création du dépot git ============`n"
git init
git add .
git commit -m"Premier commit du projet symfony : $projectName"
Write-Host "============ Dépot local git crée =============`n"


# Sync et push avec le depot github distant
Write-Host "============= Push du dépot local vers le dépot distant =============="
$githubLink = Read-Host "Lien du dépot github (format : https://github.com/user/nom_depot.git ) "
git remote add origin $githubLink
git push -u origin master
Write-Host "`n Push du dépot local vers le dépot distant effectuer"